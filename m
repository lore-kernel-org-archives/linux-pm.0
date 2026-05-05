Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412B2BE026;
	Tue,  5 May 2026 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013394; cv=none; b=gWmHAzHG1mMimewyuX5V7uMoefsF+VUr+mPXGI613iq9BMzXJyw1glViaXUTO82KrrOzfAZGJQ0HkrP6Egc+Pr/qUQ5mlMW22V9JsB8t3eQMvcl/iwG3x/FzHCDaT+lVc+impvhQb7AYsWURnBgnt0nFxRxrpGywKScHXrNjBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013394; c=relaxed/simple;
	bh=XoDo/BJrZK4cQyuJeIpDlXSHvN6Qo6ESDgeLnoaopG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho6PqzgS5pTMPxD+hC8PN5GyRGx595LvEatCUoOFxIbO318HKRzlTM2/GoYTjHcXpEofgapLdwO6O6wxsnhleTNW5BAy4nkTPYmCfdN87bVFgifVGOku6afjOlkrH+yBQINwQnkVB0K+HqtWwSluDlqLMVXVHkm7eYXoqU8AFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MqTaghAZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MqTaghAZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6AAC1BB0;
	Tue,  5 May 2026 13:36:26 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D5C3F763;
	Tue,  5 May 2026 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778013392; bh=XoDo/BJrZK4cQyuJeIpDlXSHvN6Qo6ESDgeLnoaopG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqTaghAZAr2+Ff4nnCPEGc5h4c7scu3KsGj0tEPSH3qRIvIkPkvg34LJNIcrABugc
	 PrnyVYk9F+O3TYZNIuiua/Qbdg8CX8XyVTBHQXKtjoSUfAxF91Y6pmkESltkSeqyJa
	 QHjVX33PKKRJLZ8Yp2W5yG9wHV3WPA6mmUdPhpI0=
Date: Tue, 5 May 2026 21:36:26 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: Re: [PATCH v5 09/12] firmware: arm_scmi: add Powercap MAI get/set
 support
Message-ID: <afpUytkInNKLTB0k@pluto>
References: <20260428090922.346069-1-philip.radford@arm.com>
 <20260428090922.346069-10-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090922.346069-10-philip.radford@arm.com>

On Tue, Apr 28, 2026 at 10:09:18AM +0100, Philip Radford wrote:
> Add support for Power Measurement Averaging Interval (MAI)

Hi,

> get and set operations to the SCMI powercap protocol driver.
> Extends scmi_powercap_info to store MAI configuration and
> implement MAI get/set via xfer and optional fast-channel
> support.

You have to stay under 75 chars...ok...but I'd say this commit message
lines are way to short...you can stretch a bit more towards 75chars
without having to split words I think....because

t
o
o

s
h
o
r
t

l
i
n
e
s

are not so good anyway :P

