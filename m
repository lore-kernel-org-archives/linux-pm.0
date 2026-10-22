Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663812;
	b=4eAiPaCluOGIc6vok4Wcsg3XZ/a2amFd8peaGuqwyb38ShrQz5u+rCypB7QyDqBLu33i
	 u8E8wUTFD/oZuxi2txpADjTqYCHaFo8+eTsccVn9RB0BVQN/rv5B7fsxhTGbcSAQfbYqT
	 UE/zBD2v9kdy4+KB1LIWwxSUHtA3RsWLcRZvrgA0gLKUcAoD92jgfO0GG5nt191RzbOx5
	 QvJFds915ejcKYe0D4zUBA7+4TVtwQtgLH2yhWhVve2NueiqmLU+foZjNbNgO54UsvoML
	 nuLM0hBTY/AT33J+BesLgMCx6nd14R+OU2Pn0sr/y3nBkn4S7pt5kPqOpXVdDH2OwDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jwzWAXvfUTkgeLv8Aw5G0qXBzZ6fF68PoWuXyb88RTA=;
	b=vZB6Pt26l3xaHebJPMewvoMVTZ2kG4/+j+p+JndXbqoDdBrtjum8HMEUuFj2idmDbGmT
	 RwfM+Q51IsG0+yrNTIoZI3HCfwOB3nXv6ZSLjJvwH19GRxnYXBQstVCskn0jkHtG6vhB6
	 vKgLFRxPZo1RNrJI9OCsBNlz90nG32JwzNL64MdWiTf+8djug0om3ktNkLpslRz507oQj
	 HV6HFXUbFOWU0ve746CBzu+mCn3KJctJUukbF8DCFtkYXCTP3I6jVKnzY4qQj6lp5R6bn
	 GkFG1f7nbex1KQmHDa07Q29yO4w3U9i0Gjt1Qxq5hBAICMU6m9zVXvF2DBtO0Y2sEjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVQam7vH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A14606A31A;
	Thu, 22 Oct 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVQam7vH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66E21F000C1;
	Thu, 22 Oct 2026 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663811;
	bh=jwzWAXvfUTkgeLv8Aw5G0qXBzZ6fF68PoWuXyb88RTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MVQam7vHOshySlx0woJKjJ+pJx7q1a4ToyjZOlqu4+uZCcUkF91PfNu29gpKBoSvf
	 lKG1OKAlcpVB4DJ3n1eJ78NvfasukZBM8+aFpQSDgJFVIue52RV9xRpJZC/FKFzt4L
	 nwmYi5jqa/8llmjs8xQpC8znNy5s/6wZEAlTZ52oN/QCWpqapdvNV9REkPpYN7hh36
	 3qXqPo5YUAM+gN+TO0HdR7HibaaADeN3DFbukoOnka5Z7SFdSEexTkyhDqnrlQODy9
	 6O4P40aBN25M6YEio0ni/NRXRGgAVd7i1Mr0QTAWaPkpFsILFyjCwVITEdlqaFw3jM
	 KyF6zfPjv6IQw==
Date: Thu, 22 Oct 2026 11:10:06 +0100
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
Subject: Re: [PATCH v9 03/13] firmware: arm_scmi: Refactor powercap domain
 layout
Message-ID: <20261022-spotted-impetuous-kittiwake-b2adcd@sudeepholla>
References: <20260909220437.1254412-1-philip.radford@arm.com>
 <20260909220437.1254412-4-philip.radford@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909220437.1254412-4-philip.radford@arm.com>

On Wed, Sep 09, 2026 at 10:04:27PM +0000, Philip Radford wrote:
> From: Cristian Marussi <cristian.marussi@arm.com>
> 
> SCMIv4.0 introduces the idea of an optional Concurrent Power Limit (CPL)
> for each powercap domain, where CPL0 coincides with the one and only
> per-domain constraint limit that was available in pre-v4.0 SCMI Powercap.
> 
> Refactor the powercap domain descriptors and powercap operations to allow
> future v4.0 extensions to cope with multiple CPLs.
> 
> While at that generalize the powercap protocol API to drop PAI references
> in favour of a more generic avg_ivl naming, since from v4.0 the number and
> types of averaging intervals will change in a non-backward compatible way,
> so let's bury these changes within the protocol layer.
> 
> Last but not least, make the necessary changes to the ARM SCMI Powwercap
> driver in order to support all of these new capabilities.
> 
> No functional change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> [Philip: Adjusted domain_id comparitor in scmi_powercap_pai_get]
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
> V7->V8
> - Fixed conflict due to changes in 7.2-rc1
> ---
>  drivers/firmware/arm_scmi/powercap.c | 182 +++++++++++++++++----------
>  drivers/powercap/arm_scmi_powercap.c |  52 ++++----
>  include/linux/scmi_protocol.h        |  74 +++++++----
>  3 files changed, 189 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index 96d55921fefc..7c2dbba5002c 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -123,7 +123,7 @@ scmi_powercap_set_root_children_enable_state(struct scmi_powercap_root *pr, bool
>  
>  		if (!scmi_powercap_is_control_type_child(spz))
>  			continue;
> -		if (!spz->info->powercap_cap_config)
> +		if (!spz->info->cpli[0].cap_config)
>  			continue;
>  		if (prev_state[i] == enable)
>  			continue;

You seem to have left one use `powercap_cap_config` above this hunk which
breaks the build and hence build bisectability with this series.

-- 
Regards,
Sudeep
