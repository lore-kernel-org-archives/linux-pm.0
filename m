From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH -mm] PM: Change ordering of suspend and resume code
Date: Mon, 18 Dec 2006 08:42:26 +0100
Message-ID: <20061218074226.GO26170@suse.de>
References: <200612171858.16380.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200612171858.16380.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>, suspend-devel List <suspend-devel@lists.sourceforge.net>, Stephen Hemminger <shemminger@osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Sun, Dec 17, 2006 at 06:58:15PM +0100, Rafael J. Wysocki wrote:
> Hi,
>=20
> As indicated in a recent thread on Linux-PM, it's necessary to call
> pm_ops->finish() before devce_resume(), but enable_nonboot_cpus() has=
 to be
> called before pm_ops->finish()
> (cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.ht=
ml).
> For consistency, it seems reasonable to call disable_nonboot_cpus() a=
fter
> device_suspend().
>=20
> This way the suspend code will remain symmetrical with respect to the=
 resume
> code and it may allow us to speed up things in the future by suspendi=
ng and
> resuming devices and/or saving the suspend image in many threads.

Good. A thread to do progress bars :-)
=20
> The first patch changes the ordering of the suspend-to-RAM code and i=
s
> untested, because my boxes continue refusing to resume from RAM for o=
ther
> reasons.  If anyone can, please do me a favour and test it.
>=20
> The second patch changes the ordering of the built-in suspend-to-disk=
 code,
> and the last two patches modify the swsusp userland interface code
> accordingly.  As far as the last patch is concerned, I've decided to =
change
> the existing ioctls, so that the patched kernel works with the "old" =
userland.
> I don't think this change breaks anything of importance, but if it do=
es, we
> can just add (yet) another ioctl to set the platform mode, although i=
n that
> case the userland would have to be changed as well.
>=20
> All of the patches are against 2.6.20-rc1 and should not be used with=
 any
> earlier kernel.

I'll test them, but probably not this year :-(
I'll only get to it during the first week of January.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