> 
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
>  drivers/firmware/arm_scmi/powercap.c | 120 +++++++++++++++++++++++++++
>  include/linux/scmi_protocol.h        |   8 ++
>  2 files changed, 128 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
> index 86262eb0f34a..b5879f204b5e 100644
> --- a/drivers/firmware/arm_scmi/powercap.c
> +++ b/drivers/firmware/arm_scmi/powercap.c
> @@ -401,6 +401,34 @@ scmi_powercap_domain_attrs_process(const struct scmi_protocol_handle *ph,
>  		dom_info->notify_powercap_measurement_change =
>  			SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
>  
> +	if (PROTOCOL_REV_MAJOR(ph->version) >= 0x3) {
> +		struct scmi_msg_resp_powercap_domain_attributes_v3 *resp_v3 = r;
> +
> +		flags = le32_to_cpu(resp_v3->attributes);
> +		if (pinfo->notify_measurements_cmd)
> +			dom_info->notify_powercap_measurement_change =
> +			       SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
> +
> +		dom_info->mai_config = SUPPORTS_POWERCAP_MAI_CONFIGURATION(flags);
> +		dom_info->min_mai = le32_to_cpu(resp_v3->min_mai);
> +		dom_info->max_mai = le32_to_cpu(resp_v3->max_mai);
> +		dom_info->mai_step = le32_to_cpu(resp_v3->mai_step);
> +
> +		if (dom_info->mai_config) {
> +			ret = scmi_powercap_validate(dom_info->min_mai,
> +						     dom_info->max_mai,
> +						     dom_info->mai_step,
> +						     dom_info->mai_config);
> +
> +			if (ret) {
> +				dev_warn(ph->dev, "Platform reported problem MAI config for domain %d - %s\n",

"....reported invalid MAI config for domain..."

> +					 dom_info->id, dom_info->name);
> +
> +				return ret;
> +			}
> +		}
> +	}
> +
>  	dom_info->extended_names = SUPPORTS_EXTENDED_NAMES(flags);
>  
>  	dom_info->async_powercap_cap_set =
> @@ -1082,6 +1110,96 @@ static int scmi_powercap_cap_enable_get(const struct scmi_protocol_handle *ph,
>  	return 0;
>  }
>  
> +static int scmi_powercap_xfer_mai_get(const struct scmi_protocol_handle *ph, u32 domain_id,
> +				      u32 *mai)

..bad alignment and till now we try still to stick tpo 80cols in the SCMI
stack if it does NOT really hamper readability...

> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +
> +	ret = ph->xops->xfer_get_init(ph, POWERCAP_MAI_GET, sizeof(u32),
> +								sizeof(u32), &t);

...terrible alignment...and you know why :D

> +
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(domain_id, t->tx.buf);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*mai = get_unaligned_le32(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static int scmi_powercap_xfer_mai_set(const struct scmi_protocol_handle *ph, u32 domain_id, u32 mai)

..same...try to stick to 80 cols when not impossibly ugly..

> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_powercap_cap_or_pai_set *msg;
> +
> +	ret = ph->xops->xfer_get_init(ph, POWERCAP_MAI_SET, sizeof(*msg), 0, &t);

same

> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	msg->domain_id = cpu_to_le32(domain_id);
> +	msg->flags = cpu_to_le32(0);
> +	msg->value = cpu_to_le32(mai);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static int scmi_powercap_measurements_interval_get(const struct scmi_protocol_handle *ph,
> +						   u32 domain_id, u32 *val)
> +{

ditto

> +	const struct scmi_powercap_info *pc;
> +	struct scmi_fc_info *fci;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	pc = scmi_powercap_dom_info_get(ph, domain_id);
> +	if (!pc)
> +		return -EINVAL;
> +
> +	fci = pc->cpli[CPL0].fc_info;
> +	if (fci && fci[POWERCAP_FC_MAI].get_addr) {
> +		*val = ioread32(fci[POWERCAP_FC_MAI].get_addr);
> +		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_MAI_GET, domain_id, 0, *val, 0);
ditto
> +		return 0;
> +	}
> +
> +	return scmi_powercap_xfer_mai_get(ph, domain_id, val);
> +}
> +
> +static int scmi_powercap_measurements_interval_set(const struct scmi_protocol_handle *ph,
> +						   u32 domain_id, u32 val)
> +{

ditto

> +	const struct scmi_powercap_info *pc;
> +	struct scmi_fc_info *fci;
> +
> +	pc = scmi_powercap_dom_info_get(ph, domain_id);
> +	if (!pc)
> +		return -EINVAL;
> +
> +	if (!pc->mai_config || !val || val < pc->min_mai || val > pc->max_mai)
> +		return -EINVAL;
> +
> +	fci = pc->cpli[CPL0].fc_info;
> +	if (fci && fci[POWERCAP_FC_MAI].set_addr) {
> +		iowrite32(val, fci[POWERCAP_FC_MAI].set_addr);
> +		ph->hops->fastchannel_db_ring(fci[POWERCAP_FC_MAI].set_db);
> +		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_MAI_SET, domain_id, 0, val, 0);
> +		return 0;
> +	}
> +
> +	return scmi_powercap_xfer_mai_set(ph, domain_id, val);
> +}
> +
>  static const struct scmi_powercap_proto_ops powercap_proto_ops = {
>  	.num_domains_get = scmi_powercap_num_domains_get,
>  	.info_get = scmi_powercap_dom_info_get,
> @@ -1094,6 +1212,8 @@ static const struct scmi_powercap_proto_ops powercap_proto_ops = {
>  	.measurements_get = scmi_powercap_measurements_get,
>  	.measurements_threshold_set = scmi_powercap_measurements_threshold_set,
>  	.measurements_threshold_get = scmi_powercap_measurements_threshold_get,
> +	.measurements_interval_get = scmi_powercap_measurements_interval_get,
> +	.measurements_interval_set = scmi_powercap_measurements_interval_set,
>  };
>  
>  static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index d0f6c0102559..73d66281dcc3 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -675,6 +675,10 @@ struct scmi_powercap_info {
>  	bool powercap_scale_uw;
>  	bool extended_names;
>  	bool fastchannels;
> +	bool mai_config;
> +	u32 min_mai;
> +	u32 max_mai;
> +	u32 mai_step;

No docs for new fields ?

>  	char name[SCMI_MAX_STR_SIZE];
>  	unsigned int sustainable_power;
>  	unsigned int accuracy;
> @@ -758,6 +762,10 @@ struct scmi_powercap_proto_ops {
>  	int (*measurements_threshold_get)(const struct scmi_protocol_handle *ph,
>  					  u32 domain_id, u32 *power_thresh_low,
>  					  u32 *power_thresh_high);
> +	int (*measurements_interval_get)(const struct scmi_protocol_handle *ph,
> +					 u32 domain_id, u32 *val);
> +	int (*measurements_interval_set)(const struct scmi_protocol_handle *ph,
> +					 u32 domain_id, u32 val);

No docs for new fields ?

Thanks,
Cristian
