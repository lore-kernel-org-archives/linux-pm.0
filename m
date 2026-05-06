Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B089401A35;
	Wed,  6 May 2026 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063845; cv=none; b=tKPdZ1N0FuNyHx5QESIL1KD+UWuFC6h8hMMazTRkjj6t9SmBTbB5FSoalpj+cw6Wfd+fUUse0Xpg6MjReAfwXxcdQYiCE+qLTAK741Ah7G8WABNk5UfQJGVZzqqRPbX//ruPVwNfCwL/ji1KpVH1eiSPxkas16R+86k26hwQhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063845; c=relaxed/simple;
	bh=5c4pTncPmX+luIL7Evtc7A40nYaSrPqfh+f4kQDYM2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw3jbsJ5gwOyQ/7oqlZ4dtHzkzw/GiyaaS30eUnGpOfnsvSq3hVRdN8oGhb1Pajf9atv3Shzpm3dpKe1QxyJw0Ri7QqJatSUaO2jsYbMkExvzasPoGH1VFh6xBZaFDpvxYN6lP3h4I5/TZOcJmpApshPKJLvweAtLYRCgtaO0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z5myFUTO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z5myFUTO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AEC23319;
	Wed,  6 May 2026 03:37:16 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20843F836;
	Wed,  6 May 2026 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778063841; bh=5c4pTncPmX+luIL7Evtc7A40nYaSrPqfh+f4kQDYM2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5myFUTOkpLhUhZHLyv4iC+h4GXSOln/Lh+okHyslh8+3y4BGuAqNbdZFUUGrw4Iw
	 jzwkPZNwVVn+7QKwVJMbmpDhzyYdEBeWI7OTDrdCOQRYXVAChEdEWtqN4gpYCiZHeO
	 ErBYfHXa+rzFploFlocnXV7x9AjHC/oz7YEc85Ho=
Date: Wed, 6 May 2026 11:37:17 +0100
From: Philip Radford <philip.radford@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 11/12] powercap: arm_scmi: Add get_power_uw to
 synthetic node
Message-ID: <afsZ3WFA38iiifsw@donnerap.manchester.arm.com>
References: <20260428090922.346069-1-philip.radford@arm.com>
 <20260428090922.346069-12-philip.radford@arm.com>
 <afprmEnMf5mNf8NE@pluto>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afprmEnMf5mNf8NE@pluto>

On Tue, May 05, 2026 at 11:13:44PM +0100, Cristian Marussi wrote:
> On Tue, Apr 28, 2026 at 10:09:20AM +0100, Philip Radford wrote:
> > Exposes the current power usage from the immediate children of
> > the synthetic (root) powercap node. Iterates over pr->spzones and
> > sums per-zone power.
> > 

Hi,

> > Signed-off-by: Philip Radford <philip.radford@arm.com>
> > ---
> >  drivers/powercap/arm_scmi_powercap.c | 29 ++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> > index d74869af1633..81b5214acda4 100644
> > --- a/drivers/powercap/arm_scmi_powercap.c
> > +++ b/drivers/powercap/arm_scmi_powercap.c
> > @@ -270,9 +270,34 @@ static int instance_root_release(struct powercap_zone *pz)
> >  	return 0;
> >  }
> >  
> > -static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
> > +static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
> >  {
> > -	*v = 0;
> > +	struct scmi_powercap_zone *root = to_scmi_powercap_zone(pz);
> > +	struct scmi_powercap_zone *child;
> > +	struct scmi_powercap_root *pr;
> > +	u64 acc = 0;
> > +	u64 p;
> 
> These u64 can live on a single line...
> 

No probs.

> > +	int ret;
> > +
> > +	if (!pz || !power_uw)
> > +		return -EINVAL;
> > +
> > +	pr = container_of(root, struct scmi_powercap_root, instance_root);
> 
> usually we define macros to wrap this like to_scmi_powercap_zone()...
> ...even if used only once...this could be a new to_scmi_powercap_root()
> 

Will do.

> > +	if (!pr)
> > +		return -ENODEV;
> > +
> > +	list_for_each_entry(child, &pr->registered_zones[0], node) {
> > +		if (child == &pr->instance_root)
> > +			continue;
> 
> You'll need to check this in light of the fixes of previous patch
> 

No worries.

Regards,
Phil
