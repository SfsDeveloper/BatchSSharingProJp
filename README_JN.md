# BatchSSharingProJp
*"SSharing Pro JP"*&ensp;をコマンドラインで使用するためのバッチファイルを集めました。*"SSharing Pro JP"*&ensp;は、 (k,n) しきい値秘密分散法を利用した新しい形の暗号化ソフトです。<br>

# *SSharing Pro JP* とは
*"SSharing Pro JP"*&ensp;は、 (k,n) しきい値秘密分散法を利用した新しい形の暗号化ソフトです。<br>
*"SSharing Pro JP"*&ensp;は有料です。無料お試し期間があります。<br>
<br>
無料版の&ensp;*"SSharing Free"*&ensp;もあります。<br>
但し、無料版ではコマンドラインによる利用はできません。

# 参照
*"SSharing Pro JP"*&ensp;については以下も参照ください。<br>
[*SSharing Pro JP* 公式ページ](https://www.sfellow.co.jp/product/SSharing/)


# 詳細
*"SSharing Pro JP"*&ensp;はWindows上で動作するアプリケーションです。<br>
`C:\Program Files\WindowsApps`にインストールされますが、このフォルダのアプリケーションをコマンドラインで実行しようとしても、直接 EXE ファイルを指定することはできません。<br>
コマンドラインで実行するときには次のような制約があります。

1.	コマンドが長い<br>
コマンドラインから起動する場合は、次のように入力しなければなりません。<br>
これはとても長く煩わしいコマンドになります。<br>
`start shell:AppsFolder\PackageFamilyName!ApplicationId`
注意：「PackageFamilyName」と「ApplicationId」は、アプリケーションによって異なります。

1.	カレントディレクトリが固定<br>
カレントディレクトリが常に`C:\WINDOWS\system32`になります。今までコマンドラインを利用してきた人にとって、これは使いにくい環境です。

1.	処理を待たない<br>
バッチファイルで実行した場合、処理の完了を待たずに次の手順に進みます。分散後に分散ファイルをコピーするようなバッチファイルを作成しても、分散ファイルをコピーするときにまだ分散処理は終わっていないことになります。これではバッチファイルにする効果が激減します。

これらの点を解決するための PowerShellスクリプト`SSharing.ps1`を用意しました。

# 特殊オプション
上記2と3は、スクリプトやバッチファイルだけでは解決できません。*"SSharing Pro JP"*&ensp;は、これらに対応するための特殊オプションを持っています。

### -cur オプション<br>
カレントディレクトリを指定するためのオプションです。<br>
`SSharing.ps1`は、カレントディレクトリに「スクリプトを実行したディレクトリ」を指定します。

### -event オプション<br>
*"SSharing Pro JP"*&ensp;と同期するためのオプションです。<br>
`SSharing.ps1`は&ensp;*"SSharing Pro JP"*&ensp;が完了するまで処理を終了しません。<br>
次の手順で"SSharing Pro JP"と同期します。<br>
イベント名称「xxx」は自由に選択できます。<br>

 1. 名称「xxx」のEventを生成します。<br>
 1. 名称「xxx_2」のMutexを生成します。<br>
 1. オプション「"-event xxx"」を指定して*"SSharing Pro JP"*を実行します。<br>
 1. Eventを待ちます。<br>
 1. Mutexを待ちます。<br>

# 「SSharing.ps1」の使い方
`_ReadMe.txt`を分散する場合、コマンドラインで次のように入力します。
```
powershell -Command "& './SSharing.ps1'" -cmd -encode -en_n 5 -en_k 3 _ReadMe.txt
```

注意：次のファイルをカレントディレクトリに置いて実行してください。<br>
SSharing.ps1<br>
_ReadMe.txt

# Batch Files
### Base
「Base」フォルダには、*"SSharing Pro JP"*&ensp;のオプション毎にバッチファイルを用意しました。<br>
オプションの指定方法がわからない場合、これらのファイルからコピーして使用してください。
  
### VariousUses
「VariousUses」フォルダには、用途に応じたもう少し高度なバッチファイルを用意しました。
  
- Daily<br>
出力ファイルに日付と時刻を埋め込みます。<br>
毎日のバックアップに使用することを目的として分散を実行する場合に便利です。
    
- Distribute<br>
「Data」フォルダを3つに分散し、1つを`Wドライブ`に、もう一つを`Yドライブ`に移動します。<br>
また、`Wドライブ`、`Yドライブ`から分散ファイルを回収して再構築もできます。
    
- Drag<br>
バッチファイルにドラッグすることで、分散、再構築します。
    
- Folder<br>
バッチファイルをダブルクリックすることで、特定のフォルダを分散、再構築します。

# Lisence
MIT License
