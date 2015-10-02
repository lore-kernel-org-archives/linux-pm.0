From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Fri, 2 Oct 2015 19:49:09 +0100
Message-ID: <20151002184909.GC12635@sirena.org.uk>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
 <20151002164743.GR12635@sirena.org.uk>
 <20151002172311.GI5552@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kJMkLA1uPhjFFA+D"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151002172311.GI5552@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org
List-Id: linux-pm@vger.kernel.org


--kJMkLA1uPhjFFA+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2015 at 12:23:11PM -0500, Felipe Balbi wrote:
> On Fri, Oct 02, 2015 at 05:47:43PM +0100, Mark Brown wrote:

> > Can you elaborate on what the difficulties are and how punting to
> > userspace helps?  If anything I'd expect punting to userspace to make

> the difficulty was mainly making sure all involved parties talk the same
> language. I mean, you plug cable and detect charger (this is usually done by the
> PMIC or by a BQ-type device - probably done at drivers/power_supply).

> First difficulty comes right here. Power_supply notifies that we're attached to
> a charger (sometimes it can't differentiate a host/hub charger from a wall
> charger), a few ms later you get a notification from the gadget that it got
> enumerated with a 500mA configuration. Depending on the order of things, your
> load will be configured either to 2A (maximum host/hub charger current) or
> 500mA. Yes, this can be mitigated :-)

> Focussing on this alone, you can have as much as 4 different subsystems
> involved, all throwing raw_notifiers at each other. Now each of these subsystems
> need to maintain their own state machine about what notification we have
> received and what are the valid next states.

OK, so part of the goal here was to outsource all the state machines to
some generic code - what you're describing here is definitely a problem
and the idea was to provide a central place that has the logic and makes
the decisions about what we should be doing.  If we don't have that it's
going to get messy.

> I would rather have userspace be the single place getting notifications because
> then we solve these details at a single location.

No argument on the place, making that place be userspace I'm less sold
on.

> > Things more difficult, if nothing else it means we need to get whatever
> > userspace component deployed in all relevant userspace stacks with
> > appropriate configuration in order to do things.

> but that will be a thing for the kernel too. We will have to deploy this new
> kernel component in all relevant stacks with appropriate configuration in order
> to do things :-) No changes there.

Sure, but it's one project which is developed entirely in the open -
that's a lot more manageable.

> > We do punt a lot of configuration to userspace for audio because there
> > are substantial device specific policy elements in the configuration and
> > it's a far from painless experience getting the code and configuration
> > deployed where people need it, definitely a not great for users.

> it's the same for this situation. We will have a ton of device specific
> configuration, specially with power delivery class, billboard class, the
> alternate modes and so on. If we already do this part in userland, adding all
> those extras will be, IMO, far simpler.

Can you elaborate a bit?  As far as I can tell all those are still in
the generic USB space rather than the sort of device specifics I'm
thinking of.

The things we've got with audio are a combination of tuning to taste and
(even more importantly) very different ideas about what you want to do
with an audio subsystem that influence how you set things up in a given
use case.

> > I think that where we can do it the bit where work out how the various
> > components are connected and aggregate their functionality together is
> > definitely a kernel job.  It means that userspace doesn't need to worry
> > about implementation details of the particular system and instead gets a
> > consistent, standard view of the device (in this case a USB port and how
> > much power we can draw from it).

> Actually, I was thinking about it in a more granular fashion. Kernel exposes a
> charger/power_supply, a few regulators, a UDC view and this single userspace
> daemon figures out how to tie those together.

That sounds worrying - it means that new hardware support needs
supporting in every userspace (it seems inevitable that there will be at
least some reimplementations because that's fun) which gets old really
fast, and every userspace needs to understand every topology.

> The view here isn't really a USB port, it's just a source of power. But how much
> power we can draw from it depends on, possibly, a ton of different chips and
> different notifications.

Right, yes - it's the power input/output associated with the USB port.
The USB port is just the physical thing users can see so it's a good way
to label it.  That could mean that we ought to move the aggregation bit
into the power supply code of course, but then a lot of the decisions
are going to be specific to USB.

> > For the policy stuff we do want to have userspace be able to control
> > things but we need to think about how to do that - for example does the
> > entire flow need to be in userspace, or can we just expose settings
> > which userspace can manage?

> considering the amount of different designs that are already out there and all
> the extras that are going to show up due to type-c, I think we'd be better off
> exposing as much to userspace as possible.

How different are the end goals of these designs really going to be
though - that's more of the question for me?  Part of what the kernel is
doing is hiding implementation details from userspace.  I'd expect
userspace to be interested in things like the maximum current allowed in
or out in a given mode rather than the details of how that is accomplished.

> > I'm not sure that the NFC model is working well for everyone - it's OK
> > if you happen to be running Android but if you aren't you're often left
> > sitting there working out what to do with an Android HAL.  We can do the

> NFC works pretty well for neard, afaict. And without android.

Ah, that looks better than it was now - it looks like they're providing
a reasonable hardware abstraction for messaging.  Still, there's other
examples of this model that are less successful where the kernel
interface isn't generic.

> The real difficulty here is coming up with an interface which we're agreeing to
> supporting for the next 30 years. Whatever that is, as soon as it gets exposed
> to userland, we will have to support it.

To me that sounds like an argument for hiding things :)

> And this another reason I think a more granular approach is better, as it allows
> us to easily add more pieces as they come along.

OTOH it's more work for the system as a whole.

--kJMkLA1uPhjFFA+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDtGhAAoJECTWi3JdVIfQ204H/0Y2268ckgmV/twDKzR3Gc+e
+0zJJGRuhgQCAWC6PlIfN4rix/DvCQP3+sH+tr5odcwDo3cRqMZy817fNVJcVfHv
/TPlbXAxojwO3ZKcUvLKEhGsOcee323kEsMFQzyXkkqufrHQTHA7tH4whisKEU8D
hFPrFiFxUJALjve+SJgYfGyPLSmv3GgkAxvCMu3FZxdUTmjlfLsU8GVxU0kedhMh
xAYfzLx1sOUo5rfFHgJJ06vkMvFF0eTPoA5JJWIMmj+y0g1rJrlGi/wUk6TZEDd6
cxt6dcKtoi5ljjOicLgOOFtSHEpO1b32uKFeveEpU9pNv9pMRVoIPnMhy5X2iss=
=p/RD
-----END PGP SIGNATURE-----

--kJMkLA1uPhjFFA+D--
