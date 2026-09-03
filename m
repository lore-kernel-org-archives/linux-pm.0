Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B74137AD;
	Thu,  3 Sep 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429833; cv=none; b=tJY6y00Fr8aVb1osvBqqkCp0/xjuoVAA363ALoLk1HQk33TxICUAD1mcG0ahH/aZVbGj4ZJ6Ny5bHxM1FGPtsSg1rsN4ljk3YrxlqeuYJ4Qe0BA5NJD9e4HJd2odYRX3GkHZvhcVSOXL7hFq+3ruPUSi+kP8GjXd+tpY0Yhs/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429833; c=relaxed/simple;
	bh=ID/ALhobsxfSAGQbWF+Z1Ci7Bfm1CH1TOIk+JV2Ef1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5P/BHVEa24msH+tGsGzBopdbjiWYvmN0tfgKgs/hnP47Bl5+jeiBXqn+Qjav+wXycUXPXBZxnsxvTGaESmrFLOMlBONJ49C9HADqAJ3jkQqagUPcBS5ud9MjXNv/F8dU0zss1Rkx/XpKFmSRepMmc8otYipKnfltyPbxz6Lu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 83FE620177F;
	Thu, 03 Sep 2026 12:03:32 +0200 (CEST)
Message-ID: <9d734e555e9f074ffd93791a73c054ce92212f67.camel@pengutronix.de>
Subject: Re: [PATCH v3 07/12] reset: Add
 reset_control_get_from_provider_exclusive()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd	 <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet	 <jbrunet+clk@baylibre.com>, Sudeep
 Holla <sudeep.holla@kernel.org>, Cristian Marussi
 <cristian.marussi@arm.com>, Saravana Kannan <saravanak@kernel.org>, Ulf
 Hansson	 <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Marek
 Vasut	 <marek.vasut+renesas@mailbox.org>, Bartosz Golaszewski	
 <bartosz.golaszewski@oss.qualcomm.com>, Konrad Dybcio	
 <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>,
 Vinod Koul <vkoul@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Kuninori Morimoto	
 <kuninori.morimoto.gx@renesas.com>, =?ISO-8859-1?Q?Cl=E9ment?= Le Goffic	
 <clegoffic@baylibre.com>
Cc: devicetree@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 12:03:32 +0200
In-Reply-To: <619a6e41495adfdae3e2e6c0fee97e0550a5c404.1788338320.git.geert+renesas@glider.be>
References: <cover.1788338320.git.geert+renesas@glider.be>
	 <619a6e41495adfdae3e2e6c0fee97e0550a5c404.1788338320.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-09-02 at 13:29 +0200, Geert Uytterhoeven wrote:
> When stacking two reset controllers, the upper one should go through the
> proper channels: request exclusive reset controls and use them via the
> reset_control_*() APIs.  However, unlike the clock subsystem, which has
> of_clk_get_from_provider(), the reset subsystem does not offer a way to
> lookup and obtain a reset from a reset provider.
>=20
> Hence add a public helper reset_control_get_from_provider_exclusive()
> to lookup and obtain an exclusive reference to a reset controller, based
> on the recently introduced __reset_control_get_from_provider() helper.
> This will be used by the R-Car X5H Module Controller driver.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Replace reset_controller_get_provider() by
>     reset_control_get_from_provider_exclusive(),
>   - Add kerneldoc,
>=20
> v2:
>   - No changes.
> ---
>  drivers/reset/core.c  | 37 ++++++++++++++++++++++++++++++++-----
>  include/linux/reset.h |  8 ++++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 8af7cd2e8a5029df..6d4c95b3edb18248 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -1141,6 +1141,7 @@ __reset_control_get_from_provider(const struct fwno=
de_reference_args *args,
>  				  bool gpio_fallback,
>  				  enum reset_control_flags flags)
>  {
> +	struct fwnode_handle *fwnode =3D consumer ?: args->fwnode;
>  	struct reset_control *rstc =3D ERR_PTR(-EINVAL);
>  	struct reset_controller_dev *rcdev;
>  	int rstc_id =3D -EINVAL;
> @@ -1154,18 +1155,26 @@ __reset_control_get_from_provider(const struct fw=
node_reference_args *args,
>  	if (WARN_ON(args->nargs !=3D rcdev->fwnode_reset_n_cells))
>  		return ERR_PTR(-EINVAL);
> =20
> -	if (rcdev->of_xlate && is_of_node(consumer)) {
> -		struct device_node *np =3D to_of_node(consumer);
> +	if (rcdev->of_xlate && is_of_node(fwnode)) {
> +		struct device_node *np =3D to_of_node(fwnode);
>  		struct of_phandle_args of_args;
>  		int ret;
> =20
> -		ret =3D of_parse_phandle_with_args(np,
> +		if (consumer) {
> +			ret =3D of_parse_phandle_with_args(np,
>  					 gpio_fallback ? "reset-gpios" : "resets",
>  					 gpio_fallback ? "#gpio-cells" : "#reset-cells",
>  					 gpio_fallback ? 0 : index,
>  					 &of_args);
> -		if (ret)
> -			return ERR_PTR(ret);
> +			if (ret)
> +				return ERR_PTR(ret);
> +		} else {
> +			of_args.np =3D of_node_get(np);
> +			of_args.args_count =3D args->nargs;
> +
> +			for (unsigned int i =3D 0; i < args->nargs; i++)
> +				of_args.args[i] =3D args->args[i];

This should error out if args->args[i] > U32_MAX.

> +		}
> =20
>  		rstc_id =3D rcdev->of_xlate(rcdev, &of_args);
>  		of_node_put(of_args.np);
> @@ -1257,6 +1266,24 @@ struct reset_control *__reset_control_get(struct d=
evice *dev, const char *id,
>  }
>  EXPORT_SYMBOL_GPL(__reset_control_get);
> =20
> +/**
> + * reset_control_get_from_provider_exclusive - Lookup and obtain an excl=
usive
> + *					       reference to a reset controller.
> + * @args: Reference to the reset controller provider with all the args l=
ike
> + *	  reset number

It is implied, but should this explicitly mention that this must not be
a reference to a GPIO provider?

> + *
> + * Returns a struct reset_control or IS_ERR() condition containing errno=
.
> + * If this function is called more than once for the same reset control =
it will
> + * return -EBUSY.
> + */
> +struct reset_control *
> +reset_control_get_from_provider_exclusive(const struct fwnode_reference_=
args *args)
> +{
> +	return __reset_control_get_from_provider(args, NULL, 0, false,
> +						 RESET_CONTROL_EXCLUSIVE);
> +}
> +EXPORT_SYMBOL_GPL(reset_control_get_from_provider_exclusive);

regards
Philipp
