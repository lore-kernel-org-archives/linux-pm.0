Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425949;
	b=DaHJFLHOt+BhRB3xA+Od5Y8ein0fJrtal0EZMc3ht2xB2GJs5/osC8SHTNCXJDVTxaNI
	 OIFTPQ1wEKnWsHnfkJFFGPle4sAFnPRh/w2y/jDnYla2F0VFrWRrtvjPj77gskQif//Ce
	 Sflmx9rY2LJDnfRwdI9mEcXqakTFCa4NA0Ie7VpNrIuAV/jEAJnAXG/rJgA7l/h6azPdE
	 hxQxJeSRI9oNw4AA7h+xVFmw37npwuq1sNrQuGlcqnHZ+/t19fT7evmBEvApliUxQ1fPw
	 dV9PT+04jKDeIsLbnSnWFYU66C527tNiPJgk6HB5zJsBlmZmp+nEK0qDFtP3M74rjqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425949;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=9gsEr2G1VwbZm52swmf076sFC83cmok9s9GQszaBVCY=;
	b=DxW/wwj4cHKvvVZQGjXByNx42fkZK89GIM3BaNOu+TL7ri0xfUHpKUA27ZvUNICtIo1b
	 afMjOYd/r51w59ZGI5yP4scAb/PDmveMzDaz6lvg7ZXsh0V5gIGxY/IF3Sz1ZjR9qSKxb
	 2odqfKdCHMe8iUNu716ghowzgz12r8rd3AA6gW7VZYqa1jiY/naMmWR66CUfOjqjcPape
	 CDS3rwS4wHKi0GwBGeH8gYBA9p+DQ0N693H9IFW2KJvhPyeHmlVIkWMH5SAPkSTc+GGTX
	 zwqdMQMFYK7O50NXwndEUJtxPH4Nwxx1d0l88AQzxXX8DUDPoZLH8hx9V4xFan14KCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Fvk+ieH9;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C7606AF80;
	Mon, 19 Oct 2026 16:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC4C7606AF80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Fvk+ieH9
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DCFF34;
	Mon, 19 Oct 2026 18:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792425820;
	bh=Tji3ce7axDGovYVH1z8z/SIxY8WW+5ipBeaPIkgyp3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fvk+ieH9IiJVLS9ig2NlDKwCLpL5+yVojSBaFdNvz8euWU4/jB45zf/1viU5hzYZ5
	 oxP7KKZvxce01Zj0TJjF4Ta6ANjU3Q6aQ+XOcPzDEFEsnd6KP8pmNxp+xcMXX8LmnQ
	 B/d35X44Ul2i1POjDeKFdMqfIouBTS44NJswxY1c=
Date: Mon, 19 Oct 2026 19:05:45 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 5/8] pmdomain: Make genpd_get_from_provider() return
 -EPROBE_DEFER
Message-ID: <20261019160545.GC3705@killaraus.ideasonboard.com>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <4524363679c1f2163aca3b3dda2bfbde170d095a.1792163045.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4524363679c1f2163aca3b3dda2bfbde170d095a.1792163045.git.geert+renesas@glider.be>

Hi Geert,

Thank you for the patch.

On Fri, Oct 16, 2026 at 05:55:44PM +0200, Geert Uytterhoeven wrote:
> Unlike provider-based look-up functions in other subsystems[1],
> genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
> the provider is not found, thus not supporting probe deferral.
> Currently this is worked around in of_genpd_add_subdomain() by remapping
> -ENOENT[2].

But not in the other functions calling genpd_get_from_provider() and
propagating the error up. Have you validated that no existing call
stacks will break ?

> Fix this for all current and future callers by returning -EPROBE_DEFER
> instead, and drop the no longer needed remapping code.
> 
> [1] of_clk_get_hw_from_clkspec(), __fwnode_reset_control_get()),
> [2] Commit 18027d6f392ee8d8 ("PM: domains: Make of_genpd_add_subdomain()
>     return -EPROBE_DEFER").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - New.
> ---
>  drivers/pmdomain/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 964e44c2f78f1d55..88c886814a5b9da3 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3021,7 +3021,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>  static struct generic_pm_domain *genpd_get_from_provider(
>  					const struct of_phandle_args *genpdspec)
>  {
> -	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
> +	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
>  	struct of_genpd_provider *provider;
>  
>  	if (!genpdspec)

Expanding the context:

>		return ERR_PTR(-EINVAL); 
>					
>	mutex_lock(&of_genpd_mutex);
>	
>	/* Check if we have such a provider in our array */
>	list_for_each_entry(provider, &of_genpd_providers, link) {
>		if (provider->node == genpdspec->np)
>			genpd = provider->xlate(genpdspec, provider->data);
>		if (!IS_ERR(genpd))
>			break;
>	}
>
>	mutex_unlock(&of_genpd_mutex);
>	
>	return genpd;

The for loop seems to imply that we can have multiple providers for the
same node. In case a provider fails, the function overrides the error
code from -EPROBE_DEFER to whatever the first xlate() returns. That may
cause issues for your use case.

If the of_genpd_providers list doesn't expect multiple providers per
device node, I would change the above into

	list_for_each_entry(provider, &of_genpd_providers, link) {
		if (provider->node == genpdspec->np) {
			genpd = provider->xlate(genpdspec, provider->data);
			break;
		}
	}

to make it explicit.

> @@ -3276,7 +3276,7 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
>  out:
>  	mutex_unlock(&gpd_list_lock);
>  
> -	return ret == -ENOENT ? -EPROBE_DEFER : ret;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
>  

-- 
Regards,

Laurent Pinchart
