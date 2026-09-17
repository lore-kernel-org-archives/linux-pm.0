Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6E328B56;
	Thu, 17 Sep 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650003; cv=none; b=sMkA+UJhBnPH8FuRo/eym1ZO08Jq0axNvgeqlaeNLa/TQW0Gvip6D3xV83Yb3ogBTQ2Fj/HSOKDWDIqGRI99PlyACTeBg8BHqYcJ4gEgcMwwwsIDLU767RmGTwx+oNC0jWngPX0aVg7ukB1711dDRkdUwi7PAXv3Zn2lXGVa4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650003; c=relaxed/simple;
	bh=mTzF+yShoitMy1XhYKgzrAkjElprstbxLWEb8BBPe1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNnVec37EZMeN8XSenSt9hDv/oRpmK8F/+qjuqAPMCRthyxNCVGXBE05eGr8fiBg0MG2lRjw87s8ujFU/aVvSFqIjlCioew8iTtYL89ZM8TNSgvQX2ohyhx1ngme+WfcoOs1+5z1tnVgSBEXSHherzjH4JNZFNFpuJgjHjyzaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RQNij013; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RQNij013"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56558143D;
	Thu, 17 Sep 2026 05:59:38 -0700 (PDT)
Received: from [10.57.50.144] (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E8693F86F;
	Thu, 17 Sep 2026 05:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789649981; bh=mTzF+yShoitMy1XhYKgzrAkjElprstbxLWEb8BBPe1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RQNij013lP3zRR4r2VQUXprI01bzTDGo6eV2Nmrc+DFZY2+lEfHX0RSWMSZF4pbqT
	 8W0uO/xPCqyYosFvB3k6/dz2f2hSfGkdlez4tjj6MdKCgFwNcmZ0W8pO3OcrgkXE+L
	 gHuaUWA2v0+c0TVucuO1tDwTAzhszdpPsg/mvzuI=
Message-ID: <9ad67536-7b6e-4633-8cc7-52b0d68196fc@arm.com>
Date: Thu, 17 Sep 2026 13:59:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/20] ACPI: CPPC: Keep Performance Limited clearable
 on NVIDIA T41
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com
References: <20260916162805.1039247-1-christian.loehle@arm.com>
 <20260916162805.1039247-16-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260916162805.1039247-16-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 17:28, Christian Loehle wrote:
> From: Sumit Gupta <sumitg@nvidia.com>
> 
> NVIDIA T41 firmware describes Performance Limited as a two-bit field at
> offset zero in a DWord SystemMemory access unit. Generic CPPC code must
> keep such a field read-only because preserving the remainder when clearing
> it requires a read-modify-write which cannot be interlocked with platform
> updates.
> 
> The remaining bits of this access unit are unimplemented on T41: they read
> as zero, writes have no side effects, and no other register uses them. The
> Performance Limited register therefore owns the complete access unit, but
> shipped firmware does not describe that property accurately.
> 
> Add a CPPC platform-quirk table keyed by the DSDT header and carry quirk
> behavior through explicit flags. Cache a successful table lookup, copy each
> GAS into the driver's private descriptor, and apply fixups before layout
> validation, mapping and overlap registration.
> 
> Distinguish a genuine non-match from a table-header lookup failure in
> acpi_match_platform_list(). Propagate lookup errors from CPPC probe without
> caching them, so a transient mapping failure cannot disable the workaround
> for every later processor. Existing matcher callers still treat all
> negative results as no match.
> 
> For the known T41 layout only, widen a two-bit Performance Limited field at
> offset zero to its 32-bit access width. Clearing both status bits can then
> be issued as one DWord write of zero without a stale read. Corrected
> firmware which reports the full width is unchanged. The workaround
> therefore lapses automatically when corrected firmware ships.
> 
> Link: https://lore.kernel.org/lkml/d5f1ea9b-53b7-4db2-983a-b5be8e71a371@arm.com/
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> [ Rework quirk matching and fixup placement; propagate lookup failures
>   without caching them. ]
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 72 ++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/utils.c     | 13 ++++++--
>  2 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6d130381245e..0e218f2be0fe 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -330,6 +330,68 @@ static unsigned int cpc_reg_access_width(const struct cpc_reg *reg)
>  	return reg->bit_width;
>  }
>  
> +enum cpc_platform_quirk {
> +	CPC_QUIRK_PERF_LIMITED_OWNS_UNIT = BIT(0),
> +};
> +
> +static const struct acpi_platform_list cpc_platform_quirk_list[] = {
> +	{
> +		.oem_id = "NVIDIA",
> +		.oem_table_id = "T41",

Sashiko:
"Will this quirk successfully match a standard ACPI table header?
The ACPI specification requires the OEM Table ID to be exactly 8 bytes long,
typically padded with trailing spaces by compliant firmware (e.g.,
"T41     ").
Looking at acpi_match_platform_list(), it compares the IDs using:
strncmp(plat->oem_table_id, hdr.oem_table_id, ACPI_OEM_TABLE_ID_SIZE)
Because "T41" is a null-terminated 3-character string, strncmp() will
compare the 4th character ('\0' from the quirk definition vs ' ' from the
ACPI table header) and immediately report a mismatch, causing the quirk to
silently fail on compliant firmware.
Should this be padded with spaces (e.g., "T41     ") to ensure it matches
the firmware's table correctly?"

non-padded "T41" matches exactly what Sumit proposed and was discussed in v6:
https://lore.kernel.org/lkml/55a5c9fa-cfd3-4000-b3cc-52c343841c9f@nvidia.com/
So once Sumit adds Tested-by: this should be fine.

>[snip]
