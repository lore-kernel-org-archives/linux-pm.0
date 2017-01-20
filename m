From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 20 Jan 2017 09:38:04 +0100
Message-ID: <20170120083804.GF4894@ulmo.ba.sec>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth>
 <20170119232934.GA18102@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36571 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdATIiI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2017 03:38:08 -0500
Content-Disposition: inline
In-Reply-To: <20170119232934.GA18102@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 03:29:34PM -0800, Guenter Roeck wrote:
> On Fri, Jan 20, 2017 at 12:00:36AM +0100, Sebastian Reichel wrote:
> > Hi Thierry,
> >=20
> > > > > [...]
> > > >
> > > > Please use register_restart_handler() instead. It has support for
> > > > priorities, is not arm specific and properly supports unregistering
> > > > (some handler with lower priority will take over). You can check
> > > > gpio-restart as an example for the API.
> > > >=20
> > > > If you have some other arm_pm_restart handler (those are tried firs=
t)
> > > > I suggest to convert that to the restart handler framework. Actually
> > > > it may be a good idea to convert all of them and drop arm_pm_restar=
t,
> > > > since there are only 4 left:
> > > >=20
> > > > $ git grep "arm_pm_restart =3D"
> > > > drivers/firmware/psci.c:        arm_pm_restart =3D psci_sys_reset;
> > > > arch/arm/mach-prima2/rstc.c:    arm_pm_restart =3D sirfsoc_restart;
> > > > arch/arm/xen/enlighten.c:       arm_pm_restart =3D xen_restart;
> > > > arch/arm/kernel/setup.c:                arm_pm_restart =3D mdesc->r=
estart;
> > > >=20
> > > > The first 3 should be easy to update and the last one could
> > > > be solved by registering a wrapper function as restart handler,
> > > > which calls mdesc->restart().
> > >=20
> > > I remember this not being the first time that this confuses me. And f=
rom
> > > looking around a little it seems like I'm not the only one.
> > >=20
> > > Do you know if there's ever been any attempts to formalize all of this
> > > by adding some sort of framework for this? That way some of the
> > > confusion may be removed and architecture-specific bits could be
> > > eliminated more easily.
> >=20
> > We have a framework for restart handlers, which has been written
> > by Guenter Roeck [0] in 2014. You just have to call register_restart_ha=
ndler()
> > during probe and unregister_restart_handler() during removal of
> > your reboot driver. All reboot drivers in drivers/power/reset use
> > that framework.
> >=20
> > The restart handlers are invoked by calling do_kernel_restart()
> > based on their configured priority. That function is called by
> > the architecture's machine_restart() function. It's currently
> > used by mips, ppc, arm & arm64 as far as I can see. ARM's
> > implementation looks like this:
> >=20
> > if (arm_pm_restart)
> > 	arm_pm_restart()
> > else
> > 	do_kernel_restart() /* reboot handler framework */
> >=20
> I actually have a set of patches somewhere which transforms the remaining
> direct users of arm_pm_restart to use the framework (unless I removed it
> from my trees - I don't really recall). I just never got around to submit
> it, and then [2] happened and I lost interest.
>=20
> > No such thing exists for poweroff. Guenter also wrote something for
> > that [1], but Linus intervened [2]. Anyways, pm_power_off is at
> > least architecture independent.
> >=20
> That was by far the most frustrating kernel development experience
> I ever head :-(.

It was a little difficult to track down all the discussion around this,
but reading through what I could find, I can understand why this would
have been frustrating. You obviously spent an enormous amount of work
only to get it shot down.

I have to say that I have similar concerns to those voiced by Linus and
Rafael. Notifier chains and priority seem too little restrictive for
this kind of functionality, in my opinion. I think those concerns could
be removed if things got formalized using a framework.

Without having spent the amount of time on the topic that you have, the
following straw-man proposal is perhaps a little naive:

	struct system_power_controller;

	struct system_power_ops {
		int (*power_off)(struct system_power_controller *spc);
		int (*restart)(struct system_power_controller *spc,
			       enum reboot_mode mode,
			       const char *cmd);
	};

	struct system_power_controller {
		struct device *dev;
		const struct system_power_ops *ops;
		struct list_head list;
		...
	};

	int system_power_controller_add(struct system_power_controller *spc);
	void system_power_controller_remove(struct system_power_controller *spc);

	int system_power_off(void);
	int system_restart(enum reboot_mode mode, const char *cmd);

The above is based on what other subsystems use. Drivers would embed the
struct system_power_controller in a driver-specific data structure and
use container_of() to get at that from the callbacks.

Controllers can be added and removed to the subsystem. Internally it may
be worth to keep all of the controllers in a list, but only use the most
appropriate ones. The above would need some sort of flag or type list
that drivers can set in addition to operations to indicate what your
proposal had done via priorities. I'm thinking of something along the
lines of:

	enum system_power_controller_type {
		SYSTEM_POWER_CONTROLLER_TYPE_CPU,
		SYSTEM_POWER_CONTROLLER_TYPE_SOC,
		SYSTEM_POWER_CONTROLLER_TYPE_BOARD,
	};

	struct system_power_controller {
		...
		enum system_power_controller_type type;
		...
	};

There's a fairly natural ordering in the above "levels". Obviously the
board-level controller would be highest priority because it controls
power or reset of the complete board. This would likely be implemented
by GPIO-based or PMIC type of drivers. SoC-level controllers would use
mechanisms provided by the SoC in order to power off or reset only the
SoC. This is obviously lower priority than board-level because some of
the components on the board may end up remaining powered on or not
getting reset. But it could be a useful fallback in case a board-level
controller isn't present or fails. Finally there's the CPU-level code
that would most likely be implemented by architecture code. In the most
basic version this could be a WFI kind of instruction, or a busy loop,
or perhaps even a simple call to panic().

One complication might be that there are things like PSCI that have an
architecture-specific implementation (CPU-level) but could actually be
a board-level "controller".

To keep things simple, I think it would be okay to allow only one of
each type of controller in any running system. It's very unlikely that
board designers would devise two different ways of powering off or
restarting a system, while in a similar way an SoC or CPU would only
ever provide one way to do so. Even if theoretically multiple
possibilities exist, I think the board code should pick which ones are
appropriate.

Another missing feature in the above is that sometimes a mechanism
exists to record in persistent storage (registers, memory, ...) what
kind of reset was executed and which boot code will inspect and use to
run different paths during boot. One such example is Tegra where the
PMC has "scratch" registers that don't get reset on reboot. Software
sets some of the bits to enable things like forced-recovery mode or
Android-type recovery booting. I'm sure other similar mechanisms exist
on other SoCs. Upon board-level reset, we would still want to have the
SoC-level reset prep code execute, but not reset the SoC, otherwise
the board-level code wouldn't have a chance of running anymore. This
could possibly be solved by adding more fine-grained operations in the
struct system_power_ops.

One other possible solution that comes to mind is that system power
controllers could be explicitly stacked. This would be complicated to
achieve in code, but I'm thinking it could have interesting use-cases
in device tree based systems, for example. I'm just brainstorming here,
this may not be a good idea at all:

	pmc: pmc@... {
		system-power-controller;
	};

	i2c@... {
		pmic: pmic@... {
			...
			system-power-parent =3D <&pmc>;
			...
		};
	};

The PMIC would in the above call into PMC in order to reset on a SoC
level before performing the board-level reset. I suppose it could use
a separate callback (->prepare({RESET,POWER})) instead of the usual
->restart() and ->power_off().

Does the above sound at all sane to you, given your broad experience
in this field? Anything I missed that I'd need to consider in a design
for such a framework?

Sebastian, any thoughts from you on the above?

Thierry

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliBzGoACgkQ3SOs138+
s6FyRQ/8DhVJqbyfvL2jOE9JwV6DuZH+8h+DSaOQp+orIQ2vRNLbX7L7l7QGtAaU
hCMbxXs9aCH9owQuTFNCZAsuwalQm/GfPamQbaRlIENmfFD8HQzGo1IBdf+tzI99
b+7R9UMOW2mO2MpJHHnpAcXxDhe9HgcBQlqNLIHf4RiTr8cpWVdxGLpie45nOf6q
f7Ji+VFs5Uyv22juI0NeifdGKuQMhcJI7FkMsx2KIF7uwze4t45aB2c1yMA1Lcor
6vaRFfr5wuu7zhWsKfilzQQEYy37fcLN1P3DLsPOW/eLWxVIz964MZoS+vvlbMs0
fQftP8CAMdDezOJYBoQyWDZpr4ppZ5xw+VMLO8vAe4gpt7CpbnXdeIGywwtgttiY
cey+7lX3UlzzP4XQyJw5eEyemyX+teSfQlaBlrelbOdas04rse+OgWu9N/fOHlo5
2HuXGIPzZ5DdwJVM6+hjvMWpBnRwfsQ8RHBp/vMC5WXciLs3blYm696BT6+JPbhD
algteCDRe+iUYT8AKu41zqgvB9D+vvki05Y0KI3KmJPEhxcbe16o+ul958+7S0wr
R20hIVGXHKH7iLd2SUmAA/IodGqRED2Teqj39EF0pFNeheVraXZTH7lT/AL1d7AG
18qld1KdMzqRi9d0MO33H9tqy5o8nuukh8GvDus8WoOlVazhvl8=
=O058
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
