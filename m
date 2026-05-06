Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC95282F0E;
	Wed,  6 May 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064705; cv=none; b=YxDdhQWWqKfPSADailawQXqatXzd8EcMDw4wSkdb4Hqnjei4DOfazXcO/NBJYKXIp19Kclu9frhHMuyevVUuNZlM7oD0xTRHQz1hPm51ydFnLuXSTj7aYKkDkLFvTm8Qm5fzjK6G6D6t1gv38j4sC8+xV9ZZg+K5e3MDyHsAS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064705; c=relaxed/simple;
	bh=iYNXb++hIJ9OfRQc9+FWnMLqhZrlCDWvv412uOnwE/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxJsdLMdEuDKoN/sL1ELma5xVJ9iXXzKPbkud7Gb4iTo8z35owkt1zSH0G3HkHU340AL/mkJuyrVonmhobuR2qbOo3WqGD2TcEcEohpu+XN0mZ7NHIqf8fWKdcTw7re4tq3SowmB95eAtpz+qyf7Ks6dMRAgDSGFKgvh9caPAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CLbSYu+s; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CLbSYu+s"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 867413319;
	Wed,  6 May 2026 03:51:37 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49EA53F836;
	Wed,  6 May 2026 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778064702; bh=iYNXb++hIJ9OfRQc9+FWnMLqhZrlCDWvv412uOnwE/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLbSYu+sRwtJr3t9K16SL9rXHW8Z+pbVRQ+RJhmov6xkSlmuLFbW/FfcaeqvTpJ+V
	 p9B3F82aA9Gq8jU87onEpr6LkVcoe/pE5Co5Z+plDH5fLGRiM2Kvox/A4beffwA4Rq
	 QCTUJyzR9QEdd3QKEfZIbyYQdzHUy8dROaLjdR3E=
Date: Wed, 6 May 2026 11:51:37 +0100
From: Philip Radford <philip.radford@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 12/12] powercap: arm_scmi: Synthetic zone
 enable/disable
Message-ID: <afsdOZ690p_vn9sq@donnerap.manchester.arm.com>
References: <20260428090922.346069-1-philip.radford@arm.com>
 <20260428090922.346069-13-philip.radford@arm.com>
 <afpu-Wf01J3l0gAu@pluto>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpu-Wf01J3l0gAu@pluto>

On Tue, May 05, 2026 at 11:28:09PM +0100, Cristian Marussi wrote:
> On Tue, Apr 28, 2026 at 10:09:21AM +0100, Philip Radford wrote:
> > Add functionality to disable and enable the synthetic zone which
> > also affects the immediate children of the synthetic zone by applying
> > the same command to them.
> > 

Hi,

> > Signed-off-by: Philip Radford <philip.radford@arm.com>
> > ---
> >  drivers/powercap/arm_scmi_powercap.c | 81 ++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> > index 81b5214acda4..1ed2949b06cb 100644
> > --- a/drivers/powercap/arm_scmi_powercap.c
> > +++ b/drivers/powercap/arm_scmi_powercap.c
> > @@ -270,6 +270,85 @@ static int instance_root_release(struct powercap_zone *pz)
> >  	return 0;
> >  }
> >  
> > +static int instance_root_set_enable_state(struct powercap_zone *pz, bool enable)
> > +{
> > +	struct scmi_powercap_zone *root;
> > +	struct scmi_powercap_root *pr;
> > +	struct scmi_powercap_zone *child;
> 
> ...child and root on the same line of declarations...
> 

Noted.

> > +	int ret, first_err = 0;
> > +
> > +	if (!pz)
> > +		return -EINVAL;
> > +
> > +	root = to_scmi_powercap_zone(pz);
> > +	pr = container_of(root, struct scmi_powercap_root, instance_root);
> 
> ...another user of you new macro !
> 

:)

> > +
> > +	list_for_each_entry(child, &pr->registered_zones[0], node) {
> > +		if (child == &pr->instance_root)
> > +			continue;
> > +
> > +		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
> > +			continue;
> > +
> > +		if (!child->info->cpli[0].cap_config)
> > +			continue;
> > +
> > +		ret = powercap_ops->cap_enable_set(child->ph, child->info->id, enable);
> > +
> > +		if (ret && !first_err) {
> 
> ...mmm what is the logic here ? why not bailing out on any error ?
> 

Good point. I was initially trying to prevent one error stopping everything without
checking the other children, but even as I'm writing this out I can see the fault in
that logic.

> > +			first_err = ret;
> > +			dev_err(child->dev, "failed to %s zone %s: %d\n",
> > +				enable ? "enable" : "disable",
> > +				child->info->name, ret);
> > +		}
> > +	}
> > +
> > +	return first_err;
> 
> ...especially if you anyway fails globally on any error....
> ..I am not completely sure bit given that youare operating on a
> synthetic zone that you enable as a whole, while acting on its children
> in the backstage...I would say that if any enable/disable fails on a
> chidlren you should revert the enable status of the children thate were
> succesffull and report the error...I mean the state of top synthatic
> zones AND the states of the children MUST remain consistent...
> ...it CANNOT be that some chidlren fails, some succeeds and you report
> an error..it must be all or nothing...
> ...example..top syntethic zone is OFF if all children were successfully
> disabled...on a failure with one of the children you shoudl revert the
> already successfully set children and report the global error...
> 

Point taken, this needs reworking.

> > +}
> > +
> > +static int instance_root_set_enable(struct powercap_zone *pz, bool mode)
> > +{
> > +	return instance_root_set_enable_state(pz, mode);
> > +}
> > +
> > +static int instance_root_get_enable(struct powercap_zone *pz, bool *mode)
> > +{
> > +	struct scmi_powercap_zone *root;
> > +	struct scmi_powercap_root *pr;
> > +	struct scmi_powercap_zone *child;
> > +	bool enabled;
> > +	int ret;
> > +
> > +	if (!pz || !mode)
> > +		return -EINVAL;
> > +
> > +	root = to_scmi_powercap_zone(pz);
> > +	pr = container_of(root, struct scmi_powercap_root, instance_root);
> > +
> > +	*mode = true;
> > +
> > +	list_for_each_entry(child, &pr->registered_zones[0], node) {
> 
> mmm...what is the point here of scanning the children to GET the
> state...you should report the top syntethic zone state right ?
> You could have disable children directly...that wont be reflected in the
> Linux powercap hiearcrhy right ?
> I mean should you NOT simply return the stae of the top syntethic zone
> which is should have saved in the previous state_set operation above ?
> 
> I think that anyway if you disable a zone...any zone...ONLY that zone is
> marked as disable in Lnux powercap ... am I right ? 
> 
> Then probably our SCMI fw will do much more on all the children..
> 

Good point, I'll simplify it to report a saved state for the synthetic root.

Regards,
Phil
