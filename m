From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [Bug 8498], [Bug 8510], and Re: Can't s2ram 22-rc2
Date: Mon, 21 May 2007 19:43:55 +0400
Message-ID: <200705211943.57283.arvidjaar__44688.2269032814$1179762559$gmane$org@mail.ru>
References: <Pine.LNX.4.44L0.0705211040330.4496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9080197744394689372=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705211040330.4496-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Jiri Slaby <jirislaby@gmail.com>, Avuton Olrich <avuton@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

--===============9080197744394689372==
Content-Type: multipart/signed; boundary="nextPart2188584.Z8pGUFHVNp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2188584.Z8pGUFHVNp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 21 May 2007, Alan Stern wrote:
> Andrey, Soeren, and Avuton: Please try this patch with 2.6.22-rc2 or
> later and see if it fixes your problems.
>

It does; thank you!

> Greg, if this works then I'll send it in the proper form for a patch,
> and you can use it to replace
>
> 	usb-make-the-autosuspend-workqueue-thread-freezable.patch
>
> Alan Stern
>
>
> Index: 2.6.22-rc2/drivers/usb/core/usb.c
> ===================================================================
> --- 2.6.22-rc2.orig/drivers/usb/core/usb.c
> +++ 2.6.22-rc2/drivers/usb/core/usb.c
> @@ -205,7 +205,7 @@ struct device_type usb_device_type = {
>
>  static int ksuspend_usb_init(void)
>  {
> -	ksuspend_usb_wq = create_singlethread_workqueue("ksuspend_usbd");
> +	ksuspend_usb_wq = create_freezeable_workqueue("ksuspend_usbd");
>  	if (!ksuspend_usb_wq)
>  		return -ENOMEM;
>  	return 0;



--nextPart2188584.Z8pGUFHVNp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGUb49R6LMutpd94wRAn+gAKCHsimreEdVyPUPCfOTjOLzHjXFBACgh9Zt
65H2C5t6OGVU1byEOntbduk=
=DjLW
-----END PGP SIGNATURE-----

--nextPart2188584.Z8pGUFHVNp--

--===============9080197744394689372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9080197744394689372==--
