From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Runtime power management during system resume
Date: Thu, 26 Aug 2010 19:10:42 +0530
Message-ID: <BLU102-W283ED7848BB0495FBACF0BEB850@phx.gbl>
References: <BLU102-W1030ED196ED7B94722F2A7EB830@phx.gbl>,
	<Pine.LNX.4.44L0.1008241029000.1652-100000@iolanthe.rowland.org>,
	<BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>,
	<BLU102-W296D98B5535DEC8A7A973EB840@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7539483181886852147=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W296D98B5535DEC8A7A973EB840@phx.gbl>
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

--===============7539483181886852147==
Content-Type: multipart/alternative;
	boundary="_392df46d-69f6-4e53-9e0b-e57fb8f1a5ed_"

--_392df46d-69f6-4e53-9e0b-e57fb8f1a5ed_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=20

Hi Alan=2C

=20

I have few more questions:

=20

1) If the platform device driver is using platform_bus_type as its bus type=
=2C in that case is the parent of device is its bus?

=20

2) Because I saw the code in platform_device_register=2C when any platform =
device is register=2C its parent is set to

platform bus?

right?

=20

int platform_device_add(struct platform_device *pdev)
{

----------------------------------------

if (!pdev->dev.parent)
                pdev->dev.parent =3D &platform_bus=3B

------------------------------------------------------

}

=20

So when the platform device wants to use parent other than platform bus=2C =
is it possible to set the parent

of platform device to any other device rather than platform_bus?

=20

=20

3) The 3rd question is regarding=2C in this function

=20

int __pm_runtime_resume(struct device *dev=2C bool from_wq)
        __releases(&dev->power.lock) __acquires(&dev->power.lock)
{

=20

-----------------------
        if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
                spin_unlock_irq(&dev->power.lock)=3B

                retval =3D dev->bus->pm->runtime_resume(dev)=3B

                spin_lock_irq(&dev->power.lock)=3B
                dev->power.runtime_error =3D retval=3B
        }

=20

--------------------

 out:
        if (parent) {
                spin_unlock_irq(&dev->power.lock)=3B

                pm_runtime_put(parent)=3B

                spin_lock_irq(&dev->power.lock)=3B
        }

}

=20

When the device is resumed and its status is set to RPM_ACTIVE=2C Now the c=
ontrol comes to=20

pm_runtime_put(parent) (suppose device is resumed correctly)

=20

Now it decrements the power usage count and call idle for parent.

=20

Why after resuming the device=2C It will try to schedule idle for its paren=
t?

=20

Since the device is resumed so its parent should be active.

=20

Regards

Raj

=20

=20

=20

=20


=20

=20

=20


=20

=20

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

