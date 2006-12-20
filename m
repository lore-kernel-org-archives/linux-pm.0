From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] [PATCH -mm] PM: Change ordering of suspend and resume code
Date: Wed, 20 Dec 2006 13:43:22 +0100
Message-ID: <200612201343.23440.rjw@sisk.pl>
References: <200612171858.16380.rjw@sisk.pl> <20061219233002.GA2694@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061219233002.GA2694@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 20 December 2006 00:30, Pavel Machek wrote:
> Hi!
>=20
> > As indicated in a recent thread on Linux-PM, it's necessary to call
> > pm_ops->finish() before devce_resume(), but enable_nonboot_cpus() h=
as to be
> > called before pm_ops->finish()
> > (cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.=
html).
> > For consistency, it seems reasonable to call disable_nonboot_cpus()=
 after
> > device_suspend().
> >=20
> > This way the suspend code will remain symmetrical with respect to t=
he resume
> > code and it may allow us to speed up things in the future by suspen=
ding and
> > resuming devices and/or saving the suspend image in many threads.
> ...
> > The following series of patches reorders the suspend and resume cod=
e so that
> > nonboot CPUs are disabled after devices have been suspended and ena=
bled before
> > the devices are resumed. =A0It also causes pm_ops->finish() to be c=
alled after
> > enable_nonboot_cpus() wherever necessary.
>=20
> Series looks okay to me... but it will need _long_ testing in
> -mm. (Consider this ACK).

Thanks.

> > The first patch changes the ordering of the suspend-to-RAM code and=
 is
> > untested, because my boxes continue refusing to resume from RAM for=
 other
> > reasons.  If anyone can, please do me a favour and test it.
>=20
> I did a bit of testing, and it seems to still work, both s2ram and
> swsusp. (uswsusp untested).

I've been testing uswsusp for some time and it doesn't seem to break (s=
o far :-)).

Greetings,
Rafael


--=20
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
