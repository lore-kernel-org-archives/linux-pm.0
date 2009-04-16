From: Sam Shang <sam_s_shang@hotmail.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api
Date: Thu, 16 Apr 2009 14:00:35 +0800
Message-ID: <BAY123-W42BB353AA5E68DFC09E11AB07A0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7664893916163317537=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============7664893916163317537==
Content-Type: multipart/alternative;
	boundary="_4e6dcd85-f65f-4f31-b9fe-d199d95486c5_"

--_4e6dcd85-f65f-4f31-b9fe-d199d95486c5_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Arve=2C
=20
I can see the usage of suspend blockers from the example you described belo=
w. I understand how applications can make use of suspend blockers to save p=
ower. Still=2C my first rule of their usage is don't use them unless necess=
ary=2C as their misuse might cause increase of power usage.
=20
I'm wondering whether you have a recommended rule of suspend blocker usage =
for both applications and drivers. From application and driver development =
point of view=2C I don't want to add suspend blockers everywhere.
=20
Sam Shang
=20
*******************
Date: Wed=2C 15 Apr 2009 17:34:43 -0700
From: Arve Hj?nnev?g <arve@android.com>
Subject: Re: [linux-pm] [PATCH 1/8] PM: Add suspend block api.
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ncunningham@crca.org.au=2C u.luckas@road.de=2C swetland@google.com=2C
        Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Message-ID:
        <d6200be20904151734o738c7a5dx52a800b97ebc2708@mail.gmail.com>
Content-Type: text/plain=3B charset=3DISO-8859-1
=20
2009/4/15 Alan Stern <stern@rowland.harvard.edu>:
> On Tue=2C 14 Apr 2009=2C [utf-8] Arve Hj?nnev?g wrote:
>=20
>> +Suspend blockers can be used to allow user-space to decide which keys s=
hould
>=20
> Then in the last section=2C say this:
>=20
> ? ? ?- The user-space input-event thread returns from read. If it
> ? ? ? ?determines that the key should leave the screen off=2C it
> ? ? ? ?calls suspend_unblock on the process_input_events
> ? ? ? ?suspend_blocker and then calls select or poll. ?The system
> ? ? ? ?will automatically suspend again=2C since now no suspend blockers
> ? ? ? ?are active.
>=20
=20
This sounds reasonable too me.
=20
--=20
Arve Hj?nnev?g
_________________________________________________________________
More than messages=96check out the rest of the Windows Live=99.
http://www.microsoft.com/windows/windowslive/=

--_4e6dcd85-f65f-4f31-b9fe-d199d95486c5_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3><SPAN lang=3DEN-US><FONT face=
=3DCalibri color=3D#000000 size=3D3>Arve</FONT></SPAN>=2C</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3></FONT></SPAN>&nbsp=3B</P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>I can see the usage of suspend =
blockers from the example you described below. I understand how application=
s can make use of suspend blockers to save power.&nbsp=3BStill=2C my first =
rule of their usage is don't use them unless necessary=2C as their misuse m=
ight cause increase of power usage.</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3></FONT></SPAN>&nbsp=3B</P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>I'm wondering whether you have =
a recommended rule of suspend blocker usage for both applications and drive=
rs. From application and driver development point of view=2C I don't want t=
o add suspend blockers everywhere.</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3></FONT></SPAN>&nbsp=3B</P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>Sam Shang</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3></FONT></SPAN>&nbsp=3B</P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>*******************</FONT></SPA=
N></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>Date: Wed=2C 15 Apr 2009 17:34:=
43 -0700</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>From: Arve Hj?nnev?g &lt=3Barve=
@android.com&gt=3B</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>Subject: Re: [linux-pm] [PATCH =
1/8] PM: Add suspend block api.</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>To: Alan Stern &lt=3Bstern@rowl=
and.harvard.edu&gt=3B</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>Cc: ncunningham@crca.org.au=2C =
u.luckas@road.de=2C swetland@google.com=2C</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT size=3D3><FONT color=3D#000000><FONT face=3DCalibri><SPAN style=3D"mso-=
tab-count: 1">&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B </SP=
AN>Linux-pm mailing list &lt=3Blinux-pm@lists.linux-foundation.org&gt=3B</F=
ONT></FONT></FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>Message-ID:</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT size=3D3><FONT color=3D#000000><FONT face=3DCalibri><SPAN style=3D"mso-=
tab-count: 1">&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B </SP=
AN>&lt=3Bd6200be20904151734o738c7a5dx52a800b97ebc2708@mail.gmail.com&gt=3B<=
/FONT></FONT></FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>Content-Type: text/plain=3B cha=
rset=3DISO-8859-1</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><?=
xml:namespace prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office"=
 /><o:p><FONT face=3DCalibri color=3D#000000 size=3D3>&nbsp=3B</FONT></o:p>=
</SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>2009/4/15 Alan Stern &lt=3B</FO=
NT><A href=3D"mailto:stern@rowland.harvard.edu"><FONT face=3DCalibri size=
=3D3>stern@rowland.harvard.edu</FONT></A><FONT face=3DCalibri color=3D#0000=
00 size=3D3>&gt=3B:</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B On Tue=2C 14 Apr 2009=2C=
 [utf-8] Arve Hj?nnev?g wrote:</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT size=3D3><FONT color=3D#000000><FONT face=3DCalibri>&gt=3B<o:p>&nbsp=3B=
</o:p></FONT></FONT></FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B&gt=3B +Suspend blockers =
can be used to allow user-space to decide which keys should</FONT></SPAN></=
P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT size=3D3><FONT color=3D#000000><FONT face=3DCalibri>&gt=3B<o:p>&nbsp=3B=
</o:p></FONT></FONT></FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B Then in the last section=
=2C say this:</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT size=3D3><FONT color=3D#000000><FONT face=3DCalibri>&gt=3B<o:p>&nbsp=3B=
</o:p></FONT></FONT></FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B ? ? ?- The user-space in=
put-event thread returns from read. If it</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B ? ? ? ?determines that t=
he key should leave the screen off=2C it</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B ? ? ? ?calls suspend_unb=
lock on the process_input_events</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B ? ? ? ?suspend_blocker a=
nd then calls select or poll. ?The system</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B ? ? ? ?will automaticall=
y suspend again=2C since now no suspend blockers</FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>&gt=3B ? ? ? ?are active.</FONT=
></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT size=3D3><FONT color=3D#000000><FONT face=3DCalibri>&gt=3B<o:p>&nbsp=3B=
</o:p></FONT></FONT></FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><o=
:p><FONT face=3DCalibri color=3D#000000 size=3D3>&nbsp=3B</FONT></o:p></SPA=
N></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>This sounds reasonable too me.<=
/FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><o=
:p><FONT face=3DCalibri color=3D#000000 size=3D3>&nbsp=3B</FONT></o:p></SPA=
N></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3>-- </FONT></SPAN></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><F=
ONT face=3DCalibri color=3D#000000 size=3D3><SPAN lang=3DEN-US><FONT face=
=3DCalibri color=3D#000000 size=3D3>Arve</FONT></SPAN> Hj?nnev?g</FONT></SP=
AN></P><br /><hr />check out the rest of the Windows Live=99.
More than mail=96Windows Live=99 goes way beyond your inbox.
 <a href=3D'http://www.microsoft.com/windows/windowslive/' target=3D'_new'>=
More than messages</a></body>
</html>=

--_4e6dcd85-f65f-4f31-b9fe-d199d95486c5_--

--===============7664893916163317537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7664893916163317537==--
