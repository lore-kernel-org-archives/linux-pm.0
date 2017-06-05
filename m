From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: suspend-to-mem broken by eed4d47efe95 (ACPI / sleep: Ignore
 spurious SCI wakeups from suspend-to-idle)
Date: Mon, 5 Jun 2017 23:14:40 +0200
Message-ID: <20170605211440.GA1659@light.dominikbrodowski.net>
References: <20170605090521.GA1912@light.dominikbrodowski.net>
 <21111815.riZgbS9lI9@aspire.rjw.lan>
 <20170605150915.GA1627@light.dominikbrodowski.net>
 <CAJZ5v0h6U-JvnU03vhNz2zV1EGB8fV8zauBTGogOnxuvv0TonQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h6U-JvnU03vhNz2zV1EGB8fV8zauBTGogOnxuvv0TonQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 10:32:15PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 5, 2017 at 5:09 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > On Mon, Jun 05, 2017 at 03:08:57PM +0200, Rafael J. Wysocki wrote:
> >> On Monday, June 05, 2017 11:05:21 AM Dominik Brodowski wrote:
> >> > unfortunately, commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI
> >> > wakeups from suspend-to-idle) breaks suspend-to-mem on my Dell XPS 13
> >> > (9343) up to v4.12-rc4: Issuing
> >> >
> >> >     $ echo "mem" > /sys/power/state
> >> >
> >> > in the initramfs returns, after a while, with "write error: Resource
> >> > busy", and the system *not* having entered the sleep state in betwee=
n.
> >>
> >> Why initramfs?
> >
> > Easiest and quickest to test, with no userspace in between to interfere.
> > During normal operations, I see suspend-to-mem fail, then a fall-back to
> > s2idle...
>=20
> I see, OK.
>=20
> >> > In contrast thereto, 8a537ece3d94 (PM / wakeup: Integrate mechanism =
to abort
> >> > transitions in progress) still works fine, and allows to enter
> >> > suspend-to-mem. No real difference is to be seen in dmesg, with the =
notable
> >> > exception of
> >> >
> >> >     ACPI: Low-level resume complete
> >> >     ACPI : EC: EC started
> >> >     PM: Restoring platform NVS memory
> >> >     Suspended for N.NNNN seconds
> >> >
> >> > only showing up on working kernels. Reverting eed4d47efe95 on top of
> >> > v4.12-rc4 restores suspend-to-mem to work as expected.
> >>
> >> I'm sure it is not necessary to revert all of it.
> >
> > Thought so, just wanted to confirm that eed4d47efe95 is indeed the culp=
rit.
> >
> >> I guess what happens is that you get a wakeup event during suspend whi=
ch is
> >> aborted as a result.
> >>
> >> Please apply the partial revert below and see if it makes the issue go=
 away.
> >
> > Yes it does -- with this patch applied on top of v4.12-rc4, everything =
works
> > as expected. Both in initramfs and during normal runtime operations. On=
ly an
> > (probably unrelated) issue still appears during resume, namely "cache"
> > complaining that the non-boot CPUs should not be sleeping:
>=20
> That's unrelated.
>=20
> OK, this still leaves us with three possibilities.
>=20
> Can you please try to apply the device_pm.c part of the partial revert
> alone and see if that helps (and if not, same for the button.c and
> battery.c changes)?

Indeed, the device_pm.c part of the partial revert helps on its own.
For completeness, applying only the chunks for button.c or battery.c
does not help; whether the following stack trace (with battery.c applied)
is of any help, seems doubtful, but here it is:

