Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC712E888A;
	Thu, 16 Jul 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195210; cv=none; b=u6hVPO4SkrgoL9l4rXuX+kDwzFAuLhZjGHC6HC5mugQzyK4ReD1mC+0EwPLwIz1QwSCpJZI/u2UX7Re9VbcZvxJ3SsC1yaLSEtB8Gm4weCvL5eLJXFTmt3+3KJKIP3BPL+34e5waOB11UBU7AtEVNu54B4/HQgfqwSlSF40VTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195210; c=relaxed/simple;
	bh=VRVS/GZI8z2WHs6m43fDbkGPnX/wnVTefmn1bUyi9NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PL0k0Pb/KVoalzUVOWr6T0lU8PdCYEz0yDcFImpeRueX8twGmJeRbDNzmiwtpHr2ICPL3iV31LIiqfM3K1i7ctgJOMFqO7roRpyUrMO+GylgXD/LtKmhNzh3n5YiYxrnAlgb6q7FfRktA3w0m2mAYQHZjsBv8qHSNb2KzIXpjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Bxa1ZyrO; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Bxa1ZyrO"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kxvPnZOc4V5Z/IDHfLxJh518yDmoNkfjaBuhx5MIzSY=;
	b=Bxa1ZyrO6It5GA8uSCESUOr4XutGx0Hv8qvs6V0e08ffIbBLdpHXXJHLpgfKrkeYBliVAKRKj
	nMEO8OlI8TO96rRXFtwmLzsgNqzZ86/8re+ZMP0MsAitP7GmujFc4t4i+fhqGXt1OFFCKZmAOI0
	FXW6aiMFSu2dcMYQkFhE48Q=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h17HS2t36zmV8f;
	Thu, 16 Jul 2026 17:37:24 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A4E84048B;
	Thu, 16 Jul 2026 17:46:43 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 17:46:43 +0800
Message-ID: <9ba08e86-d7ab-485d-b996-9f70d709071e@huawei.com>
Date: Thu, 16 Jul 2026 17:46:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/17] ACPI: processor: idle: Rearrange
 acpi_processor_evaluate_lpi()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3426078.44csPzL39Z@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3426078.44csPzL39Z@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:33 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Rearrange acpi_processor_evaluate_lpi() to make it somewhat easier to
