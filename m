From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: simpler calculation of number of
	pages in PBE list
Date: Sat, 30 Jul 2005 15:20:15 +0200
Message-ID: <20050730132015.GF1830@elf.ucw.cz>
References: <42EA87A0.908@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <42EA87A0.908@stud.feec.vutbr.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On P=E1 29-07-05 21:46:40, Michal Schmidt wrote:
> The function calc_nr uses an iterative algorithm to calculate the numbe=
r=20
> of pages needed for the image and the pagedir. Exactly the same result=20
> can be obtained with a one-line expression.
>=20
> Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

Thanks, applied.

> diff -Nurp -X dontdiff.new linux-mm/kernel/power/swsusp.c linux-mm.mich=
/kernel/power/swsusp.c
> --- linux-mm/kernel/power/swsusp.c	2005-07-28 13:57:53.000000000 +0200
> +++ linux-mm.mich/kernel/power/swsusp.c	2005-07-29 21:01:46.000000000 +=
0200
> @@ -737,18 +737,7 @@ static void copy_data_pages(void)
> =20
>  static int calc_nr(int nr_copy)
>  {
> -	int extra =3D 0;
> -	int mod =3D !!(nr_copy % PBES_PER_PAGE);
> -	int diff =3D (nr_copy / PBES_PER_PAGE) + mod;
> -
> -	do {
> -		extra +=3D diff;
> -		nr_copy +=3D diff;
> -		mod =3D !!(nr_copy % PBES_PER_PAGE);
> -		diff =3D (nr_copy / PBES_PER_PAGE) + mod - extra;
> -	} while (diff > 0);
> -
> -	return nr_copy;
> +	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
>  }
> =20
>  /**


--=20
teflon -- maybe it is a trademark, but it should not be.
