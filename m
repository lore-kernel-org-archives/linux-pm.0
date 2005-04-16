From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] A New Power Management API
Date: Sat, 16 Apr 2005 12:26:12 -0700
Message-ID: <200504161226.12849.david-b@pacbell.net>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<1113591290.3451.79.camel@localhost.localdomain>
	<42607E34.7060909@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76233925471946673=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <42607E34.7060909@mvista.com>
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

--===============76233925471946673==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 15 April 2005 7:53 pm, Todd Poynor wrote:
> Adam Belay wrote:
> > On Fri, 2005-04-15 at 09:50 -0600, Jordan Crouse wrote:
> ...
> >>We would then define a system state flag, say
> >>PM_SYSTEM_STATE_PSEUDO, which would prompt a driver to query its policy
> >>manager to get the translation for the right device state.  Those
> >>devices that don't understand or care about user defined power
> >>states would simply ignore the flag.
> > 
> > I think the policy manager would directly request for a change of the
> > state.  Then the driver would handle *suspend.  Although the policy
> > manger is code included with the driver, I'd like it to handle any
> > decisions.  So it would be the policy manager's job to notice something
> > like PM_SYSTEM_STATE_PSEUDO.
> 
> As a real-life embedded systems example, I have periodic conversations 
> with some folks who design Linux-based mobile phones, and they have 
> recently asked for the addition of features that I figure can be 
> addressed by approximately just this.

I like that idea, except that I don't see why it should kick in
only with a PM_SYSTEM_STATE_PSUEDO flag.  Why shouldn't the power
container's policy code _always_ work that way?  That is, I see
no motivation for a special case here.


> On the other hand, I've been trying to push them toward a simpler-kernel 
> model in which all the product-specific logic for placing various 
> devices in designated power states occurs in a userspace power policy 
> manager,

So maybe you have some answers for me about why there should need
to be *any* notion of exporting device power states.  (Rather than
not caring, and just requiring driver-internal powers states always
to become consistent with the upcoming system power state.)

If one takes the notion of userspace managing those states off the table,
is there any other motivation to expose those device power states?   If
not, the only reason to export power states would be to support this
particular style of userspace power management micro-policy.

I'm pretty sure that supporting this sort of userspace functionality
won't really fit into the "simpler kernel" rubric.  If for no other
reason than the self-evident fact that a kernel exporting such stuff
must have more code than one not exporting it...


Right now the only reason I'm not strongly leaning towards just
removing the /sys/.../power/state files completely is that I still
want a way to test individual driver suspend and resume methods
without forcing some system sleep transition.  It's a real pain
to be unable to test one each driver until all the others are
also working correctly; in fact, it's a major chicken/egg issue.


> and: (a) most drivers take no additional action at system  
> suspend, leaving the policy-manager-set power state in place, with some 
> exceptions for drivers necessary to run the system right up until sleep 
> time; (b) most drivers do nothing at system resume other than those 
> needed to get the system up and running (for a mobile phone, say, at 
> least mtd subsystem and flash chip driver) and then let userspace policy 
> manager decide what power state to place all the devices in.  Their 
> products tend to do highly customized things like power back up a small 
> subset of devices that were on prior to the sleep, or briefly power up 
> previously-off devices to check to see if any important changes in the 
> environent occurred during the sleep, etc.
> 
> I think either way will work fine for what they're trying to do, am open 
> to discuss the merits of either approach.  If anyone has any comments on 
> the simplistic kernel method it's appreciated.  Thanks,

I think it's more accurate to talk about that as a "userspace micro-policy
management" approach rather than a "simplistic kernel method".  Simpler
kernels would export only broad-brush policy controls.

I see it as akin to the tradeoff between lots of fine grained locks, versus
a few coarse grained ones:  except for the atypical highly-contended cases,
one coarse lock invariably provides the lowest overhead.

- Dave



> 
> -- 
> Todd
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/linux-pm
> 

--===============76233925471946673==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76233925471946673==--
