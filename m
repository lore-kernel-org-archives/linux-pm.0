From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Runtime power management during system resume
Date: Wed, 25 Aug 2010 18:57:12 +0530
Message-ID: <BLU102-W296D98B5535DEC8A7A973EB840@phx.gbl>
References: <BLU102-W1030ED196ED7B94722F2A7EB830@phx.gbl>,
	<Pine.LNX.4.44L0.1008241029000.1652-100000@iolanthe.rowland.org>,
	<BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6987817823827695137=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>
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
To: stern@rowland.harvard.edu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============6987817823827695137==
Content-Type: multipart/alternative;
	boundary="_59fc4dd1-58a3-4d10-ab7d-73466f611d45_"

--_59fc4dd1-58a3-4d10-ab7d-73466f611d45_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi Alan=2C

Thanks for quick replies. As you said

=20


> >> 2) Suppose device is active=2C means its power_usage counter is alread=
y one=2C Now during system
> >> sleep=2C does the driver first suspend it with run time power manageme=
nt core and then continue
> >> System suspend?
> >
{ALAN}  No.

=20

=20

But since during system suspend power_usage counter is incremented by 1 But=
 if the device is active

means its state is RPM_ACTIVE=2C its power_usage counter is 1 in run time p=
ower management core.

=20

when the system suspend happens=2C it will also increment the power_usage_c=
ounter by 1 during dpm_prepare

=20

Now   the power_usage_counter is 2.

=20

So when dpm_complete is invoked=2C it will decrement the power_usage_counte=
r by 1 during dpm_complete.

=20

So now when the drivers gets system suspend=2C its power_usage counter is s=
till 1.

=20

So what in this scenario=2C does the device decrements the power_usage coun=
ter itself?

=20

Thanks

Raj









>
>
>
> ----------------------------------------
> > Date: Tue=2C 24 Aug 2010 10:30:25 -0400
> > From: stern@rowland.harvard.edu
> > To: rajkumar278@hotmail.com
> > CC: linux-kernel@vger.kernel.org
> > Subject: Re: Runtime power management during system resume
> >
> > On Tue=2C 24 Aug 2010=2C Raj Kumar wrote:
> >
> >> Hi Alan=2C
> >>
> >> I have implemented the run time power management in my drivers. I have=
 one
> >> issue regarding System resume.
> >>
> >> When the system sleep is triggered as it is mentioned that Power manag=
ement
> >> core will increment the power_usage counter during prepare and decreme=
nts when complete
> >> is called.
> >>
> >> Now I have few questions:
> >>
> >> 1) When the system resume is done=2C it does not increase the power_us=
age counter.
> >> right?
> >
> > That's right.
> >
> >> So Does then the driver need to update the power_usage counter with ru=
n time power management
> >> core and again set it to active means RPM_ACTIVE?
> >
> > Read section 6 of Documentation/power/runtime_pm.h. It explains this.
> >
> >> 2) Suppose device is active=2C means its power_usage counter is alread=
y one=2C Now during system
> >> sleep=2C does the driver first suspend it with run time power manageme=
nt core and then continue
> >> System suspend?
> >
> > No.
> >
> >> 3) Because I have seen the code of power management core and I did not=
 see the that during
> >> system suspend=2C run time power management status is updated means RP=
M_SUSPENDED.
> >> right?
> >
> > I don't understand your question.
> >
> > Alan Stern
> >
 		 	   		  =

--_59fc4dd1-58a3-4d10-ab7d-73466f611d45_
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
<BR>Hi Alan=2C<BR><BR>Thanks for quick replies. As you said<BR>
&nbsp=3B<BR>
<BR>&gt=3B &gt=3B&gt=3B 2) Suppose device is active=2C means its power_usag=
e counter is already one=2C Now during system<BR>&gt=3B &gt=3B&gt=3B sleep=
=2C does the driver first suspend it with run time power management core an=
d then continue<BR>&gt=3B &gt=3B&gt=3B System suspend?<BR>&gt=3B &gt=3B<BR>=
{ALAN} &nbsp=3BNo.<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
But since during system suspend power_usage counter is incremented by 1 But=
 if the device is active<BR>
