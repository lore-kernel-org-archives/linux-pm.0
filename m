Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577955;
	b=T9lpPsY2AoMQeuk4eGMi5xvDD87/77uJYMBsI7mqxpKxJJNxdN8vLfZ2YBATtF+Ns/0A
	 tQar9M3FlllJcXdEg9aHbg8AF7qN7JDWhGtp8nzdyEesk2oZzRA/FVtf9t2EFDx6Vzyc0
	 zIWl07PTULIqxqqT4CeRkLxY1IhZ5HzGYCObnMF2c4HR/5ih48n+vAiKQFgLjeoGser2r
	 1WS3pSIl0dc0bCHk1sPrWXUN7gQ/OHNTeT25eA7tDpRmrlPVnzyngg4VWk7qFjvcH4ZPh
	 gGAPEfEMbpk6ViIBX3DiSc/0RiyE5zEejHRq2V9N5Hl1WWKLq6u37F16y4R4hjFMJAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577955;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DVK4z9etFVD2eXEgskV5ZDkyIhWAOb5codKfSON7FuE=;
	b=fygQo14c9mWZLD28AXfONyUxugvMMxK626BlQakANwg76s9fxMldFiSCiA9u2PEcpza9
	 DX465/Ce0y3Ov5chZE2sxQep1FiJfEs7wvIe9kLG3/4ZzRXmybKv3s2ViINMFyEtCqWO9
	 5TsTtD6jc9FFmBAf4++NiNYjxcoSG8aizeYkiE9LZNf0k1Ot0NnlAeYUsS1QQI5MU9BEk
	 gZAjoOVIGKgwV7WxkaMm8OSi45Zh3lIoTHP7mgQuaiPUEkvwOyjST70wY1H7VCSMtb0Ac
	 Ide2VJjQv8REdXFPTnCSdT/UzQ7YHLXGeEA/tMxEzvDaZAPwWTwBr84hxfQxwF9vmnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RoQ4y/LM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59C606E0D9;
	Fri, 13 Nov 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoQ4y/LM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE591F000C4;
	Fri, 13 Nov 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577954;
	bh=DVK4z9etFVD2eXEgskV5ZDkyIhWAOb5codKfSON7FuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RoQ4y/LMu5IZ34wonw3kFL5eyrmJh+9B+WwxGGhscM0mw7zrzPufIgBVXIEn3e35B
	 24IgA6/0rPqG7i8HcmcnNziGf9uXsonS01vknanyf/bRSpHKXtYu3abCyIO4rHEfY+
	 Q68m3I3fzzZxLeoiB58yd9Iotm6LCkn3aKgtzy0ybLRF4rb1HAU1ef7PXY7mDiYIZz
	 tEblFwNMpfLI+uX+r67QSY9dqty92ChxpwZUUz7xynYYlSYa8vQF03/rwPuU8O7huY
	 QDRWSkK16FsDBxWlFiAaNOEIJ9LNUMi7UyI98DeXGeR2CFbNfeKMhwVJTQ2dXdD9zc
	 VzeLm+IJO1BKg==
Message-ID: <30a6c6c2-95ad-4f98-a63e-25f311967ed8@kernel.org>
Date: Fri, 13 Nov 2026 07:52:31 -0600
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
Subject: Re: [PATCH] ACPI: CPPC: Reject EPP registers narrower than 8 bits
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 sumitg@nvidia.com, luoxueqin@kylinos.cn, zhanjie9@hisilicon.com,
 zhangpengjie2@huawei.com
References: <20261113130411.1433174-1-christian.loehle@arm.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261113130411.1433174-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 07:04, Christian Loehle wrote:
> The EPP interfaces use an 8-bit preference, but ACPI permits narrower
> fields. With a 4- or 6-bit SystemMemory field, writing 128 succeeds but
> stores zero, requesting maximum performance instead.
> 
> Reject a present EPP register narrower than eight bits during _CPC probe.
> Use the existing error path to release previously acquired resources and
> leave the CPU's CPPC descriptor unpublished. Keep absent EPP entries and
> registers at least eight bits wide on their existing paths.
> 
> Fail the whole probe instead of disabling only EPP. This also makes
> amd-pstate's acpi_cpc_valid() check reject the platform before registering
> its MSR or shared-memory driver. No affected hardware is known or
> expected and the specification is expected to no longer permit these
> in the future.
> 
> Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selection")
> Link: https://github.com/tianocore/edk2/issues/10838
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/acpi/cppc_acpi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 11a9f9eb6b4a..4c3d5778e428 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -2094,6 +2094,15 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   			cpc_apply_platform_quirks(gas_t, i - 2,
>   						  platform_quirks);
>   
> +			/* EPP interfaces require the full 0-255 preference range. */
> +			if (i - 2 == ENERGY_PERF && gas_t->bit_width < 8 &&
> +			    !IS_NULL_REG(gas_t)) {
> +				pr_debug("CPU%d: EPP register width %u is not supported\n",
> +					 pr->id, gas_t->bit_width);
> +				ret = -EOPNOTSUPP;
> +				goto out_free;
> +			}
> +
>   			/*
>   			 * The PCC Subspace index is encoded inside
>   			 * the CPC table entries. The same PCC index

