From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] A New Power Management API
Date: Sun, 8 May 2005 12:05:55 -0700
Message-ID: <200505081205.55292.david-b@pacbell.net>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<200504161226.12849.david-b@pacbell.net>
	<42647650.3030607@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95730708258293262=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <42647650.3030607@mvista.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============95730708258293262==
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Monday 18 April 2005 8:09 pm, Todd Poynor wrote:
> David Brownell wrote:
> > On Friday 15 April 2005 7:53 pm, Todd Poynor wrote:
> >...
> >>On the other hand, I've been trying to push them toward a simpler-kernel 
> >>model in which all the product-specific logic for placing various 
> >>devices in designated power states occurs in a userspace power policy 
> >>manager,

Which, as I've commented, doesn't necessarily seem simple to me!

Userspace policy code could just as well be ALL device-specific,
like "turn off backlight", without needing any generic notion of
power states.  Or, something like MontaVista DPM could work with
no need to expose device-specific power states... just the ability
to set some "operating point", which in ACPI terms might be one
of the many possible S0 states.


> > So maybe you have some answers for me about why there should need
> > to be *any* notion of exporting device power states.  (Rather than
> > not caring, and just requiring driver-internal powers states always
> > to become consistent with the upcoming system power state.)
> > 
> > If one takes the notion of userspace managing those states off the table,
> > is there any other motivation to expose those device power states? 
> 
> So far as I have been able to determine, the usage you describe, as well 
> as straightforward individual device power state management (power this 
> device off upon receipt of some event, period of inactivity, etc.) is 
> common, although with enough flexibility in creating custom system power 
> states and reacting to those states in driver power controller objects, 
> the second usage may be covered by the first.

I can't quite parse this as an answer to my question though.  Driver-internal
states are by definition not exported, and can't be "covered" by userspace.

The userspace knobs I think everyone pretty much agrees on are the sort
that are already widely used in X11, hdparm, and so on:  idle timeouts,
with the system probably setting a sane default.   Ones that are less
widely agreed on include having "system power states" that are more
specific/custom than just ACPI S1/S3/S4 or analogues ... because they
could include things like S0 states with backlight on vs off, or so on
for other devices.  (That does beg the question of which states need to
be known as such to the kernel, and how... via /sys/power/state etc.)


The question was about whether "device power states" have any role
OTHER than to be managed by userspace.  You didn't identify any such
role, so I'll continue to believe there is none.


> > I'm pretty sure that supporting this sort of userspace functionality
> > won't really fit into the "simpler kernel" rubric.  If for no other
> > reason than the self-evident fact that a kernel exporting such stuff
> > must have more code than one not exporting it...
> 
> It may not be simpler overall on the kernel side (at least prior to 
> being customized for a particular policy, for which the in-kernel 
> alternative does add some amount of code). 

Depends on what what you expect out of a policy.  Separately, I've
talked about how drivers can often be smart enough to stay in low
power modes "all the time" when they're idle.  Such drivers don't
need ANY other policy inputs.  If more drivers do that, the system
as a whole just needs to be smart enough to tell (possibly from
userspace) when the devices are idle ... and maybe to conclude, as
with the dynamic tick or VST stuff, that it's time to enter some
more power-efficient system state.

To concoct a DPM-like example, if one were to write the name describing
some operating point to some file in sysfs, and that ended up calling a
board-specific routine to suspend/resume various devices, maybe updating
clocks and power supplies, that would be straightforward and obvious.
Which makes it simpler than threading all that stuff throughout the
driver model to support doing that from userspace.  :)


> It does, however, place the  
> code implementing custom system power states and associated decisions on 
> device power states (which might fall under the general category of 
> "policy") in userspace and exports just enough kernel interfaces for 
> controlling system and device power behavior to let userspace handle it. 

Again, you're not answering the question of what point there'd to
expose any notion of driver state _other_ than to export that sort
of control knob to user-mode agents ... along with more widely used
things like idle timeout settings and backlight on/off controls,
or less widely accepted DPM-ish ones that effectively provide new
system power states ("operating points").


>   As I say, though, the userspace vs. kernel home for this isn't a 
> matter of strong preference to me, but have suggested userspace device 
> state management as arguably more in keeping with prevailing winds of 
> kernel development.

There are lots of winds blowing, and I don't think you can really say
that there's a wind blowing in favor of a particular type of feature
which has never yet been really usable... if anything, the wind has
always blown in favor of removing broken or unusable capabilities.

It's a question of what sort of policy choice the kernel has any
real business exporting.  I've seen lots of interfaces designed to
export low level control knobs that really shouldn't be exported.
This still looks to me like yet another one...

- Dave


--===============95730708258293262==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95730708258293262==--
