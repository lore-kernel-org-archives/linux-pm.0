Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD547209A;
	Fri, 16 Oct 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146099; cv=none; b=FdepwxlJKFyymTUZIwA0sdFFS5iY4qkiJaRltIJyyttT6x0Yf5bORitCC77FR5tAn31xgyYU+cP46GQnEkYSkPTxQHZs8CkGue6zMgPLvuA5bP+5COr6g3lsAvuCRfVeRCO61wehpRFKYgYYBqOPLQqrZMn11jEO/FkN5hGMmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146099; c=relaxed/simple;
	bh=hJglFGaadsV/wbyEcUX3Z4qyfuj7vAwodrNb8C56c8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRx24mPT0erCahXv6yKSdt5ull/NMtxMLA09Sk8PlBWMq0FPTJC2WyO0WS5jJcrHUza89ASRlOqT4TBsiWnjWggY46uRNYuk28yjU9ZjnbrjRw9jUUtlzWCLOZUDfTrsKA6do827RIr38HN1uLlbBgPRRdg/5rFKCFwAGzZ2bKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA5y25c5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA5y25c5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F671F000C4;
	Fri, 16 Oct 2026 10:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146098;
	bh=ZLLh+H6AvF3pOzsah8RxxbzU39nSJ9TcPLlAcIWH0Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SA5y25c5Ax9XiL89LHF60r7LTjc/isW/mANFnBpopAF7cnYAH68fLLHwbl1/OVtkd
	 nurZ8/hyMKyst8EuUgHLk1ctDT2FNTC1X1UwhqJee9Yz7/+6gLU3Ase+3LoxnKUtbU
	 D2+c9LWzP3DuNy8b4SQsWU12QwdVokU7l7zIifnGyYQZEguEO5b6WLau/Vee49QXmf
	 PKdqLRCbvFFrR7FCt9HPFQdkxEdm9gPG9sc5H2zD5z9TOHutnFDhAHCKHV8raPJMmS
	 GavfobPpuZyGynW0TZKRfAUSXMjrSgQoUM4wcU1xv3vSQs5E4MmFvIxvUP+TuyFKKq
	 hHnVrmV03MAzw==
Date: Fri, 16 Oct 2026 11:21:34 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v9 12/13] powercap: arm_scmi: Add get_power_uw to
 synthetic node
Message-ID: <20261016-nostalgic-adaptable-crab-4eea62@sudeepholla>
References: <20260909220437.1254412-1-philip.radford@arm.com>
 <20260909220437.1254412-13-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909220437.1254412-13-philip.radford@arm.com>

On Wed, Sep 09, 2026 at 10:04:36PM +0000, Philip Radford wrote:
> Exposes the current power usage from the immediate children of the
> synthetic (root) powercap node. Iterates over pr->spzones and sums per-zone
> power.
> 
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
> V8->V9
> - Removed redundant if (!pr) check from instance_root_get_power_uw()
> - Stopped returning a partial sum if one child read fails
> ---
>  drivers/powercap/arm_scmi_powercap.c | 34 ++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index b5397d7675e6..aac0b00490b2 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -17,6 +17,9 @@
>  #define to_scmi_powercap_zone(z)		\
>  	container_of(z, struct scmi_powercap_zone, zone)
>  
> +#define to_scmi_powercap_root(z)		\
> +	container_of(z, struct scmi_powercap_root, instance_root.zone)
> +
>  static const struct scmi_powercap_proto_ops *powercap_ops;
>  
>  struct scmi_powercap_zone {
> @@ -453,9 +456,36 @@ static int instance_root_release(struct powercap_zone *pz)
>  	return 0;
>  }
>  
> -static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
> +static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
>  {
> -	*v = 0;
> +	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
> +	struct scmi_powercap_zone *child;
> +
> +	u64 p, acc = 0;
> +	int i, ret;
> +
> +	if (!pz || !power_uw)
> +		return -EINVAL;
> +
> +	for (i = 0; i < pr->num_zones; i++) {
> +		child = &pr->spzones[i];
> +
> +		if (!child->registered || child->invalid)
> +			continue;
> +
> +		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
> +			continue;
> +
> +		ret = scmi_powercap_get_power_uw(&child->zone, &p);

Should we skip domains without monitoring here as scmi_powercap_get_power_uw()
return -EINVAL for such domains always ? If the system has one such node, you
will always return error here ?

-- 
Regards,
Sudeep
