Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8BE3C9EE6;
	Tue,  2 Jun 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401602; cv=none; b=p8YKgrrvg+mlWfcI5IvFTnRyH6IPL8yfIBjGcHVFFwm+8s+B/n4XkoIjDHxiRI6qaLgCEf5Mb4DX2Ce5Dii7s5tbUWGmok1+i19b3RogSU30dXvtftaHv0HbEdRburS/WYtb5+0eaS/JlSzV51XByGG7syR/6Fd2C+TbThZd1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401602; c=relaxed/simple;
	bh=U2rAm6Tqi9Wts6sassnXUxd01rjK7N+TI7gK90TWtG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIsO20AVWBSPVCsI0kFuo8Rvwtmldgt8aVzSHaDfAw+55wolM1jwwcAwVOefzNOZcBhRqxutQwWvZjOfhnCAA/8sdhcro0qoyIqTSrpZPFTWwcYd6oMjxkOtgfwHWrSFiqw3iRrQOd4XmDaXhfTZaymlJvWwxJnzLUb+w7yNFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhmpl0M0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhmpl0M0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352CF1F00893;
	Tue,  2 Jun 2026 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780401601;
	bh=aKgwxGK1GJJqTHTFUyydXoQcnt59mFz2YYXS3kfZBlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lhmpl0M0+c9jCjMhf/6bmnvjbcJFobD2MEFZhpdPnPyARLNWAcBJpAYSDMR316Q69
	 VBh4N32AAkN/lmU0InBSgfbAJNB58Vxe7mP3GcFchkP1JySWgNIcHlh39h7hL1rUgH
	 xXZHhM+kqhzYDpxRm337Jr5lIKQu2K12mpsUNjAcuwDuPB4CymlybJ/4JtlXoFtI4m
	 guFxgxlX7SzTOSBh2ecwx1VY0k/d5USwT0R6tS4KAB9jz7gZOExSxBB2zJ2EScKlZJ
	 eNnzImhY52uEAxMVjQ6/NEjDFk9Tzki2wpl/om0sG61ybEnJj/dlSydh/D3PnrdfgM
	 HP/DmijE7J7SA==
Date: Tue, 2 Jun 2026 13:59:59 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] pmdomain: tegra: Add support for multi-socket
 platforms
Message-ID: <ah6_-WJrMOiPkMVS@orome>
References: <20260602083959.350689-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3addjwjtj7pyus6z"
Content-Disposition: inline
In-Reply-To: <20260602083959.350689-1-jonathanh@nvidia.com>


--3addjwjtj7pyus6z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2] pmdomain: tegra: Add support for multi-socket
 platforms
MIME-Version: 1.0

On Tue, Jun 02, 2026 at 09:39:59AM +0100, Jon Hunter wrote:
> On multi-socket platforms each socket has its own BPMP that is
> registered with the kernel. For such platforms prefix the NUMA ID for
> each socket to the BPMP powergate name to ensure there is a unique name
> for each power-domain. Note that we only add the NUMA ID for powergates
> that return a valid name because an invalid name indicates that the
> powergate ID is not supported.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V1:
> - Use NUMA ID as a prefix and not a suffix for the powergate name.
>=20
>  drivers/pmdomain/tegra/powergate-bpmp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/t=
egra/powergate-bpmp.c
> index 8cde4f384846..5e869b0eb96e 100644
> --- a/drivers/pmdomain/tegra/powergate-bpmp.c
> +++ b/drivers/pmdomain/tegra/powergate-bpmp.c
> @@ -137,6 +137,11 @@ static char *tegra_bpmp_powergate_get_name(struct te=
gra_bpmp *bpmp,
>  	if (err < 0 || msg.rx.ret < 0)
>  		return NULL;
> =20
> +	if (response.get_name.name[0] !=3D '\0' &&
> +	    dev_to_node(bpmp->dev) !=3D NUMA_NO_NODE)
> +		return kasprintf(GFP_KERNEL, "%d-%s", dev_to_node(bpmp->dev),
> +				 response.get_name.name);
> +
>  	return kstrdup(response.get_name.name, GFP_KERNEL);

Why are we not checking response.get_name.name for the empty string in
the single socket case? Or the other way around: why is this important
for multi-socket if it isn't for single socket?

Looking at the caller of this function, it will check for this case
itself, so I'm thinking we should rework that as part of this patch and
simply return NULL early for both cases when name[0] =3D=3D '\0'. That way
the caller is simplified and we get a bit more consistency in this
function. It is going to make for a slightly bigger diff, but I think
overall it'd be an improvement.

Thierry

--3addjwjtj7pyus6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoexbwACgkQ3SOs138+
s6FfHA//WJZ1Tgu/Ev2oE0bXvxR2VPOLEBhV3eGjbmU0RRrJPc0wQ1RkDeV5JgTy
wXO2IlDL/iQUy87o6PGa8n7USOg/vtSzQmYhbt0F5U2FuwZQZdC+kxS4tEGQucqk
dSGvTZOm2i6W7eD8mebeQAvvQkthuk5h+VvKLU3gWWsR6XAJgnKZKquK5Jzybpuu
cO+bx7sHoH4/mO+fOKy/Yc9CnyuJKlfiAOeU2f4o5bZrx4Iz0DGVMd0CAJn85Z0s
/JMgC5jMeX7a0Yj531n0Ol3k4C36E9/3RtkS+qOoeaDUwSmI6E+2CcLECj7GMmQM
amI7IHCozTtzlZDoEhF5x2ZyhFMd26So2T8Rqy3nLXk1B/kIP7zVsnRirm9tnTNf
4fDPOY+WZUfrSWyCOeVMtZDdkMbf8W8Oknwmo/555pavGLuNyLir+pXaY1zBvCjZ
ggJdbB28QBePo2m2Pz02L9qut2+yO9kCnwuWSxMD/AHIrx7vaqAQHKIJRNK2N4gS
H21sRMbb40/o4BgzyguzLcUVEf67+6/anLXyT2Zs2WCljOtsQaaTwGcjy2BxiSYP
GMkS7bHt4bbOya5kUIk6YGJV2CjkPD9hDng2N2UM6D6PsH1Az9rzBSXpE1MwbXAC
oBN5ShixLkIdCVTfQGYotQLe/QfNoG/vkMWNsBJM59TpoH94B/k=
=PP9u
-----END PGP SIGNATURE-----

--3addjwjtj7pyus6z--