--_392df46d-69f6-4e53-9e0b-e57fb8f1a5ed_
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
I have few more questions:<BR>
&nbsp=3B<BR>
1) If the&nbsp=3Bplatform device driver is using platform_bus_type as its b=
us type=2C in that case is the parent of&nbsp=3Bdevice is its bus?<BR>
&nbsp=3B<BR>
2)&nbsp=3BBecause I saw the code in platform_device_register=2C when any pl=
atform device is register=2C its parent is set to<BR>
platform bus?<BR>
right?<BR>
&nbsp=3B<BR>
int platform_device_add(struct platform_device *pdev)<BR>{<BR>
----------------------------------------<BR>
if (!pdev-&gt=3Bdev.parent)<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B pdev-&gt=3Bdev.parent =3D &amp=3Bplatform_bus=3B<BR>
------------------------------------------------------<BR>
}<BR>
&nbsp=3B<BR>
So when the platform device wants to use parent other than platform bus=2C =
is it possible to set the parent<BR>
of platform device to any other device rather than platform_bus?<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
3) The&nbsp=3B3rd question is regarding=2C in this function<BR>
&nbsp=3B<BR>
int __pm_runtime_resume(struct device *dev=2C bool from_wq)<BR>&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B __releases(&amp=3Bdev-&gt=3Bpo=
wer.lock) __acquires(&amp=3Bdev-&gt=3Bpower.lock)<BR>{<BR>
&nbsp=3B<BR>
-----------------------<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B if (dev-&gt=3Bbus &amp=3B&amp=3B dev-&gt=3Bbus-&gt=3Bpm &amp=3B&am=
p=3B dev-&gt=3Bbus-&gt=3Bpm-&gt=3Bruntime_resume) {<BR>&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B spin_unlock_irq(&amp=3Bdev-&gt=3Bpower.lock)=3B=
<BR>
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B retval =3D dev-&gt=3Bbus-&gt=
=3Bpm-&gt=3Bruntime_resume(dev)=3B<BR>
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B spin_lock_irq(&amp=3Bdev-&gt=
=3Bpower.lock)=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B dev-&gt=
=3Bpower.runtime_error =3D retval=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B }<BR>
&nbsp=3B<BR>
--------------------<BR>
&nbsp=3Bout:<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B if=
 (parent) {<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B spin_unlock_ir=
q(&amp=3Bdev-&gt=3Bpower.lock)=3B<BR>
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B pm_runtime_put(parent)=3B<BR>
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B spin_lock_irq(&amp=3Bdev-&gt=
=3Bpower.lock)=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B }<BR>
}<BR>
&nbsp=3B<BR>
When the device is resumed and its status is set to RPM_ACTIVE=2C Now the c=
ontrol comes to <BR>
pm_runtime_put(parent) (suppose device is resumed correctly)<BR>
&nbsp=3B<BR>
Now it decrements the power usage count and call idle for parent.<BR>
&nbsp=3B<BR>
Why after resuming the device=2C It will try to schedule idle for its paren=
t?<BR>
&nbsp=3B<BR>
Since the device is resumed so its parent should be active.<BR>
&nbsp=3B<BR>
Regards<BR>
Raj<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
<BR>&nbsp=3B<BR>
&nbsp=3B<BR>
&gt=3B ----------------------------------------<BR>&gt=3B &gt=3B Date: Tue=
=2C 24 Aug 2010 10:30:25 -0400<BR>&gt=3B &gt=3B From: stern@rowland.harvard=
.edu<BR>&gt=3B &gt=3B To: rajkumar278@hotmail.com<BR>&gt=3B &gt=3B CC: linu=
x-kernel@vger.kernel.org<BR>&gt=3B &gt=3B Subject: Re: Runtime power manage=
ment during system resume<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B On Tue=2C 24 Au=
g 2010=2C Raj Kumar wrote:<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B&gt=3B Hi Alan=
=2C<BR>&gt=3B &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B I have implemented the ru=
n time power management in my drivers. I have one<BR>&gt=3B &gt=3B&gt=3B is=
sue regarding System resume.<BR>&gt=3B &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B =
When the system sleep is triggered as it is mentioned that Power management=
<BR>&gt=3B &gt=3B&gt=3B core will increment the power_usage counter during =
prepare and decrements when complete<BR>&gt=3B &gt=3B&gt=3B is called.<BR>&=
gt=3B &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B Now I have few questions:<BR>&gt=
=3B &gt=3B&gt=3B<BR>&gt=3B &gt=3B&gt=3B 1) When the system resume is done=
=2C it does not increase the power_usage counter.<BR>&gt=3B &gt=3B&gt=3B ri=
ght?<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B That's right.<BR>&gt=3B &gt=3B<BR>&g=
t=3B &gt=3B&gt=3B So Does then the driver need to update the power_usage co=
unter with run time power management<BR>&gt=3B &gt=3B&gt=3B core and again =
set it to active means RPM_ACTIVE?<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B Read s=
ection 6 of Documentation/power/runtime_pm.h. It explains this.<BR>&gt=3B &=
gt=3B<BR>&gt=3B &gt=3B&gt=3B 2) Suppose device is active=2C means its power=
_usage counter is already one=2C Now during system<BR>&gt=3B &gt=3B&gt=3B s=
leep=2C does the driver first suspend it with run time power management cor=
e and then continue<BR>&gt=3B &gt=3B&gt=3B System suspend?<BR>&gt=3B &gt=3B=
<BR>&gt=3B &gt=3B No.<BR>&gt=3B &gt=3B<BR>&gt=3B &gt=3B&gt=3B 3) Because I =
have seen the code of power management core and I did not see the that duri=
ng<BR>&gt=3B &gt=3B&gt=3B system suspend=2C run time power management statu=
s is updated means RPM_SUSPENDED.<BR>&gt=3B &gt=3B&gt=3B right?<BR>&gt=3B &=
gt=3B<BR>&gt=3B &gt=3B I don't understand your question.<BR>&gt=3B &gt=3B<B=
R>&gt=3B &gt=3B Alan Stern<BR>&gt=3B &gt=3B<BR><BR> 		 	   		  </body>
</html>=

--_392df46d-69f6-4e53-9e0b-e57fb8f1a5ed_--

--===============7539483181886852147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7539483181886852147==--