means its state is RPM_ACTIVE=2C its power_usage counter is 1 in run time p=
ower management core.<BR>
&nbsp=3B<BR>
when the system suspend happens=2C it will also increment the power_usage_c=
ounter by 1 during dpm_prepare<BR>
&nbsp=3B<BR>
Now&nbsp=3B&nbsp=3B the power_usage_counter is 2.<BR>
&nbsp=3B<BR>
So when dpm_complete is invoked=2C it will decrement the power_usage_counte=
r by 1 during dpm_complete.<BR>
&nbsp=3B<BR>
So now when the drivers gets system suspend=2C its power_usage counter is s=
till 1.<BR>
&nbsp=3B<BR>
So what in this scenario=2C does the device decrements the power_usage coun=
ter itself?<BR>
&nbsp=3B<BR>
Thanks<BR>
Raj<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>&gt=3B<BR>&gt=3B<BR>&gt=3B<BR>&g=
t=3B ----------------------------------------<BR>&gt=3B &gt=3B Date: Tue=2C=
 24 Aug 2010 10:30:25 -0400<BR>&gt=3B &gt=3B From: stern@rowland.harvard.ed=
u<BR>&gt=3B &gt=3B To: rajkumar278@hotmail.com<BR>&gt=3B &gt=3B CC: linux-k=
ernel@vger.kernel.org<BR>&gt=3B &gt=3B Subject: Re: Runtime power managemen=
t during system resume<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B On Tue=2C 24 Aug 2=
010=2C Raj Kumar wrote:<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B&gt=3B Hi Alan=2C<=
BR>&gt=3B &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B I have implemented the run ti=
me power management in my drivers. I have one<BR>&gt=3B &gt=3B&gt=3B issue =
regarding System resume.<BR>&gt=3B &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B When=
 the system sleep is triggered as it is mentioned that Power management<BR>=
&gt=3B &gt=3B&gt=3B core will increment the power_usage counter during prep=
are and decrements when complete<BR>&gt=3B &gt=3B&gt=3B is called.<BR>&gt=
=3B &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B Now I have few questions:<BR>&gt=3B=
 &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B 1) When the system resume is done=2C i=
t does not increase the power_usage counter.<BR>&gt=3B &gt=3B&gt=3B right?<=
BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B That's right.<BR>&gt=3B &gt=3B<BR>&gt=3B =
&gt=3B&gt=3B So Does then the driver need to update the power_usage counter=
 with run time power management<BR>&gt=3B &gt=3B&gt=3B core and again set i=
t to active means RPM_ACTIVE?<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B Read sectio=
n 6 of Documentation/power/runtime_pm.h. It explains this.<BR>&gt=3B &gt=3B=
<BR>&gt=3B &gt=3B&gt=3B 2) Suppose device is active=2C means its power_usag=
e counter is already one=2C Now during system<BR>&gt=3B &gt=3B&gt=3B sleep=
=2C does the driver first suspend it with run time power management core an=
d then continue<BR>&gt=3B &gt=3B&gt=3B System suspend?<BR>&gt=3B &gt=3B<BR>=
&gt=3B &gt=3B No.<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B&gt=3B 3) Because I have=
 seen the code of power management core and I did not see the that during<B=
R>&gt=3B &gt=3B&gt=3B system suspend=2C run time power management status is=
 updated means RPM_SUSPENDED.<BR>&gt=3B &gt=3B&gt=3B right?<BR>&gt=3B &gt=
=3B<BR>&gt=3B &gt=3B I don't understand your question.<BR>&gt=3B &gt=3B<BR>=
&gt=3B &gt=3B Alan Stern<BR>&gt=3B &gt=3B<BR> 		 	   		  </body>
</html>=

--_59fc4dd1-58a3-4d10-ab7d-73466f611d45_--

--===============6987817823827695137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6987817823827695137==--
