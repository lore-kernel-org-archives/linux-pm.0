Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE32F745C;
	Thu, 15 Oct 2026 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070113; cv=none; b=LcpXA9xqE+CSODavda0EvrhOUJxdB3y19NNDLtQZq4CADSe+g+F+p57ZvFJqwqpduOddJ3CJNASE1MEyIjkN9cQFsyyc46a5S2C8Lq9Nmgcc2GCxfL+TfTW4WH53uqGHp1V4r9y4Qe+2yUBZ3LE1zqIu7GkTLUKs9NBawWay/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070113; c=relaxed/simple;
	bh=LleIUndjv+jMHXccT14aJ6PhR0O3GYgTTet+xzmVH/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGlBlSPEtXWUcaMK+Oo9OupS+W4YrzNQ7g+BdPrWRK+ZJUCOMAFQWN01Jmg8c6CEMhKtvtubB/pqPZUhVIrv2oddkgQMygbvb+zeKR7LZaVjMPYAAwd05jKWbr+b0osVDEzPhF79G0yq3Jj1YqVeI9vIbWGz7V7i/o3GwnQyBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QfbzofVc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QfbzofVc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ACEC16F8;
	Thu, 15 Oct 2026 06:15:06 -0700 (PDT)
Received: from e121740.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C09A3F673;
	Thu, 15 Oct 2026 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792070109; bh=LleIUndjv+jMHXccT14aJ6PhR0O3GYgTTet+xzmVH/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfbzofVcuZ2kXmb32z7EzCvjZYo1J5MjWrmNVlxgFCva+v/j5raqrCnwAjZoyP/Xk
	 cCjD5sVDMJmZFF6OpOL4cALoMRcxHV/2tmtXuDCMvSaAt+beHMSK8WsFoFRLd2iZUG
	 TmteeOHuIfs1PIGYIQs7+iW8htVyZP92KXNfrLBY=
Date: Thu, 15 Oct 2026 14:15:04 +0100
From: Philip Radford <philip.radford@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v9 04/13] firmware: arm_scmi: Add SCMIv4.0 Powercap basic
 support
Message-ID: <atDPwqwoYWqeFKdJ@e121740.arm.com>
References: <20260909220437.1254412-1-philip.radford@arm.com>
 <20260909220437.1254412-5-philip.radford@arm.com>
 <20261015-sarcastic-accurate-kestrel-585cc2@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-sarcastic-accurate-kestrel-585cc2@sudeepholla>


On Thu, Oct 15, 2026 at 01:57:14PM +0100, Sudeep Holla wrote:
> On Wed, Sep 09, 2026 at 10:04:28PM +0000, Philip Radford wrote:
> > From: Cristian Marussi <cristian.marussi@arm.com>
> > 
> > Add SCMIv4.0 Powercap support for enumerating multiple CPLs of a domain
> > when available.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > [Philip: Fixed sparse issues where int was expected]
> > Signed-off-by: Philip Radford <philip.radford@arm.com>
> > ---

Hi,

Thanks for looking at the series.

