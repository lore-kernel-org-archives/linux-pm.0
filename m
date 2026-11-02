Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613413;
	b=dMQzWcQt6nAwEJ2zsLkSMzcMFlr1fCQUnF5wF6oPE+0Q2dQI6W85fHiQlCum1KoFuKOF
	 kDG3gwI9CqlR34DbI0kNEK5X/J0sYpKs4vtkbd8CBVaUBe0hR5oDvRbIFjb1u0PvUS9oa
	 acyY+3rKoML9kVJousx7QRZZFp80FzTqCJZfueSTeamzsbygYCR/XOmJCYvgOo8Uey9hC
	 mXqmgPDCMgCpD4O4M3W1xAdudSvbTt1KeGiZwqrjHaa8ZRvGwHB7NNWSiNnQ6H4cpYPbv
	 bVzmMBK89N8VxZO/UZ6EtNN7tTiAf7UD/usNTaAdlMW8XElW+QmaxiPCB0T+AKZgf9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613413;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jEXZn25mOSnRSnFkDPXVKbT86gLRaygrv7hBJoYn83Y=;
	b=Sw75FOHCMo/wJKzDrXOZTIQoyRwVoCdlqEOBUWPc4hvzXBGn6jqOBWo1IuA4M0kxFXTP
	 PEMK+Ivv3HNJnhdp91bLIqzSQ4TilP38GMoNgyG2VFknD5GUk+z0SlxS16GUqaAbEh9IU
	 k0BY4ON3JqawT0zVnDikWgjeHOAXOM/YrYuFVSANeIgEPJf456sXygsvONTjlFfxYQfr6
	 m/MVeeZro+TIadWx8S1TYU6RLrqmxro1NPo/3n1/9GKLgsW405LSujQh83KG8smPII6ir
	 jSAXP8H6r6WQK6bXXVzxAIpaxR442Aia3M9CjwdKljsHEumz6+7cpLk8Qe2sgIIH/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Zg48mlwk;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A60606A33D;
	Mon,  2 Nov 2026 09:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A60606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Zg48mlwk
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF3DE1595;
	Mon,  2 Nov 2026 01:56:48 -0800 (PST)
