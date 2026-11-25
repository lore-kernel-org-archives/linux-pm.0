Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601165;
	b=Bvom14JvUIkzRYT9oBz14dvPS/ImMUiyLXx1THtQghpnGiUsVF5vGXPKyw6Wrj+5zLAF
	 O5ZXnrFZX90kdGMgpCf/CLuzXOcszBwV20bwKZZCaoG/DIKKjP6it9w7YkvGoZ0uzPG7m
	 vyrp4kHhOKhzaFfFv1n2LmoNH/Q9F68GPyd74dVdUVLz5kkMEyj+ax96AEoT0ES5/U7Ow
	 eXfNBJ6Oj5z3lyEx0jvhi8dblNAjNPveeichc2F4J3NfLJG4Zd3T8NMoOcRKphLbEsVYb
	 /XpF8CCF7GxoWYX0cP0st9W/eKgJCGuSxRENVjUhYRqo44ezSSWtSpbluOf2/fLqTVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h3UMk1rW3fjxSyF4tH74Yzi8ILA/+mi78plO5dTp5sM=;
	b=QIiUTWfavKz56c3XSKGea5UpIMl8d9Gs32E+icOD2Xy3f19t4lpRuCOTcATpGUUhXtBg
	 1j4+Ky/K1QB6nKcYM6BcVkOTI+cPtd+qLLkDBenAkRlyzNPRSoTOSrMYlTXnYNAA/OeaS
	 Z8hEpettUhgywdTNnDqwwtOkCR2ZHG5F15wFDZxfn7+78pIjtM0fVgX/C74bW39OVayyX
	 0Ue0uKyYZx/375z6Qi8pu9R+Z22rLgzbB6qJ7Lfv3xDZwhhxZfh8epN9tQHbL8G5poadO
	 juwiPaO3t9xHY1qQoguZmRaXz+agBuouBnCv14IvHledAp3p5av6tvMc5yExPW9rcNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXZP5evJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD68606A326;
	Wed, 25 Nov 2026 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXZP5evJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2E71F000C4;
	Wed, 25 Nov 2026 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601165;
	bh=h3UMk1rW3fjxSyF4tH74Yzi8ILA/+mi78plO5dTp5sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LXZP5evJM5IiOOyGcNkPoboa2RKGtwXTVmZw1F3C/r85voShs2H90kVfozUHpJxmi
	 lgc5PZK2WkLE/U/NgWijWotmdKQQivEoge0gRU9U9XcenNR2RVOYG5zf8kOYh8NU/W
	 gVxQCMpxmZfoi6F+hteFXjf0iRhQ1OPxpTU0wl2QW0Moj7xyn1VOhmgPq/MlbIDcE5
	 /bpjKiuBiTnqG2oEF46MSvIpckzR+PfgzqYuLTA4aVOnOBgwRQaH2Z/B7/HCthHGQR
	 ivpmAIA9X7IvnxsvuIWQU3rbCmJN9ZQK7Yrq5XrNDUgns2VOw1kSYcQaT72+l43l2m
	 WwEr8gpXUWaCA==
Date: Wed, 25 Nov 2026 11:06:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Jez Ng <jez@sfcompute.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Juergen Gross <jgross@suse.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: semantic conflict between the pm and tip trees
Message-ID: <awazCCauTdRXg_-i@gmail.com>
References: <20261124145646.3655959-1-sashal@kernel.org>
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
In-Reply-To: <20261124145646.3655959-1-sashal@kernel.org>


* Sasha Levin <sashal@kernel.org> wrote:

> Hi Mark,
> 
> The current pm tree has a semantic conflict with the tip tree that
> breaks the x86 build:
> 
>   drivers/thermal/intel/intel_hfi.c:407:38: error: too many arguments to function call, expected single argument 'msr', have 2 arguments
> 
> 437ce3015e51 ("thermal: intel: hfi: Disable HFI on shutdown and kexec")
> in the pm tree uses rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val), and
> e7f9f17e0013 ("treewide: Convert rdmsrq() from a macro to an inline
> function") in the tip tree makes rdmsrq() take only the MSR and return
> the value.
> 
> The fix for the merge:
> 
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -404,7 +404,7 @@ static bool hfi_disable_if_enabled(void)
>  {
>  	u64 msr_val;
> 
> -	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> +	msr_val = rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG);
>  	if (!(msr_val & HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT))
>  		return false;

LGTM, thank you!

	Ingo
