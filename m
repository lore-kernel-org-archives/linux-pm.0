From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 02 May 2007 10:21:46 +0200
Message-ID: <1178094106.13233.39.camel@johannes.berg>
References: <20070425072350.GA6866@ucw.cz>
	<1177945191.5102.93.camel@johannes.berg>
	<200705011605.16993.rjw@sisk.pl> <200705020002.55331.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9038077270179617644=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705020002.55331.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============9038077270179617644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uxtXKvAPOW064AxgmKyr"


--=-uxtXKvAPOW064AxgmKyr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 00:02 +0200, Rafael J. Wysocki wrote:

> Well, having a look on the ACPI spec I'm thinking that what we're trying =
to do
> with this patch is actually wrong.

No idea :)

> Instead, we should rip off all of the invocations of pm_ops->whatever() f=
rom
> the hibernation code paths (with the below exceptions) and *if* the platf=
orm
> method is to be used, call pm_ops to make the system go down, in the foll=
owing
> way:
> 1) call pm_ops->prepare(PM_SUSPEND_DISK)
> 2) suspend devices (ie. call device_suspend() etc.)
> 3) call pm_ops->enter(PM_SUSPEND_DISK)
> and if that *fails* (ie. pm_ops->enter() returns):
> 4) call pm_ops->finish(PM_SUSPEND_DISK)
> 5) halt the system

Can we still split that off to another method so we don't use pm_ops? No
matter how we invoke hibernation_ops or in what order, imho we shouldn't
use pm_ops.

johannes

--=-uxtXKvAPOW064AxgmKyr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOEoa/ETPhpq3jKURAhU2AJ9rhLt3S+thHSCUjK4JB9emcoj8vwCgmWpC
dD9LrY4kxjCoOMt/VFSEoOA=
=i2W3
-----END PGP SIGNATURE-----

--=-uxtXKvAPOW064AxgmKyr--


--===============9038077270179617644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9038077270179617644==--
