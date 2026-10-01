Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457C472531;
	Thu,  1 Oct 2026 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848987; cv=none; b=l7ClV9K6cHVolqwXwZM92IhIWuR7Fe3LNKR6gNGbn//86DsQ4tO7b6HYu6hM7tIxrv2VN+d2qu9PCTFB1YkEEDJvmW6f/qB+e0qBdzPl1CFb4CW4a7DZvm7DX1IZ6ywfIOuW6gWL2Vc26+D2yJQ8dze9ffyiNhK6hdSQmsgkVoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848987; c=relaxed/simple;
	bh=esFJv3tzq3GjLICQ3vHBhZdmoY4Nkj+8PiOnbXfPFS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSUKW1/W+eWZTlZxwEK3zvliTim9VfgshkbmwqIfm4DlHpUr67cy4mg/BACQmMf5dH5YsoBY3ka0LCXd+C1zzkNxz1SD/j9vU2CzVohJfE17ot6kxPxkpjFZhao0gGwKvQJQ2BSFtxs2QaSH8P5KkLJ/QYVJpxl6tJAvFYWaVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LADWCU1+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LADWCU1+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 553FF497;
	Thu,  1 Oct 2026 03:03:01 -0700 (PDT)
Received: from [10.0.130.165] (e127648.arm.com [10.0.130.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73F0A3F86F;
	Thu,  1 Oct 2026 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790848984; bh=esFJv3tzq3GjLICQ3vHBhZdmoY4Nkj+8PiOnbXfPFS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LADWCU1+h7wROBYy3JPnb2C+1EeR88NOYHy/RK6j+e4WArcop+CsQEvpLXVmtTf6P
	 iV8WYMsDgeycdq/qMhmQ4mr1UpKVOchR7oWE0v05HA7uv0nbjdhYmWBMoekk7sySIk
	 ozIqJe/JAfw3ImpogjcKvDPTzJvIOCLx3+ldb9+I=
Message-ID: <5b748ac7-26da-4010-bfc8-014a0c97abe2@arm.com>
Date: Thu, 1 Oct 2026 11:03:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cpufreq/amd-pstate: Get Highest Freq for a CPU
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?Q?Rafael_J_=2E_Wysocki_=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20260924160052.2858456-1-superm1@kernel.org>
 <20260924160052.2858456-4-superm1@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260924160052.2858456-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 17:00, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If the highest frequency is known for a CPU, use this instead of
> trying to calculate by linear interpolation.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 496e0342c1c90..2a0cbfe21a67d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1102,8 +1102,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>  
> -	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
> -	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
> +	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
> +	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
> +	if (!max_freq)
> +		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);

Don't you need to align freq_to_perf() (or the callers) for the BIOS-overwrite case too?
amd_pstate_update_min_max_limit() still uses the nominal-based conversion for policy->max,
so the new maximum frequency maps back to highest_perf on each core type?
(and we end up with max_limit_perf < highest_perf if the BIOS-overwrite values are below
the interpolation result.)


>  	WRITE_ONCE(cpudata->max_freq, max_freq);
>  
>  	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);

