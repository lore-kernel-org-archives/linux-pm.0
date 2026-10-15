Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71352843E;
	Thu, 15 Oct 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070687; cv=none; b=rfmit4YjKUaO9aYb/2dBFycvgX5iXWA68+/Xl+up7qP10preTzsUhjcBznv7fOWBIuMeBr+z+sXjWSfu10RmGMvIkijMjGxJJhy/Uk0G22Yc5eho0lZK7tIOanc6+EbLiFHk7dw0hRolqAq3/xaEW/oDwPDGwS9fl5YG5DxFjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070687; c=relaxed/simple;
	bh=oiChyAc90Kn2/Ub4Ktle7NP/oO/4fjwfugO+PoHt4Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtGFaoBh9wqPC1ejmw4YyAkmjCVoZNlpzx+BGYwuk1F7J6jdp8fWrgLDptd6N83WsMTaUrrRiGAoc6LhMRNYeC+7ec3VI/QfcDX/zArK3T8O1ls7EVq1IZPX1Q4pip/TFCqun7WXx54m5pkH3pwTUyaUYKU7k3gOiDU3K+BLQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtyPL9Ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtyPL9Ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0541F000C4;
	Thu, 15 Oct 2026 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070686;
	bh=CBqSEJS1pKlmdf3ndF5libgTsU24GBtrkgdWyEsVvC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DtyPL9TiozyW9P2rRYtq2WOT/lRgIOwc68mh4Mn3huviP5OWls6WyR8q4PWcDdXQU
	 zkAGHQTdqrMIQrbD/38CjQ6VMTcYhjdTLruMdZ53E+KbAK9eMZA8gG00oLnjrlsqgn
	 Jeo40wExX/LQ1OBst6rMBue65usx3sG7T2IIeKG+emXIC5XJLMhKMwu/tf5pQaZPyc
	 Ov3PNzRpb6p6LI1RAM/2c2yG3DFFYGh8B6fsjUciksIIeIzI2gxKptv7DB3N69q2ph
	 z//9IN06Z1kvu2lbubltus3KSDwNRfL7P3M81VyS8jrPW/scen1evNeuC/qFFbM70g
	 KgpHR/6uio0Gg==
Date: Thu, 15 Oct 2026 14:24:40 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 09/13] powercap: arm_scmi: Enable multiple constraints
 support
Message-ID: <20261015-urban-porcelain-smilodon-edbc1d@sudeepholla>
References: <20260909220437.1254412-1-philip.radford@arm.com>
 <20260909220437.1254412-10-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909220437.1254412-10-philip.radford@arm.com>

On Wed, Sep 09, 2026 at 10:04:33PM +0000, Philip Radford wrote:
> From: Cristian Marussi <cristian.marussi@arm.com>
> 
> Initialize the domains with all the discovered available constraints,
> making available multiple per-domain constraints when the platform has
> advertised support for multiple concurrent power limits.
> 
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> [Philip: Amended Copyright]
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
> V8->V9
> - Added validation check to make sure powercap domain doesn't have too
> many constraints
> ---
>  drivers/powercap/arm_scmi_powercap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index 2d9370aaaf5d..bcd1ba0bde8c 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -2,7 +2,7 @@
>  /*
>   * SCMI Powercap support.
>   *
> - * Copyright (C) 2022 ARM Ltd.
> + * Copyright (C) 2022-2026 ARM Ltd.
>   */
>  
>  #include <linux/device.h>
> @@ -491,7 +491,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
>  
>  	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
>  				   parent ? &parent->zone : NULL,
> -				   &zone_ops, 1, &constraint_ops);
> +				   &zone_ops, spz->info->num_cpli, &constraint_ops);
>  	if (!IS_ERR(z)) {
>  		spz->height = scmi_powercap_get_zone_height(spz);
>  		spz->registered = true;
> @@ -649,6 +649,13 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
>  		 */
>  		spz->info = powercap_ops->info_get(ph, i);
>  
> +		if (spz->info->num_cpli > MAX_CONSTRAINTS_PER_ZONE) {

Since MAX_CONSTRAINTS_PER_ZONE = 10 and our SCMI f/w can return upto 15,
we may have to warn or clamp it to 10 or both.

-- 
Regards,
Sudeep
