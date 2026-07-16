Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021A422531;
	Thu, 16 Jul 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205879; cv=none; b=fIpnUuiYwc76kKVDtPQiTiTmf3hWduMThVrPGfoZ8l3pVlffn5dyGkjKCj0SLKDDUkFmh+j76dqpbpDOPQbAR+bW18HhA2/vH6q7ODkuyf0iJRsBwhj/lhqgHQkdDVewz4dIIP5MjJH2Iskpptw70Ogi5zUyxAOC+HTsj6SRJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205879; c=relaxed/simple;
	bh=WnRih0NAjVIiwDEHOtWiUnl99hIQbHyC+oefJ25xZmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cJkJRO/5YY0oTVOZON5Z/tCbQx7o1gYoCz4Q8xI9wtDty13lg225jGEzaGkcMJVQb+fJMpF0XZd6bT4LnHEioMKiHyDHjs2VFW15HVOngglGWTTc8nQbjdPqMCM+AC80MdWwV4B7ffoPB3SG+gBzdWNWXrrb9bbVRwsapD9zv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=kOY34fJ/; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="kOY34fJ/"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T3qeciP/GDJGreqhuvQ1sCFFGE07CCPeZ4YpiEhIcLc=;
	b=kOY34fJ/8Mij8vaGlvcETxJ4dm3fIORdyg+LFnxfDBZqZaK3LLpu5X8eNorH3odJiodNvMHXB
	gdsI5UUNTQ8o+NmXIudRy/wVOYoCeM1dTutEK4Uh5cGHOWGp7zQg4ZjJ7nXXzL5ksflf15US7qQ
	mFVFzIYQvly6LqgU1TFUFzY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h1CDf3ScqzRhSH;
	Thu, 16 Jul 2026 20:35:14 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E8D04058C;
	Thu, 16 Jul 2026 20:44:32 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 20:44:31 +0800
Message-ID: <db010283-a568-4683-a880-53c0b27f8a8c@huawei.com>
Date: Thu, 16 Jul 2026 20:44:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/17] ACPI: processor: idle: Rework first-level _LPI
 states processing
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3703077.iIbC2pHGDl@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3703077.iIbC2pHGDl@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:37 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> The first-level _LPI states need not be combined with the previous
> level and the entry method for them cannot be ACPI_CSTATE_INTEGER, so
> process them directly in acpi_processor_get_lpi_info() instead of doing
> a special case for them in flatten_lpi_states().
>
> Also bail out if there are no _LPI states at the first level because
> that means that there are no _LPI states at all.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/processor_idle.c | 47 +++++++++++++++++++++++++++--------
>   1 file changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index e990a43514e6..efd3e76377fa 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1068,13 +1068,6 @@ static unsigned int flatten_lpi_states(struct acpi_processor *pr,
>   
>   		flpi = &pr->power.lpi_states[flat_state_cnt];
>   
> -		if (!prev_level) { /* leaf/processor node */
> -			memcpy(flpi, t, sizeof(*t));
> -			stash_composite_state(curr_level, flpi);
> -			flat_state_cnt++;
> -			continue;
> -		}
> -
>   		for (i = 0; i < prev_level->composite_states_size; i++) {
>   			p = prev_level->composite_states[i];
>   			if (t->index <= p->enable_parent_state &&
> @@ -1101,9 +1094,10 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>   {
>   	struct acpi_lpi_states_array info[2], *prev, *curr;
>   	acpi_handle handle = pr->handle;
> -	unsigned int state_count;
> +	unsigned int state_count = 0;
>   	acpi_status status;
> -	int ret, i;
> +	unsigned int i;
> +	int ret;
>   
>   	/* make sure our architecture has support */
>   	ret = acpi_processor_ffh_lpi_probe(pr->id);
> @@ -1117,12 +1111,45 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>   		return -EINVAL;
>   
>   	curr = &info[0];
> +	curr->composite_states_size = 0;
>   
>   	ret = acpi_processor_evaluate_lpi(handle, curr);
>   	if (ret)
>   		return ret;
>   
> -	state_count = flatten_lpi_states(pr, 0, curr, NULL);
> +	/* Copy all of the usable first-level states to power.lpi_states[]. */
> +	for (i = 0; i < curr->size; i++) {
> +		struct acpi_lpi_state *lpi = &curr->entries[i];
> +		struct acpi_lpi_state *flpi;
> +
> +		/*
> +		 * Skip states that are not enabled or have an inadequate entry
> +		 * method for this level.
> +		 */
> +		if (!(lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED) ||
> +		    lpi->entry_method == ACPI_CSTATE_INTEGER)
> +			continue;
> +
> +		if (state_count >= ACPI_PROCESSOR_MAX_POWER) {
> +			acpi_handle_info(handle,
> +					 "No space for more _LPI states than %d\n",
> +					 ACPI_PROCESSOR_MAX_POWER);
> +			break;
> +		}
> +
> +		flpi = &pr->power.lpi_states[state_count++];
> +		memcpy(flpi, lpi, sizeof(*lpi));
> +		stash_composite_state(curr, flpi);
> +	}
> +
> +	kfree(curr->entries);
> +
> +	/*
> +	 * If there are no _LPI states at the first level, there are no _LPI
> +	 * states at all.
> +	 */
> +	if (!state_count)
> +		return -ENODATA;
>   
The code is easier to understand after this rework.
But the "first level" is not good to me.
IIUC, the first level is processor, right?
In addition, how about extract a function, like, 
flatten_processor_lpi_states, for these codes?
>   	prev = curr;
>   	curr = &info[1];