Received: from [10.57.16.53] (unknown [10.57.16.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43FB3F59E;
	Mon,  2 Nov 2026 01:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793613411; bh=a+LR+CmbFBIcR2fiRj3wp8/wI+yAEpxcNhNDKOn/P+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zg48mlwkHNaWfJLi8qkWbskLRD3Pspw0QyjdDGJgFahD1n2OQCvVFP2WKnQ6GxZG6
	 nbsNHPO6jsU2jOL517F/o6Cxqe5x79PUYiiL5XhOm8Bd/BYbyZUE72pzyB3COFi8C1
	 eagMYzWRrNx5SLM9k3X3rs43KFd3aK/61j/dJIio=
Message-ID: <3005f6f5-3b6a-4139-a170-1f60d93c9902@arm.com>
Date: Mon, 2 Nov 2026 09:57:20 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] powercap: dtpm: Use generic powercap hierarchy
 helpers
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, rafael@kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kselftest@vger.kernel.org
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
 <f34635d2ce1d5c741968708e6349f7f059b03173.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <f34635d2ce1d5c741968708e6349f7f059b03173.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 10/29/26 16:56, Daniel Lezcano wrote:
> DTPM implements its own hierarchy creation and destruction logic while
> the powercap core now provides generic helpers for this purpose.
> 
> Convert DTPM to use the generic powercap hierarchy infrastructure.
> Duplicate the platform hierarchy before creating it, and use
> powercap_hierarchy_create() and powercap_hierarchy_destroy() to manage
> the DTPM zones.
> 
> Add DTPM callbacks to create and destroy the zones associated with each
> powercap hierarchy node. Adapt the CPU and devfreq backends to return
> the created DTPM instance and use the node name provided by the
> hierarchy.
> 
> Convert the Rockchip RK3399 description to struct powercap_hierarchy
> and keep the device tree path as DTPM-specific node data.
> 
> This removes the DTPM-specific hierarchy traversal and destruction code
> and leaves the hierarchy management to the powercap core.
> 
> Preserve best-effort creation: an unavailable backend returns NULL to
> skip its branch, and setup failures are warned about and skipped rather
> than rolling back independent zones. Invalid node descriptors remain
> fatal.
> 
> When the representative CPU is offline, find an active policy through an
> online sibling whose related_cpus mask contains it. Hold the CPU hotplug
> read lock during selection and setup, and initialize the zone through the
> policy's active CPU while keeping the hierarchy-provided name. An entirely
> offline policy still has no active CPU to initialize through.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
> 
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Preserve best-effort branch creation using the generic NULL result.
> - Find an online policy sibling for offline CPU representatives and
>    protect policy selection and setup against CPU hotplug.
> - Keep generic API behavior and documentation in patch 1.
> - Fix __initdata placement; match-table indentation is handled in patch 3.
> - Name setup callback arguments and remove whitespace-only lines.
> - Update the description.
> 
>   drivers/powercap/dtpm.c         | 177 +++++++++++++++-----------------
>   drivers/powercap/dtpm_cpu.c     |  62 ++++++++---
>   drivers/powercap/dtpm_devfreq.c |  22 ++--
>   drivers/soc/rockchip/dtpm.c     |  67 +++++++++---
>   include/linux/dtpm.h            |   6 +-
>   5 files changed, 195 insertions(+), 139 deletions(-)

Tha patch in general looks good. I only have one
comment related to the future usage of this mechanism.
For this implementation it's safe, but I would add
some extra safety net around the of_find_node_by_path().
See comments below.
[snip]

>   
> -static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
> +static struct dtpm *dtpm_setup_dt(const char *name, const char *path,
>   				  struct dtpm *parent)
>   {
>   	struct device_node *np;
> -	int i, ret;
> +	struct dtpm *dtpm = NULL;
> +	int i;
>   
> -	np = of_find_node_by_path(hierarchy->name);


I would add a NULL check for 'path' here, or below
where dtpm_setup_dt() is called.

Usually it's up the the code which is calling that API
to make sure that the NULL is not sneaked in.
We probably can force drivers code for that, right?

> +	np = of_find_node_by_path(path);
>   	if (!np) {
> -		pr_err("Failed to find '%s'\n", hierarchy->name);
> +		pr_err("Failed to find '%s'\n", path);
>   		return ERR_PTR(-ENXIO);
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
> +		struct dtpm *tmp;
>   
>   		if (!dtpm_subsys[i]->setup)
>   			continue;
>   
> -		ret = dtpm_subsys[i]->setup(parent, np);
> -		if (ret) {
> -			pr_err("Failed to setup '%s': %d\n", dtpm_subsys[i]->name, ret);
> -			of_node_put(np);
> -			return ERR_PTR(ret);
> +		tmp = dtpm_subsys[i]->setup(parent, np, name);
> +		if (IS_ERR(tmp)) {
> +			pr_err("Failed to setup '%s': %ld\n",
> +			       dtpm_subsys[i]->name, PTR_ERR(tmp));
> +			dtpm = tmp;
> +			break;
> +		}
> +
> +		if (tmp) {
> +			dtpm = tmp;
> +			break;
>   		}
>   	}
>   
>   	of_node_put(np);
>   
> -	/*
> -	 * By returning a NULL pointer, we let know the caller there
> -	 * is no child for us as we are a leaf of the tree
> -	 */
> -	return NULL;
> +	return dtpm;
>   }
>   
> -typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
> -
> -static dtpm_node_callback_t dtpm_node_callback[] = {
> -	[DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
> -	[DTPM_NODE_DT] = dtpm_setup_dt,
> -};
> -
> -static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
> -			       const struct dtpm_node *it, struct dtpm *parent)
> +static struct powercap_zone *
> +dtpm_node_create(struct powercap_control_type *pct, const char *name,
> +		 void *data, struct powercap_zone *parent)
>   {
> +	struct dtpm_node *node = data;
> +	struct dtpm *dtpm_parent = parent ? to_dtpm(parent) : NULL;
>   	struct dtpm *dtpm;
> -	int i, ret;
>   
> -	for (i = 0; hierarchy[i].name; i++) {
> +	if (!node)
> +		return ERR_PTR(-EINVAL);
> +
> +	switch (node->type) {
> +	case DTPM_NODE_VIRTUAL:
> +		dtpm = dtpm_setup_virtual(name, dtpm_parent);
> +		break;
> +	case DTPM_NODE_DT:

... or a NULL check here.

> +		dtpm = dtpm_setup_dt(name, node->path, dtpm_parent);
> +		break;
> +	default:
> +		return ERR_PTR(-EINVAL);
> +	}


The rest looks good.

If we are sure we would never experience that NULL ptr coming to those
registration callbacks - then OK.

Regards,
Lukasz