> > V8->V9
> > - included validation of the number of cpls in iter_powercap_cpls_update_state
> > - re-ordered validation of cap_config and num_cpli in powercap_domain_attrs_process
> > - included validation of length in powercap_domain_attributes_get
> > - amended cap_get and cap_set referencing apl_id array index instead fo firmware CPL identifier
> > - added bounds check to make sure cpl_id is less than num_cpli
> > ---
> >  drivers/firmware/arm_scmi/powercap.c | 495 ++++++++++++++++++++++-----
> >  drivers/powercap/arm_scmi_powercap.c |   2 +-
> >  include/linux/scmi_protocol.h        |   1 +
> >  3 files changed, 402 insertions(+), 96 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
> > index 4666030176c3..7ee39434a4db 100644
> > --- a/drivers/firmware/arm_scmi/powercap.c
> > +++ b/drivers/firmware/arm_scmi/powercap.c
> > @@ -33,6 +33,7 @@ enum scmi_powercap_protocol_cmd {
> >  	POWERCAP_CAP_NOTIFY = 0xa,
> >  	POWERCAP_MEASUREMENTS_NOTIFY = 0xb,
> >  	POWERCAP_DESCRIBE_FASTCHANNEL = 0xc,
> > +	POWERCAP_CPC_ATTRIBUTES = 0xd,
> >  };
> >  
> >  enum {
> > @@ -69,17 +70,56 @@ struct scmi_msg_resp_powercap_domain_attributes {
> >  	__le32 parent_id;
> >  };
> >  
> > +struct scmi_msg_resp_powercap_domain_attributes_v3 {
> > +	__le32 attributes;
> > +#define SUPPORTS_POWERCAP_MAI_CONFIGURATION(x)		((x) & BIT(25))
> > +#define SUPPORTS_POWERCAP_FASTCHANNELS(x)		((x) & BIT(22))
> > +#define SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY_V3(x)	((x) & BIT(21))
> > +#define SUPPORTS_POWERCAP_CAI_CONFIGURATION(x)		((x) & BIT(20))
> > +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> > +	__le32 min_mai;
> > +	__le32 max_mai;
> > +	__le32 mai_step;
> > +	__le32 min_power_cap;
> > +	__le32 max_power_cap;
> > +	__le32 power_cap_step;
> > +	__le32 sustainable_power;
> > +	__le32 accuracy;
> > +	__le32 parent_id;
> > +	__le32 min_cai;
> > +	__le32 max_cai;
> > +	__le32 cai_step;
> > +};
> > +
> > +struct scmi_msg_powercap_get_v3 {
> > +	__le32 domain_id;
> > +	__le32 cpli;
> > +};
> > +
> >  struct scmi_msg_powercap_set_cap_or_pai {
> > -	__le32 domain;
> > +	__le32 domain_id;
> >  	__le32 flags;
> >  #define CAP_SET_ASYNC		BIT(1)
> >  #define CAP_SET_IGNORE_DRESP	BIT(0)
> >  	__le32 value;
> >  };
> >  
> > +struct scmi_msg_powercap_set_cap_v3 {
> > +	__le32 domain_id;
> > +	__le32 cpli;
> > +	__le32 flags;
> > +	__le32 power_cap;
> > +};
> > +
> >  struct scmi_msg_resp_powercap_cap_set_complete {
> > -	__le32 domain;
> > +	__le32 domain_id;
> > +	__le32 power_cap;
> > +};
> > +
> > +struct scmi_msg_resp_powercap_cap_set_complete_v3 {
> > +	__le32 domain_id;
> >  	__le32 power_cap;
> > +	__le32 cpli;
> >  };
> >  
> >  struct scmi_msg_resp_powercap_meas_get {
> > @@ -112,6 +152,33 @@ struct scmi_powercap_meas_changed_notify_payld {
> >  	__le32 power;
> >  };
> >  
> > +struct scmi_msg_powercap_cpc {
> > +	__le32 domain_id;
> > +	__le32 desc_index;
> > +};
> > +
> > +struct scmi_msg_resp_powercap_cpc {
> > +	__le32 num_cpl;
> > +#define NUM_RETURNED(n)		(le32_get_bits((n), GENMASK(15, 0)))
> > +#define NUM_REMAINING(n)	(le32_get_bits((n), GENMASK(31, 16)))
> > +	struct {
> > +		__le32 cpli;
> > +		__le32 flags;
> > +		__le32 min_power_cap;
> > +		__le32 max_power_cap;
> > +		__le32 power_cap_step;
> > +		__le32 min_cai;
> > +		__le32 max_cai;
> > +		__le32 cai_step;
> > +		u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> > +	} desc[];
> > +};
> > +
> > +struct scmi_cpls_priv {
> > +	u32 domain_id;
> > +	struct scmi_powercap_cpl_info *cpli;
> > +};
> > +
> >  struct scmi_powercap_state {
> >  	bool enabled;
> >  	u32 last_pcap;
> > @@ -129,6 +196,11 @@ struct powercap_info {
> >  	bool notify_measurements_cmd;
> >  	struct scmi_powercap_state *states;
> >  	struct scmi_powercap_info *powercaps;
> > +	int (*xfer_cap_get)(const struct scmi_protocol_handle *ph,
> > +			    const struct scmi_powercap_info *pc, u32 cpl_id, u32 *power_cap);
> > +	int (*xfer_cap_set)(const struct scmi_protocol_handle *ph,
> > +			    const struct scmi_powercap_info *pc,
> > +			    u32 cpl_id, u32 power_cap, bool ignore_dresp);
> >  };
> >  
> >  static enum scmi_powercap_protocol_cmd evt_2_cmd[] = {
> > @@ -192,18 +264,227 @@ scmi_powercap_validate(unsigned int min_val, unsigned int max_val,
> >  	return 0;
> >  }
> >  
> > +static void iter_powercap_cpls_prepare_message(void *message,
> > +					       unsigned int desc_index,
> > +					       const void *priv)
> > +{
> > +	struct scmi_msg_powercap_cpc *msg = message;
> > +	const struct scmi_cpls_priv *p = priv;
> > +
> > +	msg->domain_id = cpu_to_le32(p->domain_id);
> > +	msg->desc_index = cpu_to_le32(desc_index);
> > +}
> > +
> > +static int iter_powercap_cpls_update_state(struct scmi_iterator_state *st,
> > +					   const void *response, void *priv)
> > +{
> > +	const struct scmi_msg_resp_powercap_cpc *r = response;
> > +	size_t needed;
> > +
> > +	if (st->rx_len < sizeof(r->num_cpl))
> > +		return -EPROTO;
> > +
> > +	st->num_returned = NUM_RETURNED(r->num_cpl);
> > +	st->num_remaining = NUM_REMAINING(r->num_cpl);
> > +
> > +	needed = struct_size(r, desc, st->num_returned);
> > +	if (st->rx_len < needed)
> > +		return -EPROTO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +iter_powercap_cpls_process_response(const struct scmi_protocol_handle *ph,
> > +				    const void *response,
> > +				    struct scmi_iterator_state *st, void *priv)
> > +{
> > +	const struct scmi_msg_resp_powercap_cpc *r = response;
> > +	struct scmi_cpls_priv *p = priv;
> > +	struct scmi_powercap_cpl_info *cpl;
> > +
> > +	cpl = &p->cpli[st->desc_index + st->loop_idx];
> > +
> > +	cpl->id = le32_to_cpu(r->desc[st->loop_idx].cpli);
> > +	cpl->cap_config = le32_to_cpu(r->desc[st->loop_idx].flags) & BIT(0);
> > +
> > +	cpl->min_power_cap = le32_to_cpu(r->desc[st->loop_idx].min_power_cap);
> > +	cpl->max_power_cap = le32_to_cpu(r->desc[st->loop_idx].max_power_cap);
> > +	cpl->power_cap_step = le32_to_cpu(r->desc[st->loop_idx].power_cap_step);
> > +	if (!cpl->power_cap_step && cpl->min_power_cap != cpl->max_power_cap)
> > +		return -EINVAL;
> > +
> > +	cpl->min_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].min_cai);
> > +	cpl->max_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].max_cai);
> > +	cpl->avg_ivl_step = le32_to_cpu(r->desc[st->loop_idx].cai_step);
> > +	if (!cpl->avg_ivl_step && cpl->min_avg_ivl != cpl->max_avg_ivl)
> > +		return -EINVAL;
> > +
> > +	cpl->avg_ivl_config = cpl->min_avg_ivl != cpl->max_avg_ivl;
> > +
> > +	strscpy(cpl->name, r->desc[st->loop_idx].name, SCMI_SHORT_NAME_MAX_SIZE);
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_powercap_cpls_enumerate(const struct scmi_protocol_handle *ph,
> > +					struct scmi_powercap_info *dom_info)
> > +{
> > +	void *iter;
> > +	struct scmi_iterator_ops ops = {
> > +		.prepare_message = iter_powercap_cpls_prepare_message,
> > +		.update_state = iter_powercap_cpls_update_state,
> > +		.process_response = iter_powercap_cpls_process_response,
> > +	};
> > +	struct scmi_cpls_priv cpriv = {
> > +		.domain_id = dom_info->id,
> > +		.cpli = dom_info->cpli,
> > +	};
> > +
> > +	iter = ph->hops->iter_response_init(ph, &ops, dom_info->num_cpli,
> > +					    POWERCAP_CPC_ATTRIBUTES,
> > +					    sizeof(struct scmi_msg_powercap_cpc),
> > +					    &cpriv);
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	return ph->hops->iter_response_run(iter);
> > +}
> > +
> > +static int
> > +scmi_powercap_domain_attrs_process(const struct scmi_protocol_handle *ph,
> > +				   struct powercap_info *pinfo,
> > +				   struct scmi_powercap_info *dom_info, void *r)
> > +{
> > +	struct scmi_msg_resp_powercap_domain_attributes *resp = r;
> > +	u32 flags = le32_to_cpu(resp->attributes);
> > +	bool cap_config;
> > +	int ret;
> > +
> > +	cap_config = SUPPORTS_POWERCAP_CAP_CONFIGURATION(flags);
> > +	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3) {
> > +		dom_info->num_cpli = 1;
> > +	} else {
> > +		dom_info->num_cpli = le32_get_bits(resp->attributes,
> > +						   GENMASK(18, 15));
> > +
> > +		if (cap_config && !dom_info->num_cpli)
> > +			return -EINVAL;
> > +
> > +		if (!dom_info->num_cpli)
> > +			dom_info->num_cpli = 1;
> > +	}
> > +
> > +	dom_info->cpli = devm_kcalloc(ph->dev, dom_info->num_cpli,
> > +				      sizeof(*dom_info->cpli), GFP_KERNEL);
> > +	if (!dom_info->cpli)
> > +		return -ENOMEM;
> > +
> > +	if (pinfo->notify_cap_cmd) {
> > +		if (PROTOCOL_REV_MAJOR(ph->version) < 0x3)
> > +			dom_info->notify_powercap_cap_change =
> > +				SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
> > +		else
> > +			dom_info->notify_powercap_cap_change =
> > +				SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY_V3(flags);
> > +	}
> > +
> > +	if (pinfo->notify_measurements_cmd)
> > +		dom_info->notify_powercap_measurement_change =
> > +			SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
> > +
> > +	dom_info->extended_names = SUPPORTS_EXTENDED_NAMES(flags);
> > +
> > +	dom_info->async_powercap_cap_set =
> > +		SUPPORTS_ASYNC_POWERCAP_CAP_SET(flags);
> > +
> > +	dom_info->powercap_monitoring =
> > +		SUPPORTS_POWERCAP_MONITORING(flags);
> > +	dom_info->powercap_scale_mw =
> > +		SUPPORTS_POWER_UNITS_MW(flags);
> > +	dom_info->powercap_scale_uw =
> > +		SUPPORTS_POWER_UNITS_UW(flags);
> > +	dom_info->fastchannels =
> > +		SUPPORTS_POWERCAP_FASTCHANNELS(flags);
> > +
> > +	strscpy(dom_info->name, resp->name, SCMI_SHORT_NAME_MAX_SIZE);
> > +
> > +	dom_info->sustainable_power =
> > +		le32_to_cpu(resp->sustainable_power);
> > +	dom_info->accuracy = le32_to_cpu(resp->accuracy);
> > +
> > +	dom_info->parent_id = le32_to_cpu(resp->parent_id);
> > +	if (dom_info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID &&
> > +	    (dom_info->parent_id >= pinfo->num_domains ||
> > +	     dom_info->parent_id == dom_info->id)) {
> > +		dev_err(ph->dev,
> > +			"Platform reported inconsistent parent ID for domain %d - %s\n",
> > +			dom_info->id, dom_info->name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	dom_info->cpli[0].id = CPL0;
> > +	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3)
> > +		dom_info->cpli[0].avg_ivl_config =
> > +			SUPPORTS_POWERCAP_PAI_CONFIGURATION(flags);
> > +	else
> > +		dom_info->cpli[0].avg_ivl_config =
> > +			SUPPORTS_POWERCAP_CAI_CONFIGURATION(flags);
> > +
> > +	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3) {
> > +		dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_pai);
> > +		dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_pai);
> > +		dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->pai_step);
> > +	} else {
> > +		struct scmi_msg_resp_powercap_domain_attributes_v3 *resp = r;
> > +
> > +		dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_cai);
> > +		dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_cai);
> > +		dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->cai_step);
> > +	}
> > +
> > +	ret = scmi_powercap_validate(dom_info->cpli[0].min_avg_ivl,
> > +				     dom_info->cpli[0].max_avg_ivl,
> > +				     dom_info->cpli[0].avg_ivl_step,
> > +				     dom_info->cpli[0].avg_ivl_config);
> 
> This could be existing bug w.r.t conformance as we are supposed to allow
> 0 as valid CAI and MAI values. It may need fixing with current PAI handling
> and we need to avoid using the same check on CAI.
> 
> The spec states: "The platform may choose not to report CAI or MAI".
> 
> Please take a look and fix the existing bug and the one in this series
> that applies for CAI.
> 
> I am just looking at conformance for now.
> 

Okay, I will look at this. Thank you.

Regards,
Phil
