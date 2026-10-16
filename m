Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818CC3B14BC;
	Fri, 16 Oct 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145609; cv=none; b=i1UrB1z/cjhOovh06S2CjjczER0dhAi+umdcm/ocjiKHr4G9TFE7ROUC73P4sIqmezQVJqSGK0S6AkTpf7PAjS0B99SbEf1zGxdxXjpC+C6cc7NGbLucnTHJMQECjSh1g2KamFfJW4ilIoJA4Q1egPjQaai1s5O9+YNvXv3qahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145609; c=relaxed/simple;
	bh=WQgfGoL4GDK3dJgHpQLbCjihbdF9lp2UKZlbahoF450=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlDIVoLZs5x3hbkOG8n1HZcxqHj1Q5JOEhRnIWsA2UNOf8Fwd1MasusVdycuw7N/DUXykR/cBt5YiIzUXNyYWpv5b2MDp81XAbzsJT3eYPLVBeq/lcWMCkF4The3/6djUDWcrwfpRhr9U1JxltWVZlXbXNzbQLE6oZ8vLotDaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHfbgzlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHfbgzlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE061F000C4;
	Fri, 16 Oct 2026 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145607;
	bh=WyVgdQOJ2lLJ0wl//yOKImwK8hAJpf48U17WojJT4FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MHfbgzlUIZRJdPWIE0no3IgTioOtANvbTrN96zf1hnfZNjewVLMpiT2SGNze7NNxb
	 p4MphMQmmT1pBOQKJrhfmwDL5MpVE0/fmHeUTfXXp1VvrwyWoDKXBF5/uw02dBnDUo
	 8/CF4tYHbvQ367xcSrBdSgnEgRMv+lMfBbhDAk976/x5JCVLhkeV9Tt7LXQ9l2tYsY
	 5+4OuMqsQ5QbEDOhW+O6tYGQiBrBWkmJggXEulgYHSz+ui0XQNVW0/jJtmrs01CUjO
	 WFhuMvak/6KMPYsH6waYO23tMb5Vtx74F56BzklZBf2n9AGQUsu8c4FwmRrgwQ/nEc
	 qXIbidDQLhUgQ==
Date: Fri, 16 Oct 2026 11:13:22 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@kernel.org>, arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v9 05/13] firmware: arm_scmi: Add SCMIv4.0 Powercap FCs
 support
Message-ID: <20261016-admirable-modern-bandicoot-d7cc15@sudeepholla>
References: <20260909220437.1254412-1-philip.radford@arm.com>
 <20260909220437.1254412-6-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909220437.1254412-6-philip.radford@arm.com>

On Wed, Sep 09, 2026 at 10:04:29PM +0000, Philip Radford wrote:
> From: Cristian Marussi <cristian.marussi@arm.com>
> 
> Add support for new SCMIv4.0 Powercap Fastchannels.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> [Philip: removed reference to old versioning logic]
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
>  drivers/firmware/arm_scmi/powercap.c | 331 ++++++++++++++++++---------
>  1 file changed, 229 insertions(+), 102 deletions(-)
> 

[...]

> +static int
> +scmi_powercap_xfer_avg_interval_get_v3(const struct scmi_protocol_handle *ph,
> +				       u32 domain_id, u32 cpl_id, u32 *ivl)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_powercap_cap_or_cai_get_v3 *msg;
> +
> +	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAI_GET, sizeof(*msg),
> +				      sizeof(u32), &t);
> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	msg->domain_id = cpu_to_le32(domain_id);
> +	msg->cpli = cpu_to_le32(cpl_id);

Is this inconsistent with scmi_powercap_xfer_cap_{g,s}et_v3() which IMO
correctly uses pc->cpli[cpl_id].id instead of cpl_id or am I just confusing
the flow ? The spec is clear that it must be concurrent power limit identifier.


[...]

> +static int
> +scmi_powercap_xfer_avg_interval_set_v3(const struct scmi_protocol_handle *ph,
> +				       u32 domain_id, u32 cpl_id, u32 ivl)
>  {
>  	int ret;
>  	struct scmi_xfer *t;
> -	struct scmi_msg_powercap_set_cap_or_pai *msg;
> +	struct scmi_msg_powercap_cai_set *msg;
>  
> -	ret = ph->xops->xfer_get_init(ph, POWERCAP_PAI_SET,
> -				      sizeof(*msg), 0, &t);
> +	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAI_SET, sizeof(*msg), 0, &t);
>  	if (ret)
>  		return ret;
>  
>  	msg = t->tx.buf;
>  	msg->domain_id = cpu_to_le32(domain_id);
>  	msg->flags = cpu_to_le32(0);
> -	msg->value = cpu_to_le32(pai);
> +	msg->cai = cpu_to_le32(ivl);
> +	msg->cpli = cpu_to_le32(cpl_id);

Ditto here.

-- 
Regards,
Sudeep