[   11.312194] PM: Suspending system (mem)
[   11.312301] Suspending console(s) (use no_console_suspend to debug)
[   15.879041] psmouse serio1: Failed to deactivate mouse on isa0060/serio1
[   16.351046] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   20.695329] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/=
input/input7
[   20.903110] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   20.923324] sd 3:0:0:0: [sda] Synchronizing SCSI cache
[   20.925306] sd 3:0:0:0: [sda] Stopping disk
[   21.126993] psmouse serio1: Failed to disable mouse on isa0060/serio1
[   21.572782] ACPI : EC: event blocked
[   22.745084] PM: suspend of devices complete after 1821.805 msecs
[   22.745085] PM: suspend devices took 11.433 seconds
[   22.745086] Component: suspend devices, time: 11433
[   22.745092] ------------[ cut here ]------------
[   22.745096] WARNING: CPU: 1 PID: 515 at /home/brodo/local/kernel/git/lin=
ux/kernel/power/suspend_test.c:55 suspend_test_finish+0x76/0x80
[   22.745096] Modules linked in:
[   22.745099] CPU: 1 PID: 515 Comm: sh Not tainted 4.12.0-rc4+ #5
[   22.745100] Hardware name: Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/=
2016
<snip>
[   22.745111] Call Trace:
[   22.745114]  suspend_devices_and_enter+0xdb/0x860
[   22.745116]  ? console_unlock.part.8+0x261/0x4a0
[   22.745118]  pm_suspend+0x3c3/0x590
[   22.745119]  state_store+0x85/0x100
[   22.745122]  kobj_attr_store+0xf/0x20
[   22.745124]  sysfs_kf_write+0x37/0x40
[   22.745125]  kernfs_fop_write+0x11c/0x1a0
[   22.745128]  __vfs_write+0x37/0x140
[   22.745130]  ? preempt_count_sub+0x9b/0x100
[   22.745132]  vfs_write+0xb1/0x170
[   22.745134]  SyS_write+0x55/0xc0
[   22.745137]  entry_SYSCALL_64_fastpath+0x18/0xa8
<snip>
[   22.745173] ---[ end trace beda9cb50fa83d31 ]---
[   22.758152] PM: late suspend of devices complete after 12.961 msecs

A second suspend then does not take as long, so I presume that there is much
noise in the messages above:

[   36.538507] PM: Preparing system for sleep (mem)
[   36.538846] Freezing user space processes ... (elapsed 0.001 seconds) do=
ne.
[   36.540248] OOM killer disabled.
[   36.540250] Freezing remaining freezable tasks ... (elapsed 0.001 second=
s) done.
[   36.541671] PM: Suspending system (mem)
[   36.541759] Suspending console(s) (use no_console_suspend to debug)
[   36.561114] sd 3:0:0:0: [sda] Synchronizing SCSI cache
[   36.563755] sd 3:0:0:0: [sda] Stopping disk
[   36.593838] ACPI : EC: event blocked
[   37.785272] PM: suspend of devices complete after 1224.215 msecs
[   37.785274] PM: suspend devices took 1.244 seconds
[   37.798224] PM: late suspend of devices complete after 12.946 msecs


> Thanks,

Thank you!

	Dominik

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAlk1ybwACgkQmpdgiUyN
ow2pPBAAub11oL7AP4yezCk0sBoehiVRleJIRHr7KJ8lp99sOZ34Goal3md3Z+Hb
8M8E1rRcf8s+tov1PhUXjnEf9JlnzXs+S1K3Bb6sAUnzAVvH/wLL4apnu8j1cOyQ
E9TKZbirTWdOvpVnA0knequcy65N0bmNyr9c8j32lsVAIX2fEN5n+1+jRxZVhN5t
dQopBxvhIZgfxq0ds81cjEMmOf+4aQ0lgI50sB8nJuxAOoMMZpjf/93FC9YvcU36
Qf+2cpgLe+WZOIP3gFWKTXH9JREw8LZTNq3XculeiQ8IQ/1F0bUGb+CtZGbUKrLY
kEQ/QVcUED6x9OBnvFfPifeiQ0jRbu10yh9Mevji8SHv4OB2G7vuuFdJRqaqMMlb
heIFVfv5aiJrMaZiDnErSKzOINZseugZlmDIOZ/9pT/lquk545mdZMqn8+DG9cv1
s7aKHFASThjd3RjVsd3UJBqX8WMs5ewzWmtfPcGzxcKOlIAM3wT/4BQkTR8lcvkT
gUn9QXkRpETCeTDrr4PlV0pivWWiZWqtIkJyTdzFVL7x6XmA25+LwNEsflETFjQF
kVfwvXNSI07lakyJKibRNB0LpvpbtYmgDxiSgSBGaw6Xmld0rTuOb1HouRC1uj7c
yr6uQPLNSxcq0FuttT3PL6Asi4q2s2XTv/jMMzjtSD9ezBl2XR4=
=XCMK
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