> follow and diagnose (if need be).  In particular:
>
>   * Rename some local variables and reorder their definitions.
>
>   * Change the type of local variables used for storing firmware-provided
>     values to unsigned int (they cannot be negative).
>
>   * Eliminate local variable "loop" that is redundant.
>
>   * Avoid explicit pointer arithmetic.
>
>   * Print the correct number of _LPI state packages in the final debug
>     message.
>
> No intentional functional impact beyond debug output.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/processor_idle.c | 64 +++++++++++++++++++----------------
>   1 file changed, 34 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index e8682f779249..cd506e9e5a84 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -872,12 +872,12 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
>   static int acpi_processor_evaluate_lpi(acpi_handle handle,
>   				       struct acpi_lpi_states_array *info)
>   {
> -	acpi_status status;
> -	int ret = 0;
> -	int pkg_count, state_idx = 1, loop;
>   	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *lpi_data;
> +	union acpi_object *lpi_data, *lpi_pkg;
> +	unsigned int lpi_pkg_count, state_idx;
>   	struct acpi_lpi_state *lpi_state;
> +	acpi_status status;
> +	int ret = 0;
>   
>   	status = acpi_evaluate_object(handle, "_LPI", NULL, &buffer);
>   	if (ACPI_FAILURE(status)) {
> @@ -895,41 +895,46 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>   		goto end;
>   	}
>   
> -	pkg_count = lpi_data->package.elements[2].integer.value;
> +	lpi_pkg_count = lpi_data->package.elements[2].integer.value;
>   
>   	/* Validate number of power states. */
> -	if (pkg_count < 1 || pkg_count != lpi_data->package.count - 3) {
> +	if (!lpi_pkg_count || lpi_pkg_count != lpi_data->package.count - 3) {
>   		acpi_handle_debug(handle, "Invalid _LPI state count\n");
>   		ret = -ENODATA;
>   		goto end;
>   	}
>   
> -	lpi_state = kzalloc_objs(*lpi_state, pkg_count);
> +	lpi_state = kzalloc_objs(*lpi_state, lpi_pkg_count);
>   	if (!lpi_state) {
>   		ret = -ENOMEM;
>   		goto end;
>   	}
>   
> -	info->size = pkg_count;
> +	info->size = lpi_pkg_count;
>   	info->entries = lpi_state;
>   
> -	/* LPI States start at index 3 */
> -	for (loop = 3; state_idx <= pkg_count; loop++, state_idx++, lpi_state++) {
> -		union acpi_object *element, *pkg_elem, *obj;
> +	/* _LPI State packages start at index 3. */
> +	lpi_pkg = &lpi_data->package.elements[3];
>   
> -		element = &lpi_data->package.elements[loop];
> -		if (element->type != ACPI_TYPE_PACKAGE || element->package.count < 7)
> +	for (state_idx = 1; state_idx <= lpi_pkg_count;
> +	     state_idx++, lpi_state++, lpi_pkg++) {
> +		union acpi_object *lpi_pkg_elem, *obj;
> +
> +		lpi_state->index = state_idx;
> +
> +		if (lpi_pkg->type != ACPI_TYPE_PACKAGE || lpi_pkg->package.count < 7)
>   			continue;

The first place to verify the count of LPI package.

>   
> -		pkg_elem = element->package.elements;
> +		lpi_pkg_elem = lpi_pkg->package.elements;
>   
> -		obj = pkg_elem + 6;
> +		/* Get the entry method first and skip the state if that fails. */
> +		obj = &lpi_pkg_elem[6];
>   		if (obj->type == ACPI_TYPE_BUFFER) {
>   			struct acpi_power_register *reg;
>   
>   			if (obj->buffer.length < sizeof(*reg)) {
>   				acpi_handle_debug(handle,
> -					"Invalid register data for _LPI state %d\n",
> +					"Invalid register data for _LPI state %u\n",
>   					state_idx);
>   				continue;
>   			}
> @@ -937,7 +942,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>   			reg = (struct acpi_power_register *)obj->buffer.pointer;
>   			if (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) {
>   				acpi_handle_debug(handle,
> -					"Unsupported entry method for _LPI state %d\n",
> +					"Unsupported entry method for _LPI state %u\n",
>   					state_idx);
>   				continue;
>   			}
> @@ -949,36 +954,35 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>   			lpi_state->address = obj->integer.value;
>   		} else {
>   			acpi_handle_debug(handle,
> -					  "Invalid entry method for _LPI state %d\n",
> +					  "Invalid entry method for _LPI state %u\n",
>   					  state_idx);
>   			continue;
>   		}
>   
> -		lpi_state->index = state_idx;
> -		if (obj_get_integer(pkg_elem + 0, &lpi_state->min_residency)) {
> +		if (obj_get_integer(&lpi_pkg_elem[0], &lpi_state->min_residency)) {
>   			acpi_handle_debug(handle,
> -					  "Assuming 10 us min. residency for _LPI state %d\n",
> +					  "Assuming 10 us min. residency for _LPI state %u\n",
>   					  state_idx);
>   			lpi_state->min_residency = 10;
>   		}
>   
> -		if (obj_get_integer(pkg_elem + 1, &lpi_state->wake_latency)) {
> +		if (obj_get_integer(&lpi_pkg_elem[1], &lpi_state->wake_latency)) {
>   			acpi_handle_debug(handle,
> -					  "Assuming 10 us wake latency for _LPI state %d\n",
> +					  "Assuming 10 us wake latency for _LPI state %u\n",
>   					  state_idx);
>   			lpi_state->wake_latency = 10;
>   		}
>   
> -		if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
> +		if (obj_get_integer(&lpi_pkg_elem[2], &lpi_state->flags))
>   			lpi_state->flags = 0;
>   
> -		if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags))
> +		if (obj_get_integer(&lpi_pkg_elem[3], &lpi_state->arch_flags))
>   			lpi_state->arch_flags = 0;
>   
> -		if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_freq))
> +		if (obj_get_integer(&lpi_pkg_elem[4], &lpi_state->res_cnt_freq))
>   			lpi_state->res_cnt_freq = 1;
>   
> -		if (obj_get_integer(pkg_elem + 5, &lpi_state->enable_parent_state))
> +		if (obj_get_integer(&lpi_pkg_elem[5], &lpi_state->enable_parent_state))
>   			lpi_state->enable_parent_state = 0;
>   
>   		/* Skip elements [7-8] i.e. Residency/Usage counters. */
> @@ -987,16 +991,16 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>   		 * Avoid out-of-bounds access if the size of the package is less
>   		 * than expected.
>   		 */
> -		if (element->package.count < 10)
> +		if (lpi_pkg->package.count < 10)
>   			continue;
>   
second place.

I think the package count should be compared with 10 and placed at the 
begin of the loop.
Even the optional element in LPI package also should be define NULL 
register or NULL string based on Spec 6.6.
And they still occupy at least one position. For example, "State Name" 
must be "" if platform doesn't support it.
So this packet count is at least 10.
> -		obj = pkg_elem + 9;
> +		obj = &lpi_pkg_elem[9];
>   		if (obj->type == ACPI_TYPE_STRING)
>   			strscpy(lpi_state->desc, obj->string.pointer,
>   				ACPI_CX_DESC_LEN);
>   	}
>   
> -	acpi_handle_debug(handle, "Found %d power states\n", state_idx);
> +	acpi_handle_debug(handle, "Found %u power states\n", lpi_pkg_count);
>   end:
>   	kfree(buffer.pointer);
>   	return ret;
