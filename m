From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Sat, 28 Apr 2007 00:11:20 +0200
Message-ID: <1177711880.3565.79.camel@johannes.berg>
References: <200703221800.l2MI0tBW026306@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4101199785966109610=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221800.l2MI0tBW026306@shell0.pdx.osdl.net>
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
To: akpm@linux-foundation.org
Cc: pavel@ucw.cz, linux-pm@lists.linux-foundation.org, rmk@arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org


--===============4101199785966109610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1/MsCnRN6ohvXOMVHQ/p"


--=-1/MsCnRN6ohvXOMVHQ/p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 10:00 -0800, akpm@linux-foundation.org wrote:
> The patch titled
>      rework pm_ops pm_disk_mode, kill misuse
> has been added to the -mm tree.  Its filename is
>      rework-pm_ops-pm_disk_mode-kill-misuse.patch

Will you be sending this patch for .22? I'd love to get my powermac/pmu
suspend work merged that gets /sys/power/state working instead of using
that pmu specific ioctl, but it depends on this patch to clean up the
mess surrounding pm_disk_mode [1].

johannes

[1] the generic code assumes that PM_DISK_PLATFORM is a great idea in
all cases. I'm surprised that suspend to disk is actually working for
anybody but acpi with S4 by default.

--=-1/MsCnRN6ohvXOMVHQ/p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMnUH/ETPhpq3jKURAnAUAKCUqyLP2/5XzdWgqnAJk3DDbXc8wwCgsnK6
6LGtSCRhYrX3yFTS9OuSM8M=
=ZfHM
-----END PGP SIGNATURE-----

--=-1/MsCnRN6ohvXOMVHQ/p--


--===============4101199785966109610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4101199785966109610==--
