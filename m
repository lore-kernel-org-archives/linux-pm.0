From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: About run time power management in linux
Date: Thu, 1 Jul 2010 19:24:14 +0530
Message-ID: <BLU102-W760DF7F1EFCA2517505ABEBCD0@phx.gbl>
References: <BLU102-W15580CBC32130E58FED981EBCC0@phx.gbl>,
	<Pine.LNX.4.44L0.1006301225040.1707-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2514773772379988683=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006301225040.1707-100000@iolanthe.rowland.org>
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
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============2514773772379988683==
Content-Type: multipart/alternative;
	boundary="_3d0c54ea-72ab-4964-af2f-33b1cf0d3772_"

--_3d0c54ea-72ab-4964-af2f-33b1cf0d3772_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20

Hi Alan=2C

=20

I have seen in run time power management helper functions. I have some ques=
tions during deep sleep modes

and runtime sleep modes.

=20

1) I have seen the code and found that when System wants to go to suspend (=
deep sleep mode)=2C it has to check for

pm_runtime_barrier which inturn sees if there is a pending runtime resume t=
hen it will not allow system to supend.

So it means system suspend can not be done forcefully if the some periphera=
l jobs are running=2C correct?

=20

2) it means when System deep sleep is going on=2C run time suspend will nev=
er come to peripheral as it checks for usage counter and

if it is zero then it will ask try again.

=20

3) if run time suspend is going on=2C  Then if system wants to go into deep=
 sleep mode=2C it will wait for run time suspend to finish and then=20

gracefully do the shutdown. correct?

=20

4) Is it mandatory for peripheral driver but not the bus driver to implemen=
t runtime_idle operation?

=20

RegardsRaj

=20

=20

=20

=20

=20

=20

=20

=20

=20


=20
> Date: Wed=2C 30 Jun 2010 12:25:21 -0400
> From: stern@rowland.harvard.edu
> To: rajkumar278@hotmail.com
> CC: linux-pm@lists.linux-foundation.org
> Subject: RE: [linux-pm] About run time power management in linux
>=20
> On Wed=2C 30 Jun 2010=2C Raj Kumar wrote:
>=20
> > Hi Alan=2C
> >=20
> >=20
> >=20
> > First thanks for reply. ok as also seems to be in runtime.c=2C if devic=
e wants to suspend and resume
> >=20
> >=20
> >=20
> > then device will call helper functions for pm core like pm_runtime_susp=
end and pm_runtime_resume=2C
> >=20
> >=20
> >=20
> > which internally calls the runtime_resume of the bus and which in turn =
calls the runtime_resume of the driver.
> >=20
> >=20
> >=20
> > correct ?
>=20
> Yes.
>=20
> Alan Stern
>=20
 		 	   		  =

--_3d0c54ea-72ab-4964-af2f-33b1cf0d3772_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
&nbsp=3B<BR>
Hi Alan=2C<BR>
&nbsp=3B<BR>
I have seen in&nbsp=3Brun time power management helper functions. I have so=
me questions during deep sleep modes<BR>
and runtime sleep modes.<BR>
&nbsp=3B<BR>
1)&nbsp=3BI have seen the code and found that when System wants to go to su=
spend (deep sleep mode)=2C it has to check for<BR>
pm_runtime_barrier which inturn sees if there is a pending runtime resume t=
hen it will not allow system to supend.<BR>
So it means system suspend can not be done forcefully&nbsp=3Bif the&nbsp=3B=
some peripheral jobs are running=2C correct?<BR>
&nbsp=3B<BR>
2) it means when System deep sleep is going on=2C run time suspend will nev=
er come&nbsp=3Bto peripheral as it checks for usage counter and<BR>
if it is zero then it will ask try again.<BR>
&nbsp=3B<BR>
3) if run time suspend is going on=2C &nbsp=3BThen if system wants to go in=
to deep sleep mode=2C it will wait for run time suspend to finish and then =
<BR>
gracefully do the shutdown. correct?<BR>
&nbsp=3B<BR>
4) Is it mandatory for peripheral driver but not the bus driver to implemen=
t runtime_idle operation?<BR>
&nbsp=3B<BR>
RegardsRaj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>&gt=3B Date: Wed=2C 30 Jun 2010 12:25:21 -0400<BR>&gt=3B Fr=
om: stern@rowland.harvard.edu<BR>&gt=3B To: rajkumar278@hotmail.com<BR>&gt=
=3B CC: linux-pm@lists.linux-foundation.org<BR>&gt=3B Subject: RE: [linux-p=
m] About run time power management in linux<BR>&gt=3B <BR>&gt=3B On Wed=2C =
30 Jun 2010=2C Raj Kumar wrote:<BR>&gt=3B <BR>&gt=3B &gt=3B Hi Alan=2C<BR>&=
gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B First th=
anks for reply. ok as also seems to be in runtime.c=2C if device wants to s=
uspend and resume<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>=
&gt=3B &gt=3B then device will call helper functions for pm core like pm_ru=
ntime_suspend and pm_runtime_resume=2C<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <=
BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B which internally calls the runtime_resum=
e of the bus and which in turn calls the runtime_resume of the driver.<BR>&=
gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B correct =
?<BR>&gt=3B <BR>&gt=3B Yes.<BR>&gt=3B <BR>&gt=3B Alan Stern<BR>&gt=3B <BR> =
		 	   		  </body>
</html>=

--_3d0c54ea-72ab-4964-af2f-33b1cf0d3772_--

--===============2514773772379988683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2514773772379988683==--
