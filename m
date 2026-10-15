Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE913B8D4F;
	Thu, 15 Oct 2026 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074776; cv=none; b=YAp0/ipG78ng0G++8GSVfjcxG+3jueHOx6E97BYPTJMDN66fSavpduKBvDL1Atkk8AAkNdL620SUkhROx6woPJoICE/Q4wmcOcJgw/jBgjT2+yQ6Hvwbm/tHAuKSatLiNpHzfze1LtZ6GUkBABJ3grM7CDsn/vvhGj4oNu3Bpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074776; c=relaxed/simple;
	bh=qyawegKgr7KmH/89SsM3Ua3ftIQXLYUPg7IMiER6aPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko3qGoFtVCVseluGvHpGmZ988s/VLDUum2a2jtnJCaqmfQuANNohlspKQt3lNEzdzbwqrSbTAQBQniPICWtxav8L8QwAW6a5Oy0DeMxZVwmxdOKDnURoLK1dabWiUDR01zVw5Yrk4mQCg61kwMwZPTtBY080Vt0esRAeoNAkrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u6duZc4/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="u6duZc4/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0A171477;
	Thu, 15 Oct 2026 07:32:50 -0700 (PDT)
Received: from e121740.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 238BA3F871;
	Thu, 15 Oct 2026 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792074773; bh=qyawegKgr7KmH/89SsM3Ua3ftIQXLYUPg7IMiER6aPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6duZc4/VnqunKshGSpsjVhyxzmOxOYIac1TTevcRt1EAB8yLhwmsW9U8FAEVtEMq
	 I+YJGaLUhefbS1+H94N1jGgqB6Vkh25ty1vgtGzzjV0s7SHCpu6Ljx6N5VAGgTG8kZ
	 +7QSS3qF29tjLi60tPDAwNUHWJQTo46IDhEQGhzk=
Date: Thu, 15 Oct 2026 15:32:42 +0100
From: Philip Radford <philip.radford@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 09/13] powercap: arm_scmi: Enable multiple constraints
 support
Message-ID: <atDjzW/XnTVLlR9S@e121740.arm.com>
References: <20260909220437.1254412-1-philip.radford@arm.com>
 <20260909220437.1254412-10-philip.radford@arm.com>
 <20261015-urban-porcelain-smilodon-edbc1d@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-urban-porcelain-smilodon-edbc1d@sudeepholla>

On Thu, Oct 15, 2026 at 02:24:40PM +0100, Sudeep Holla wrote:
> On Wed, Sep 09, 2026 at 10:04:33PM +0000, Philip Radford wrote:
> > From: Cristian Marussi <cristian.marussi@arm.com>
> > 

Hi,

> > Initialize the domains with all the discovered available constraints,
> > making available multiple per-domain constraints when the platform has
> > advertised support for multiple concurrent power limits.
> > 
> > CC: "Rafael J. Wysocki" <rafael@kernel.org>
> > CC: linux-pm@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > [Philip: Amended Copyright]
> > Signed-off-by: Philip Radford <philip.radford@arm.com>
> > ---
> > V8->V9
> > - Added validation check to make sure powercap domain doesn't have too
> > many constraints
> > ---
> >  drivers/powercap/arm_scmi_powercap.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> > index 2d9370aaaf5d..bcd1ba0bde8c 100644
> > --- a/drivers/powercap/arm_scmi_powercap.c
> > +++ b/drivers/powercap/arm_scmi_powercap.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * SCMI Powercap support.
> >   *
> > - * Copyright (C) 2022 ARM Ltd.
> > + * Copyright (C) 2022-2026 ARM Ltd.
> >   */
> >  
> >  #include <linux/device.h>
> > @@ -491,7 +491,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
> >  
> >  	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
> >  				   parent ? &parent->zone : NULL,
> > -				   &zone_ops, 1, &constraint_ops);
> > +				   &zone_ops, spz->info->num_cpli, &constraint_ops);
> >  	if (!IS_ERR(z)) {
> >  		spz->height = scmi_powercap_get_zone_height(spz);
> >  		spz->registered = true;
> > @@ -649,6 +649,13 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
> >  		 */
> >  		spz->info = powercap_ops->info_get(ph, i);
> >  
> > +		if (spz->info->num_cpli > MAX_CONSTRAINTS_PER_ZONE) {
> 
> Since MAX_CONSTRAINTS_PER_ZONE = 10 and our SCMI f/w can return upto 15,
> we may have to warn or clamp it to 10 or both.
> 

Noted. I will address this in the next version, thank you.

Regards,
Phil
