Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEA30DECE;
	Tue,  5 May 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019231; cv=none; b=WobMjUOd+iFXn5lTW/RBce3uoSzBKkiA60HO+xT9BR19f6WY2a96dsqhwcRLc6i9SQBecajMtfNW75QkOUJdRJhmZOCi06C6nbTTvRQPUhXg1LP/+QDpKFxoRN8bcKbnjqFxfCot7B8f5a3nRh6zxgrq115fgub9Q0p4XgYC2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019231; c=relaxed/simple;
	bh=JXBOIDwb6e1s8ZmaUYlylleYRr14801abN82WNXhBdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7pK6KWGUFkMlBOCfk0MfrYTM3R3cN57QNRaifUh2lpZNblYGYqB/DaLFnALRw9itySlASJ7SSzUoPHw6+A7mpPUfXGEbkHzrx4czY2E2kG+thO0l0+Q4zS50gVYy7I8JFn4hJixnVoYzHGh9+kf/LqamyjJtA19TiEvPati+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jkH6N7qm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jkH6N7qm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE011A9A;
	Tue,  5 May 2026 15:13:43 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9AF53F763;
	Tue,  5 May 2026 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778019229; bh=JXBOIDwb6e1s8ZmaUYlylleYRr14801abN82WNXhBdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkH6N7qm7iFUSnanVg4zc3SjNFJmR3DX6GnHivCcMFaj7oPAEQj3WH/yjmZ2bmsJu
	 glE6HX01WYbGrfcx9MQXTfI6OffegBZ1vX5OlSz19lkvgSAkROqw7KKgleZel35yCA
	 Vi8R92y5+9+CQk4rqYOYsk2/tUPMPGgDl5gKTO+g=
Date: Tue, 5 May 2026 23:13:44 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: Re: [PATCH v5 11/12] powercap: arm_scmi: Add get_power_uw to
 synthetic node
Message-ID: <afprmEnMf5mNf8NE@pluto>
References: <20260428090922.346069-1-philip.radford@arm.com>
 <20260428090922.346069-12-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090922.346069-12-philip.radford@arm.com>

On Tue, Apr 28, 2026 at 10:09:20AM +0100, Philip Radford wrote:
> Exposes the current power usage from the immediate children of
> the synthetic (root) powercap node. Iterates over pr->spzones and
> sums per-zone power.
> 
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
>  drivers/powercap/arm_scmi_powercap.c | 29 ++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index d74869af1633..81b5214acda4 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -270,9 +270,34 @@ static int instance_root_release(struct powercap_zone *pz)
>  	return 0;
>  }
>  
> -static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
> +static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
>  {
> -	*v = 0;
> +	struct scmi_powercap_zone *root = to_scmi_powercap_zone(pz);
> +	struct scmi_powercap_zone *child;
> +	struct scmi_powercap_root *pr;
> +	u64 acc = 0;
> +	u64 p;

These u64 can live on a single line...

> +	int ret;
> +
> +	if (!pz || !power_uw)
> +		return -EINVAL;
> +
> +	pr = container_of(root, struct scmi_powercap_root, instance_root);

usually we define macros to wrap this like to_scmi_powercap_zone()...
...even if used only once...this could be a new to_scmi_powercap_root()

> +	if (!pr)
> +		return -ENODEV;
> +
> +	list_for_each_entry(child, &pr->registered_zones[0], node) {
> +		if (child == &pr->instance_root)
> +			continue;

You'll need to check this in light of the fixes of previous patch

> +
> +		ret = scmi_powercap_get_power_uw(&child->zone, &p);
> +		if (!ret)
> +			acc += p;
> +		else
> +			dev_dbg(child->dev, "Failed to read child power: %u\n", ret);
> +	}
> +
> +	*power_uw = acc;
>  	return 0;
>  }
>  

Thanks,
Cristian
