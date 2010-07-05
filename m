From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: About run time power management in linux
Date: Mon, 5 Jul 2010 14:27:27 +0530
Message-ID: <BLU102-W532408CF4DA1EA7664EDAEBB10@phx.gbl>
References: <BLU102-W760DF7F1EFCA2517505ABEBCD0@phx.gbl>,
	<Pine.LNX.4.44L0.1007011000340.1596-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3836758528184445479=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007011000340.1596-100000@iolanthe.rowland.org>
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

--===============3836758528184445479==
Content-Type: multipart/alternative;
	boundary="_f1946338-557e-4647-b52a-26cbd492a2ce_"

--_f1946338-557e-4647-b52a-26cbd492a2ce_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Alan=2C

=20

I have few more questions about run time power management:

=20

1) Please correct me if i am wrong. If there is a bus driver that is managi=
ng various power domains=2C

and suppose this domain has some child devices.=20

=20

Then child has to inform run time Power management core i am idle and i wan=
t to go to get suspended=2C

=20

then run time pm core will notify the bus driver of child and then bus driv=
er calls the corresponding child's

=20

suspend. right?

=20

2) run time power management can be done at device "type" and "class". But =
what does mean of this device

type. what use cases are defined for run time power management for device "=
type"?

=20

Regards

Raj

=20

=20

=20

=20

=20


=20
> Date: Thu=2C 1 Jul 2010 10:03:46 -0400
> From: stern@rowland.harvard.edu
> To: rajkumar278@hotmail.com
> CC: linux-pm@lists.linux-foundation.org
> Subject: RE: [linux-pm] About run time power management in linux
>=20
> On Thu=2C 1 Jul 2010=2C Raj Kumar wrote:
>=20
> > Hi Alan=2C
> >=20
> >=20
> >=20
> > I have seen in run time power management helper functions. I have some =
questions during deep sleep modes
> >=20
> > and runtime sleep modes.
> >=20
> >=20
> >=20
> > 1) I have seen the code and found that when System wants to go to suspe=
nd (deep sleep mode)=2C it has to check for
> >=20
> > pm_runtime_barrier which inturn sees if there is a pending runtime resu=
me then it will not allow system to supend.
> >=20
> > So it means system suspend can not be done forcefully if the some perip=
heral jobs are running=2C correct?
>=20
> Yes. The system suspend will have to wait until the runtime PM=20
> activity is finished.
>=20
> > 2) it means when System deep sleep is going on=2C run time suspend will=
 never come to peripheral as it checks for usage counter and
> >=20
> > if it is zero then it will ask try again.
>=20
> Basically yes=2C although you have the reason backward. If the usage=20
> count is _non-zero_ then runtime suspend won't occur.
>=20
> > 3) if run time suspend is going on=2C Then if system wants to go into d=
eep sleep mode=2C it will wait for run time suspend to finish and then=20
> >=20
> > gracefully do the shutdown. correct?
>=20
> Yes.
>=20
> > 4) Is it mandatory for peripheral driver but not the bus driver to impl=
ement runtime_idle operation?
>=20
> None of these are mandatory=3B it all depends on the bus subsystem.=20
> Some subsystems don't implement runtime PM at all.
>=20
> Alan Stern
>=20
 		 	   		  =

--_f1946338-557e-4647-b52a-26cbd492a2ce_
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
Hi Alan=2C<BR>
&nbsp=3B<BR>
I have few more questions about&nbsp=3Brun time power management:<BR>
&nbsp=3B<BR>
1) Please correct me if i am wrong.&nbsp=3BIf there is a bus driver that is=
 managing various power domains=2C<BR>
and suppose this domain has some child devices. <BR>
&nbsp=3B<BR>
Then child has to inform run time Power management core i am idle and i wan=
t to go to get suspended=2C<BR>
&nbsp=3B<BR>
then run time pm core will notify the bus driver of child and then bus driv=
er calls the corresponding child's<BR>
&nbsp=3B<BR>
suspend. right?<BR>
&nbsp=3B<BR>
2) run time power management can be done at device "type" and "class". But =
what does mean of this device<BR>
type. what use cases are defined for run time power management for device "=
type"?<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>&gt=3B Date: Thu=2C 1 Jul 2010 10:03:46 -0400<BR>&gt=3B Fro=
m: stern@rowland.harvard.edu<BR>&gt=3B To: rajkumar278@hotmail.com<BR>&gt=
=3B CC: linux-pm@lists.linux-foundation.org<BR>&gt=3B Subject: RE: [linux-p=
m] About run time power management in linux<BR>&gt=3B <BR>&gt=3B On Thu=2C =
1 Jul 2010=2C Raj Kumar wrote:<BR>&gt=3B <BR>&gt=3B &gt=3B Hi Alan=2C<BR>&g=
t=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B I have se=
en in run time power management helper functions. I have some questions dur=
ing deep sleep modes<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B and runtime sleep m=
odes.<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B 1) I have seen the code and found that when System wants to go to suspe=
nd (deep sleep mode)=2C it has to check for<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B pm_runtime_barrier which inturn sees if there is a pending runtime resu=
me then it will not allow system to supend.<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B So it means system suspend can not be done forcefully if the some perip=
heral jobs are running=2C correct?<BR>&gt=3B <BR>&gt=3B Yes. The system sus=
pend will have to wait until the runtime PM <BR>&gt=3B activity is finished=
.<BR>&gt=3B <BR>&gt=3B &gt=3B 2) it means when System deep sleep is going o=
n=2C run time suspend will never come to peripheral as it checks for usage =
counter and<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B if it is zero then it will a=
sk try again.<BR>&gt=3B <BR>&gt=3B Basically yes=2C although you have the r=
eason backward. If the usage <BR>&gt=3B count is _non-zero_ then runtime su=
spend won't occur.<BR>&gt=3B <BR>&gt=3B &gt=3B 3) if run time suspend is go=
ing on=2C Then if system wants to go into deep sleep mode=2C it will wait f=
or run time suspend to finish and then <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B =
gracefully do the shutdown. correct?<BR>&gt=3B <BR>&gt=3B Yes.<BR>&gt=3B <B=
R>&gt=3B &gt=3B 4) Is it mandatory for peripheral driver but not the bus dr=
iver to implement runtime_idle operation?<BR>&gt=3B <BR>&gt=3B None of thes=
e are mandatory=3B it all depends on the bus subsystem. <BR>&gt=3B Some sub=
systems don't implement runtime PM at all.<BR>&gt=3B <BR>&gt=3B Alan Stern<=
BR>&gt=3B <BR> 		 	   		  </body>
</html>=

--_f1946338-557e-4647-b52a-26cbd492a2ce_--

--===============3836758528184445479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3836758528184445479==--
