From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6 patch] kernel/power/swsusp.c: make a variable
	static
Date: Sat, 7 May 2005 00:48:47 +0200
Message-ID: <20050506224847.GH5620@elf.ucw.cz>
References: <20050506212734.GQ3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20050506212734.GQ3590@stusta.de>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On P=E1 06-05-05 23:27:35, Adrian Bunk wrote:
> This patch makes a needlessly global variable static.
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> --- linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c.old	2005-05-03 07:4=
8:39.000000000 +0200
> +++ linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c	2005-05-03 07:48:49=
.000000000 +0200
> @@ -81,7 +81,7 @@
>  extern char resume_file[];
> =20
>  /* Local variables that should not be affected by save */
> -unsigned int nr_copy_pages __nosavedata =3D 0;
> +static unsigned int nr_copy_pages __nosavedata =3D 0;
> =20
>  /* Suspend pagedir is allocated before final copy, therefore it
>     must be freed after resume

ACK.

--=20
Boycott Kodak -- for their patent abuse against Java.
