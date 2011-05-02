From: Valdis.Kletnieks@vt.edu
Subject: Re: [RFC][PATCH] PM: Print a warning if firmware is
	requested when tasks are frozen
Date: Mon, 02 May 2011 19:30:12 -0400
Message-ID: <50363.1304379012__15786.0516374514$1304379189$gmane$org@localhost>
References: <201105030044.51661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6878939186309980943=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Tue, 03 May 2011 00:44:51 +0200."
	<201105030044.51661.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============6878939186309980943==
Content-Type: multipart/signed; boundary="==_Exmh_1304379012_5156P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1304379012_5156P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 May 2011 00:44:51 +0200, "Rafael J. Wysocki" said:

> +	if (WARN_ON(usermodehelper_is_disabled()))
> +		return -EBUSY;
> +

Since this is a "no user serviceable parts inside" type of error, so I guess
WARN_ON rather than a printk(KERN_WARNING is a good idea so we get
a traceback pointing out the offending driver.

I have to wonder 2 things though:

1) What percent of the time the missing firmware (or other issues, like the
display not being resumed yet) will prevent the WARN_ON output from making it
to the display *anyhow*, so the user *still* hits the power button to try again?

2) What percent of the time the WARN_ON output will itself make the user
think the resume has died rather than just being slow, causing them to power
cycle and hope for a clean boot?

Maybe something like this instead?

	if (WARN_ON(usermodehelper_is_disable()))) {
		printk(KERN_WARNING "Resume continuing, but firmware for %s not loaded", device);
		return -EBUSY;
	}

(or whatever that %s actually needs to work)

All the same, it still looks better than what we're doing now.


--==_Exmh_1304379012_5156P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNvz6EcC3lWbTT17ARAoB3AKDdGwaSZvg4IY15nM55u5ZpdmS2ewCfdMpC
N7QaGdS2glNSsTngfe98oDo=
=T9ik
-----END PGP SIGNATURE-----

--==_Exmh_1304379012_5156P--


--===============6878939186309980943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6878939186309980943==--
