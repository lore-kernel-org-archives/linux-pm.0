Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6B509EE4;
	Thu,  1 Oct 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862435; cv=none; b=icueJBr6kLMaN/utWDlvYXfcDFk6xhQc0KTX0/8GCI27kCrMTU2hjIBKdn2em8Yp+tvuLt+PH9cbh5akdOdXDOXmloZxjmaLCk3X+40oR/BnNYKzlB9i2vDNmgWptzWN/5eFXzPVxbGMFoBmgv2Wx98SiwKwy4jh86QDGU25CWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862435; c=relaxed/simple;
	bh=LRHJAJ//qK4zk5OywvnZY+1YB/70Tz1Iq3n2t0jyays=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwgODolvkV9/YBsJoJyCRmzMTDVEAJy46D7Q9k4l0n7xO9Mu5638d8uXqcibwlZRqKpzj7hJP5DqmDUfXFyonhUcSV3ib6eIivikRKP6htK3IWXCqh03OedJthNxxUer3bNEm0KDnjqbUvgcbFr/FmpDlYntpJm8WjKu3guQg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5s1UsAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5s1UsAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202351F000FF;
	Thu,  1 Oct 2026 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862434;
	bh=bnMoeykuBZptdA3ds37XtwuD8lIdtRVgD7fPQTAPgf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O5s1UsArXOSPxdyHpqke7ocbx389Ztd7tE2kzQudZOuwWhvh5K1trVpaCYfiVbBvi
	 o0oWe0B0quz5w/JnezKzkYeeoGm1qtPAKVaMXUiZkWA66YjVjWnkyxtcScGe0KSDwk
	 KbPaHigeWOh4loRna77wiA8sLl7MKotQ4XjGjtoLe4wp8kp7Hco3H3UxGlG9fYJp0/
	 IiGV/15KHQxF8QDe2C7e2KKghI06cEkfHv9otCW2rkCYTajU/Csb4PNHqLoZFybKV2
	 V8MD7+C+cBYHp2QiIpBXBnRBI2GhxF36exeVzgLa/qSIhkLe5Exard8gr2xluK01cB
	 +Yf9tbhF1IHZQ==
Message-ID: <ca33c615-e429-49b1-b1f5-fa25a879a6fa@kernel.org>
Date: Thu, 1 Oct 2026 08:47:12 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cpufreq/amd-pstate: Get Highest Freq for a CPU
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Rafael_J_=2E_Wysocki_=E2=8F=8E?= <rafael@kernel.org>
References: <20260924160052.2858456-1-superm1@kernel.org>
 <20260924160052.2858456-4-superm1@kernel.org>
 <5b748ac7-26da-4010-bfc8-014a0c97abe2@arm.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5b748ac7-26da-4010-bfc8-014a0c97abe2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 05:03, Christian Loehle wrote:
> On 9/24/26 17:00, Mario Limonciello (AMD) wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If the highest frequency is known for a CPU, use this instead of
>> trying to calculate by linear interpolation.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 496e0342c1c90..2a0cbfe21a67d 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1102,8 +1102,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   
>>   	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>>   
>> -	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
>> -	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
>> +	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
>> +	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
>> +	if (!max_freq)
>> +		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
> 
> Don't you need to align freq_to_perf() (or the callers) for the BIOS-overwrite case too?
> amd_pstate_update_min_max_limit() still uses the nominal-based conversion for policy->max,
> so the new maximum frequency maps back to highest_perf on each core type?
> (and we end up with max_limit_perf < highest_perf if the BIOS-overwrite values are below
> the interpolation result.)
> 
> 
That's an excellent finding, thanks.
