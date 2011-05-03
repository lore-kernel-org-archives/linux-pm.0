From: Valdis.Kletnieks@vt.edu
Subject: Re: [RFC][PATCH] PM: Print a warning if firmware is
	requested when tasks are frozen
Date: Tue, 03 May 2011 11:47:23 -0400
Message-ID: <15997.1304437643__10802.3138637238$1304437837$gmane$org@localhost>
References: <201105030044.51661.rjw@sisk.pl> <50363.1304379012@localhost>
	<201105031302.08910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5933986761998634266=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Tue, 03 May 2011 13:02:08 +0200."
	<201105031302.08910.rjw@sisk.pl>
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

--===============5933986761998634266==
Content-Type: multipart/signed; boundary="==_Exmh_1304437643_4857P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1304437643_4857P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 May 2011 13:02:08 +0200, "Rafael J. Wysocki" said:

> Although the WARN_ON output will probably not make it to the user's screen
> immediately, the resume will continue without the delay, because error code
> will be returned as soon as the WARN_ON triggers.
> 
> The user will likely notice the device not working after the resume and will
> look at dmesg output. :-)

Good point. I obviously didn't have enough caffeine to think it through. ;)

> > 2) What percent of the time the WARN_ON output will itself make the user
> > think the resume has died rather than just being slow, causing them to power
> > cycle and hope for a clean boot?
> > 
> > Maybe something like this instead?
> > 
> > 	if (WARN_ON(usermodehelper_is_disable()))) {
> > 		printk(KERN_WARNING "Resume continuing, but firmware for %s not loaded", device);
> 
> It's useful, but I'd rather do
> 
>  		dev_info(device, "firmware: %s will not be loaded\n", name);

That works too.  :)

> OK, updated patch is appended.

Looks good to me.


--==_Exmh_1304437643_4857P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNwCOLcC3lWbTT17ARAjk0AKC8fce+ePFBOa8hpxhovv9JinmnNQCg8Rm1
00z5bsBXrsmW5EnP7AquHF8=
=5lay
-----END PGP SIGNATURE-----

--==_Exmh_1304437643_4857P--


--===============5933986761998634266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5933986761998634266==--
