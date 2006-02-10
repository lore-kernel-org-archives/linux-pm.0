From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Fri, 10 Feb 2006 14:46:38 +0100
Message-ID: <20060210134638.GA5109@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de> <20060210121913.GA4974@elf.ucw.cz> <20060210123259.GB18577@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060210123259.GB18577@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Stefan Seyfried <seife@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On P=E1 10-02-06 13:32:59, Stefan Seyfried wrote:
> On Fri, Feb 10, 2006 at 01:19:13PM +0100, Pavel Machek wrote:
> > On P=E1 10-02-06 09:06:43, Stefan Seyfried wrote:
>=20
> > > Ok. Maybe i am not seeing the point. But why do we need this in t=
he kernel?
> > > Can't we handles this easily in userspace?
> >=20
> > Some kernel parts need to now: for example powernow-k8: some
>=20
> we can tell them from userspace.

No, because battery will explode if you do not slow cpu down fast
enough. And it would be extremely ugly.

Right now, interfaces we have are:

/proc/apm -- to get AC/DC info on APM

/proc/acpi/ac_adapter/*/state -- to get in on ACPI

=2E..then we have...

in-kernel interface to get AC/DC info on APM, and in-kernel interface
to get AC/DC info on ACPI (powernow-k8 needs it). Brightness needs to
use those interfaces, too.

With your proposed solution, we'd have to add
/proc/powernow_k8/you_are_on_ac and /proc/backlight/you_are_on_ac and
=2E.., or something, along with daemon to poll /proc/apm and
/proc/acpi/*/*/state (and whatever else embedded machines do), and
feed it back to kernel.

That's clearly wrong thing to do. So Matthew patch is actually
cleanup. It should allow us to kill special interfaces and have
something like /sys/power/ac ... and not having to introduce special
interfaces for pn-k8, backlight and more.

(More responses in separate thread.)

> > frequencies are not allowed when you are running off battery. [Just
> > now it is solved by not allowing those frequencies at all unless AC=
PI
> > is available; quite an ugly solution.]
>=20
> And this is a reason to include it in the kernel?
> Pavel? Is it you? What have they done to you? ;-)

=46requency scaling is currently done in kernel, and this is "battery
blows up" issue.

> I mean - we are moving suspend and everything to userspace, so i wond=
er
> why this has to be in kernel.

Unless you want LZF, encryption, and graphical progress bar, suspend
goes to userspace. But AC/DC knowledge is actually neccessary for
kernel. You can live without it on most PCs (except powernow-k8
machines and notebooks that have braindamaged), but embedded platforms
definitely need it.
								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted.=
=2E.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
