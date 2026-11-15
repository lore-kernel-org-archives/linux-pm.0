Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794742600;
	b=VScjUrOl7RtJwNheO068McJhQ05ZOkhZkpkPIGkJ9Oy8NX4SlRqW/cQhksAVpav7O6+q
	 Nss3l2CUnSlW8TPs+/NAesB0paMW7KK4YQQ+A/CdBWZdjFlZ9fFU85cUpBnoyVerCKmUz
	 peGecwmwntOKoxFG0TJWmBfrj3E6T+IHO+CEaSdlgvjrcKj3q0CPjmxHcHSMv3pmOT3Wi
	 qUVsp8VabTg6Anxd8b9gTQE7o6GDUjzaHLVZnviTOwT5Y3+2w9JtOhAaCP7hMtaiwgSq0
	 bEnAYuD43fSqtMjDziZLTAYsdsnpsLy3TBGQ/yZQXq/26V9Ah9SY+9uogg0S58XRcIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742600;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0D5rV4LDcAhDtJrh0J4x1Fo3FNQEer06zKXspgdSqYw=;
	b=OYiOgu23NPaVorbKjxxg2SH6dZbn5F+d0GpzDh1SDIvyUmchRvTvNcRkexd9HtTb2KGz
	 LrOXDcrLeylNZIBc7pn7kooeHqEtSqPerWzwLvl7521SEbhnXQ/hE/oIJIxozxLCMJ5ig
	 XRuhW0X+yR8u3/TTgJMDscT6SZUz/Ile1a/61SP5UMG52k67Chp8E8Hdun9C134yIfbIQ
	 2csldbVE84O5Pbwwn61iDbFk9RgdPAaSoo4ygR8Xi616bQoS0u4tSQPcr4d24eybPP647
	 YSeBPG1PfQgx2tvG+z/Vok5hTV5y097zcdSJo0cIkgF7pQA9rf04C4pu+vsfvf3NDHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d9jzsKbl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51444606A31A;
	Sun, 15 Nov 2026 11:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51444606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d9jzsKbl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34C0C143D;
	Sun, 15 Nov 2026 03:36:36 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7D3F3F632;
	Sun, 15 Nov 2026 03:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794742599; bh=Z5w+PDWtG8RWg9D5f69nuwbyo8DbysjJ678dY4p5bKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9jzsKbl1bSMU1kU+fHYKgnrLlU2hud+iS8+c+E1PgpKaNnEE4VcUXWFoWDxqWVa9
	 CbjZeQaSGEvWpdRA6GMzq3ZlEfNJHs04hjNExfQ/7VFYV83rBy9JVwumEAh5hi0yce
	 7wntHzLdhQd4OtVhY/9+qQf3tWpMUOGkVwSDM8Ks=
Date: Sun, 15 Nov 2026 11:36:28 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: Re: [PATCH v10 01/13] powercap: Add enable disable control-type
Message-ID: <avmZPMOK8ynHMN0I@pluto>
References: <20261103231007.537082-1-philip.radford@arm.com>
 <20261103231007.537082-2-philip.radford@arm.com>
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
In-Reply-To: <20261103231007.537082-2-philip.radford@arm.com>

On Tue, Nov 03, 2026 at 11:09:55PM +0000, Philip Radford wrote:
> Add functionality to disable or enable the Powercap control-type by writing
> directly into sys/class/powercap/arm-scmi/enabled.
> 

Hi Philip,

see a some general remarks down below.

> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
> V9->V10
> - changed control-type enable writes to snapshot per-zone state instead of
>   aggregate
> - cancel enable/disable writes if a root child zone is not configurable
> - roll back changed zones on failure
> - changed control-type enable reads to report enabled if any root child zone
>   is enabled
> ---
>  drivers/powercap/arm_scmi_powercap.c | 175 ++++++++++++++++++++++++++-
>  1 file changed, 174 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index ab66e9a3b1e2..ba398048bf21 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -33,13 +33,171 @@ struct scmi_powercap_zone {
>  
>  struct scmi_powercap_root {
>  	unsigned int num_zones;
> +	bool enabled;
> +	struct list_head node;
>  	struct scmi_powercap_zone *spzones;
>  	struct list_head *registered_zones;
>  	struct list_head scmi_zones;
>  };
>  
> +static LIST_HEAD(scmi_powercap_roots);
> +static DEFINE_MUTEX(scmi_powercap_roots_lock);
> +
>  static struct powercap_control_type *scmi_top_pcntrl;
>  
> +static bool scmi_powercap_is_control_type_child(const struct scmi_powercap_zone *spz)
> +{
> +	return spz->registered && !spz->invalid &&
> +	       spz->info->parent_id == SCMI_POWERCAP_ROOT_ZONE_ID;

Not sure to remember clearly the logic here, but is it possible for a
zone to be registered and invalid ?
I made some recent changes/fixes but the invariant that registered
implied !invalid seemed to apply before and after my fixes...

> +}
> +
> +static int
> +scmi_powercap_read_root_children_enable_state(struct scmi_powercap_root *pr, bool *mode)
> +{
> +	struct scmi_powercap_zone *spz;
> +	bool enabled;
> +	int i, ret;
> +
> +	*mode = false;
> +
> +	for (i = 0; i < pr->num_zones; i++) {

	for (int i = 0 ...

> +		spz = &pr->spzones[i];
> +
> +		if (!scmi_powercap_is_control_type_child(spz))
> +			continue;
> +
> +		ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id, &enabled);
> +		if (ret)
> +			return ret;
> +
> +		if (enabled) {
> +			*mode = true;
> +			return 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct scmi_powercap_zone_state {
> +	struct scmi_powercap_zone *spz;
> +	bool prev_enabled;
> +	bool changed;
> +};
> +
> +static int
> +scmi_powercap_control_type_set_enable(struct powercap_control_type *pct, bool mode)
> +{
> +	struct scmi_powercap_zone_state *states;
> +	struct scmi_powercap_root *pr;
> +	struct scmi_powercap_zone *spz;
> +	int num_zones = 0, nr_states = 0;
> +	int i, ret = 0;

... while looking at some other previous Sashiko reported powercap issue
I had a superficial look at this, and beside the logic that seems to be
fine by itself, the code layout is deadly unreadable, thing which is
pretty normal to happen when there is a mix of allocations mutexes and
various error exit path....please refactor using cleanup handlers to
manage all of this allocations and mutexes, it should allow you to drop
all the gotos and keep a more linear logic across all of this fucntion..
(and NOTE that when using cleanup.h you MUST drop all of the gotos in
this function...all info inside cleanup.h too)
 
> +
> +	mutex_lock(&scmi_powercap_roots_lock);
> +	list_for_each_entry(pr, &scmi_powercap_roots, node) {
> +		for (i = 0; i < pr->num_zones; i++) {
> +			spz = &pr->spzones[i];
> +
> +			if (scmi_powercap_is_control_type_child(spz))
> +				num_zones++;
> +		}
> +	}
> +
> +	states = kcalloc(num_zones, sizeof(*states), GFP_KERNEL);
> +	if (!states) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	list_for_each_entry(pr, &scmi_powercap_roots, node)	{
> +		for (i = 0; i < pr->num_zones; i++) {
> +			spz = &pr->spzones[i];
> +
> +			if (!scmi_powercap_is_control_type_child(spz))
> +				continue;
> +
> +			if (!spz->info->powercap_cap_config) {
> +				ret = -EOPNOTSUPP;
> +				goto out_free;
> +			}
> +
> +			states[nr_states].spz = spz;
> +
> +			ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id,
> +				&states[nr_states].prev_enabled);

also...I have not checked this myself, BUT do you use checkpatch --strict that I
can see a few strange indents...

> +
> +			if (ret)
> +				goto out_free;
> +
> +			nr_states++;
> +		}
> +	}
> +
> +	for (i = 0; i < nr_states; i++) {
> +		spz = states[i].spz;
> +
> +		if (states[i].prev_enabled == mode)
> +			continue;
> +
> +		ret = powercap_ops->cap_enable_set(spz->ph, spz->info->id, mode);
> +		if (ret)
> +			goto revert;
> +
> +		states[i].changed = true;
> +	}
> +
> +	goto out_free;
> +
> +revert:
> +	while (i--) {
> +		spz = states[i].spz;
> +
> +		if (!states[i].changed)
> +			continue;
> +
> +		powercap_ops->cap_enable_set(spz->ph, spz->info->id,
> +			states[i].prev_enabled);

ditto...checkpatch

> +	}
> +
> +out_free:
> +			kfree(states);
> +
ditto...checkpatch
> +out_unlock:
> +			mutex_unlock(&scmi_powercap_roots_lock);
ditto...checkpatch
> +
> +			return ret;
> +}
> +
> +static int
> +scmi_powercap_control_type_get_enable(struct powercap_control_type *pct, bool *mode)
> +{
> +	struct scmi_powercap_root *pr;
> +	int ret = 0;
> +

same here...even if it is a smaller function using cleanup guard helps
streamlining the code...

> +	*mode = false;
> +
> +	mutex_lock(&scmi_powercap_roots_lock);
> +	list_for_each_entry(pr, &scmi_powercap_roots, node) {
> +		ret = scmi_powercap_read_root_children_enable_state(pr, &pr->enabled);
> +
> +		if (ret)
> +			break;
> +		if (pr->enabled) {
> +			*mode = true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&scmi_powercap_roots_lock);
> +
> +	return ret;
> +}
> +

Thanks,
Cristian
