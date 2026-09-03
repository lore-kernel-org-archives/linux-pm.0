Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620F470457;
	Thu,  3 Sep 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425708; cv=none; b=V8KLWQcB/+uaB0lMxxT3DJze2TurPPWQr4iQ8I/O1lsdi7HZU7SBSPHJQ6VpinUJHe23E8TV6hszoPhJialy1wtF0q+CK9n7ROJa1Eske9FrTCh8JfZAJy1X0W9N8P9kXjlP+sBdBAd+i6sE/tYAqnKxEmlmEywo12qlzOBu3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425708; c=relaxed/simple;
	bh=wLtS0JL6ggyhewZvRL5WF+lOsyPJjm9EeqxYWvK6TXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mzer7XAoFjVRh6eay6rpJa2nrdPiufGTtIJSwCV6PiEZZMJKVuiw1iqJ6tLbtABRFN2diqSzMn9eDm/HHF16gXTWPVk9mGHdKkGbn43kG8nei/d3jAeUlfKwDkNevGqunWfMHXEWxiRp7OUgHx5K9RDQpcc0dLvIEgTNBdENHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C7BAF2058C4;
	Thu, 03 Sep 2026 10:55:01 +0200 (CEST)
Message-ID: <f3e365f5440cbd005df45410a89032dcf685258e.camel@pengutronix.de>
Subject: Re: [PATCH v3 06/12] reset: Extract
 __reset_control_get_from_provider()
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
Date: Thu, 03 Sep 2026 10:55:01 +0200
In-Reply-To: <2824c50f77aa287a3555533e4b9760109aae1741.1788338320.git.geert+renesas@glider.be>
References: <cover.1788338320.git.geert+renesas@glider.be>
	 <2824c50f77aa287a3555533e4b9760109aae1741.1788338320.git.geert+renesas@glider.be>
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
> Extract the code to create a reset_control structure from a given
> provider into its own function, so it can be reused later.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  drivers/reset/core.c | 92 ++++++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 38e189d04d09b270..8af7cd2e8a5029df 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -1135,6 +1135,54 @@ __reset_find_rcdev(const struct fwnode_reference_a=
rgs *args, bool gpio_fallback)
>  	return NULL;
>  }
> =20
> +static struct reset_control *
> +__reset_control_get_from_provider(const struct fwnode_reference_args *ar=
gs,
> +				  struct fwnode_handle *consumer, int index,
> +				  bool gpio_fallback,
> +				  enum reset_control_flags flags)
> +{
> +	struct reset_control *rstc =3D ERR_PTR(-EINVAL);
> +	struct reset_controller_dev *rcdev;
> +	int rstc_id =3D -EINVAL;
> +
> +	guard(mutex)(&reset_list_mutex);
> +
> +	rcdev =3D __reset_find_rcdev(args, gpio_fallback);
> +	if (!rcdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	if (WARN_ON(args->nargs !=3D rcdev->fwnode_reset_n_cells))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (rcdev->of_xlate && is_of_node(consumer)) {
> +		struct device_node *np =3D to_of_node(consumer);
> +		struct of_phandle_args of_args;
> +		int ret;
> +
> +		ret =3D of_parse_phandle_with_args(np,
> +					 gpio_fallback ? "reset-gpios" : "resets",
> +					 gpio_fallback ? "#gpio-cells" : "#reset-cells",
> +					 gpio_fallback ? 0 : index,
> +					 &of_args);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		rstc_id =3D rcdev->of_xlate(rcdev, &of_args);
> +		of_node_put(of_args.np);
> +	} else if (rcdev->fwnode_xlate) {
> +		rstc_id =3D rcdev->fwnode_xlate(rcdev, args);
> +	}
> +	if (rstc_id < 0)
> +		return ERR_PTR(rstc_id);
> +
> +	flags &=3D ~RESET_CONTROL_FLAGS_BIT_OPTIONAL;

This should stay in __fwnode_reset_control_get().

> +
> +	scoped_guard(mutex, &rcdev->lock)
> +		rstc =3D __reset_control_get_internal(rcdev, rstc_id, flags);
> +
> +	return rstc;

Just return __reset_control_get_internal(...) directly, the rstc local
variable is not needed.

> +}
> +
>  struct reset_control *
>  __fwnode_reset_control_get(struct fwnode_handle *fwnode, const char *id,=
 int index,
>  			   enum reset_control_flags flags)
> @@ -1142,10 +1190,7 @@ __fwnode_reset_control_get(struct fwnode_handle *f=
wnode, const char *id, int ind
>  	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
>  	bool gpio_fallback =3D false;
>  	struct reset_control *rstc =3D ERR_PTR(-EINVAL);
> -	struct reset_controller_dev *rcdev;
>  	struct fwnode_reference_args args;
> -	struct of_phandle_args of_args;
> -	int rstc_id =3D -EINVAL;
>  	int ret;
> =20
>  	if (!fwnode)
> @@ -1185,46 +1230,9 @@ __fwnode_reset_control_get(struct fwnode_handle *f=
wnode, const char *id, int ind
>  		}
>  	}
> =20
> -	guard(mutex)(&reset_list_mutex);
> -
> -	rcdev =3D __reset_find_rcdev(&args, gpio_fallback);
> -	if (!rcdev) {
> -		rstc =3D ERR_PTR(-EPROBE_DEFER);
> -		goto out_put;
> -	}
> -
> -	if (WARN_ON(args.nargs !=3D rcdev->fwnode_reset_n_cells)) {
> -		rstc =3D ERR_PTR(-EINVAL);
> -		goto out_put;
> -	}
> -
> -	if (rcdev->of_xlate && is_of_node(fwnode)) {
> -		ret =3D of_parse_phandle_with_args(to_of_node(fwnode),
> -					 gpio_fallback ? "reset-gpios" : "resets",
> -					 gpio_fallback ? "#gpio-cells" : "#reset-cells",
> -					 gpio_fallback ? 0 : index,

Hmm, I think this gpio_fallback disambiguation is not needed. In the
gpio_fallback case (lookup via "reset-gpios") we should always get a
reset_gpio rcdev with fwnode_xlate, not of_xlate.
Not an issue for this refactor, though.

> -					 &of_args);
> -		if (ret) {
> -			rstc =3D ERR_PTR(ret);
> -			goto out_put;
> -		}
> -
> -		rstc_id =3D rcdev->of_xlate(rcdev, &of_args);
> -		of_node_put(of_args.np);
> -	} else if (rcdev->fwnode_xlate) {
> -		rstc_id =3D rcdev->fwnode_xlate(rcdev, &args);
> -	}
> -	if (rstc_id < 0) {
> -		rstc =3D ERR_PTR(rstc_id);
> -		goto out_put;
> -	}
> -
> -	flags &=3D ~RESET_CONTROL_FLAGS_BIT_OPTIONAL;

Keep this here.

> -
> -	scoped_guard(mutex, &rcdev->lock)
> -		rstc =3D __reset_control_get_internal(rcdev, rstc_id, flags);
> +	rstc =3D __reset_control_get_from_provider(&args, fwnode, index,
> +						 gpio_fallback, flags);
> =20
> -out_put:
>  	fwnode_handle_put(args.fwnode);
> =20
>  	return rstc;

With that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
