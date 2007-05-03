From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 03 May 2007 10:41:20 +0200
Message-ID: <1178181680.13233.74.camel__5289.1043866568$1178181692$gmane$org@johannes.berg>
References: <200705022213.35831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8683389201186734552=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705022213.35831.rjw@sisk.pl>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============8683389201186734552==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0AI45byf3M0CXvA9TK5f"


--=-0AI45byf3M0CXvA9TK5f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:

> +void hibernation_set_ops(struct hibernation_ops *ops)
> +{
> +	if (ops && !(ops->prepare && ops->enter && ops->finish)) {
> +		printk(KERN_ERR "Wrong definition of hibernation operations! "
> +			"Using defaults\n");
> +		return;
> +	}

Why not BUG_ON here as I had before? I don't see much point in giving a
runtime warning, and the docs clearly state that you must assign all
three items. Oh, I see I had a bug before when ops was NULL, but you can
still do
  BUG_ON(ops && !(ops->prepare && ops->enter && ops->finish));

> -	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> -		 pm_disk_modes[mode]);
> +	if (!error)
> +		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> +			 hibernation_modes[mode]);

Isn't that an unrelated bugfix ;) just kidding

Looks good to me but I haven't checked the acpi in detail. If I
remember, I'll try to give it all a go on my G5 later today.

johannes

--=-0AI45byf3M0CXvA9TK5f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOaAw/ETPhpq3jKURAq6eAKC51QlXtCgtV0jljzGlJq23mwzdvwCfar1V
RxkbrMi8UJuaLNqmuW1eMEE=
=vqN0
-----END PGP SIGNATURE-----

--=-0AI45byf3M0CXvA9TK5f--


--===============8683389201186734552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8683389201186734552==--
