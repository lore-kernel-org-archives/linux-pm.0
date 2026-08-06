Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30637CD40;
	Thu,  6 Aug 2026 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004005; cv=none; b=IfriH2aaA95KvEia3+doi8BQgh1+G0cnqJ5JfZMBFIPNS0m+f5NQj58uTzLUvcozGag1SxQKZk7N9D47fU2ADsa1G1ssGjk6ce9QxoSXC3UAq4PqFr7VWiNDh182Uacn6SRGBet3E7Eri1nkE5aMe2ZRER0PtCRBOouHJDznwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004005; c=relaxed/simple;
	bh=m+ixxoAKX9ofTb0vud6B0UlDpsMUUasBvg0zQYoPk34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHkSzpH+4iBSSD3V+fbgN18+Wk5EipoUx5KKVtfhyZYGWtfQt+AWaMETee/mvr12cnPNAKYp+7andyt3vAY/rBLQOT40RFhnoUGuSzu75AK3s4NjtvYEPs8vlwNmGhYQOCX4zEaEZ5v7xhVXpZ2997+yUzaJPchwgNF/SSt17DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 424B0201EE8;
	Thu, 06 Aug 2026 10:13:19 +0200 (CEST)
Message-ID: <7c30baacac8c75037f32c0ac3099a6107cbec38b.camel@pengutronix.de>
Subject: Re: [PATCH v3 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette	 <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney	 <bmasney@redhat.com>, Ulf
 Hansson <ulfh@kernel.org>, Wolfram Sang	
 <wsa+renesas@sang-engineering.com>, Marek Vasut	
 <marek.vasut+renesas@mailbox.org>, Kuninori Morimoto	
 <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Aug 2026 10:13:19 +0200
In-Reply-To: <89e6a71b35703f10e12f520af1f389b5f40f4b35.1785941595.git.geert+renesas@glider.be>
References: <cover.1785941595.git.geert+renesas@glider.be>
	 <89e6a71b35703f10e12f520af1f389b5f40f4b35.1785941595.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-08-05 at 17:20 +0200, Geert Uytterhoeven wrote:
> Add a minimal Module Controller driver for the R-Car X5H (R8A78000) SoC.
> For now this just supports the always-on power domains, and dummy module
> clocks and resets for the serial console (which is enabled by the boot
> loader).
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Replace <linux/mod_devicetable.h> by more specific
>     <linux/device-id/of.h> in v7.2-rc2,
>   - Add a comment to document only always-on domains are supported,
>   - Consistently use /* sentinel */ for zero sentinels,
>   - Drop trailing commas from sentinels,
>=20
> v2:
>   - Spin off from "pmdomain: renesas: Add R-Car X5H MDLC SCMI remapping
>     driver",
>   - Add default support not using SCMI,
>   - Drop all SCMI remapping support,
>   - Document use of -1 as a sentinel,
>   - Rename struct r8a78000_mdlc_info to mdlc_info,
>   - Print HW IDs in hexadecimal,
>   - Reduce log level for unsupported MDLC instances from warn to dbg,
> ---
>  drivers/pmdomain/renesas/Kconfig         |   4 +
>  drivers/pmdomain/renesas/Makefile        |   1 +
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 330 +++++++++++++++++++++++
>  drivers/soc/renesas/Kconfig              |   1 +
>  4 files changed, 336 insertions(+)
>  create mode 100644 drivers/pmdomain/renesas/r8a78000-mdlc.c
>=20
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/=
renesas/r8a78000-mdlc.c
> new file mode 100644
> index 0000000000000000..5c8acead7cff9bdd
> --- /dev/null
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -0,0 +1,330 @@
[...]
> +#define DEFINE_MDLC_RESET_WRAPPER(op)					    \
> +	static int r8a78000_mdlc_ ## op(struct reset_controller_dev *rcdev, \
> +					unsigned long id)		    \
> +	{								    \
> +		struct r8a78000_mdlc_priv *priv =3D rcdev_to_priv(rcdev);	    \
> +									    \
> +		dev_dbg(priv->dev, "%s: Ignoring\n", __func__);		    \
> +		return 0;						    \
> +	}
> +
> +DEFINE_MDLC_RESET_WRAPPER(reset)
> +DEFINE_MDLC_RESET_WRAPPER(assert)
> +DEFINE_MDLC_RESET_WRAPPER(deassert)
> +DEFINE_MDLC_RESET_WRAPPER(status)
> +
> +static const struct reset_control_ops r8a78000_mdlc_reset_ops =3D {
> +	.reset =3D r8a78000_mdlc_reset,
> +	.assert =3D r8a78000_mdlc_assert,
> +	.deassert =3D r8a78000_mdlc_deassert,
> +	.status =3D r8a78000_mdlc_status,

Are .reset and .status needed by any consumers?
I'd leave them -ENOTSUPP otherwise.

regards
Philipp
