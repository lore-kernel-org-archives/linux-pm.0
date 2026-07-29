Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D831E84B
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367776; cv=none; b=FnkI+b1yvl7cBP4Hx2Nii7pQwkoOu5YQHXA/+rhejypcbenFB0DlSaK/99Awftk2+bs0jpLdaNJBsKjM2Ya/e/LttzGG8wsT2YuVDbWtwC2RIljCr40xI8O7dJhxK7mniFMgxoHDm5ktir50LVUXuKeHu3umImqHSOyz9tnjznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367776; c=relaxed/simple;
	bh=hl1Ib/M7Yw2iZeG1rhAPs4HflwAxy9hRllmeSId3aOo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=PgSZuP5Xso/B7cQkJb+XkZ1NRH6MYT1vSK0iW9CyG6h4eM85e5c4k9bTbXApM6yBVf/UyOLH44MDD2PdLBrYJv07R0q9UnTj/uIAMk6YoxGrC7m/2bLh56NpSqh1zLTXMo4eCGVYxVs3bEiXo5OSJRBPtK8xvRVIoG0H74O6r7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=Rw3I1KQw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Rw3I1KQw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad8076b01so19861365ad.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1785367774; x=1785972574; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6aG0IL6r3b6mY/VxEmFy40uC4lepHuqgONhuTlo/5Ow=;
        b=Rw3I1KQwt+Qre/qoWEeTTBLtZcs859WExmXEF24i6ELlunwth9Ly2jQWcdGEKG8zmG
         JDAMGoflTSdipP4pU4gJnoAiUD7CGwf6r1yes5ndnZC5mt3/1xZLLQcwo0TpzL2eeWud
         U04b6e77DHRCN6cCGEQPib+3KOjVwN75NBuvbW727ghzc5Il9ofXvCpDTji3Vou2lZf7
         b3cpnQflU5KcXLacbq8awS8oQu87dYSsoxG8hQDCibPihd1mrHMl2ixIsbzAvkEQDL49
         30f+g3V9PM5EYPXUQnz2B5DTv8zV9jkZLry9GvFUYlsHsQ3+YNuwOyH4WPUZAR+PqIrE
         4c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367774; x=1785972574;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6aG0IL6r3b6mY/VxEmFy40uC4lepHuqgONhuTlo/5Ow=;
        b=c1/nd3F5YOuOrDyYRCxE5Zf8ufHEF+V+MXKPLC+9yoeolLzuh4OB2xc5LJC91R/sak
         sCg0g4Y3l1HiZBLbt2T/s3ynjOC9T205bRgcah2WE1zzUwvIwrq3QOc0upTBnHacuWV4
         pQofalcnKtSGV2nVLtiGs8AUVBMi38XyCOBN1iwKeE7zJ/WHIluG4TK33Y3ZA50VEWLr
         Huylj6o6qhnfRwHS/YjP18HBSsozVVKFSHljJ+a3whn7PqBbdj3+gyG3Dwczt5dHrvxH
         wuczcf2a1QHZGh7wSnNyNEiP1qI736PM8Sw8izHXCNsxrOD7AgjrHpue1Klsrb29YY/K
         t9+g==
X-Forwarded-Encrypted: i=1; AHgh+Rq0YHGvuN6bNxT9qDrr8XPeRUwk065ayGA7MBY95Pv9A8QXbD5dvUdNAp31ofSFZi6yLIona5k23g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8L2JeLnCheCNWUp/aLkW13p2T3NH8S7nqW3gMEnnuYqMLbJJ1
	7oOwNm+BYbKQ7GOEvAEXoOJK1/hypryzmteE4EKRFfeZcxRnR/g3vFDS0xTov0/0it3gZURjQ2I
	DjKBE
X-Gm-Gg: AR+sD11Pl8zZXShy13CcQRn9laZwKSHmdxKzbDMcKHQqJFfcPQS9Fiai/Jeaf1Fd7e5
	WJRTPSqakrjb9Q4KJ/s/OjOR4eiz3f569BLa/z4QFwT+AI1gLZWahKUnEUHASKkXyJg5NAhUjm1
	mUhREc39gFQdW4cbHtHxGlwUL7dVoyvhIc8lZOdyjcZ4RbWjPE1hBC64ZXgs1xmjMyVBdOtX87Q
	/3zSVWpFML+OAa66MQ8OHSngCIK5nI4DfeQ7iEtj4InzkrdyYcFWFqBme5zgTiZsyPcRmkxZG5w
	sZ6nDB8RwvjesVucU7Br6xtQmLa2RqtNmhVvxWYkBLIO3kP/D/6PDC2eed3vICze8PNVrn3Faug
	AGYkS6UwmFe0sgcbHRPJQZ2HnY87lUysUAvyFTmSp77HT5LVg6tUNmU0bFHa5XEAGhR/SSy1DhV
	EwjTayBam3IiRTNaflTq0/VrE6wDagPpOz6Tw88xOzhUKGevIW+LSjuepCRrzc3zfKKzTXivKre
	9jPtLcj
X-Received: by 2002:a17:903:2448:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2d035b89ee5mr3319005ad.1.1785367773707;
        Wed, 29 Jul 2026 16:29:33 -0700 (PDT)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a45e54sm17267395ad.19.2026.07.29.16.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2026 16:29:32 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Jing Wu'" <realwujing@gmail.com>
Cc: "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
	"'Viresh Kumar'" <viresh.kumar@linaro.org>,
	"'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com> <5144014.31r3eYUQgx@rafael.j.wysocki>
In-Reply-To: <5144014.31r3eYUQgx@rafael.j.wysocki>
Subject: RE: [PATCH v1] cpufreq: intel_pstate: Adjust policy->cur in active mode to policy
Date: Wed, 29 Jul 2026 16:29:34 -0700
Message-ID: <000d01dd1fb2$1da56040$58f020c0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHOJAi6qIzHEZ5RGWicFI5AvI6gywKAe4Rcto8PH+A=

Hi All,

On 2026.07.29 11:40 Rafael wrote:
>On Wednesday, July 29, 2026 10:59:24 AM CEST Jing Wu wrote:
>> When cpu->policy is CPUFREQ_POLICY_PERFORMANCE, intel_pstate_set_policy()
>> pins the CPU to a fixed pstate (max(min_pstate, max_perf_ratio)) and
>> programs it directly, precisely because, per the existing comment,
>> "NOHZ_FULL CPUs need this as the governor callback may not be invoked
>> on them". Two lines later it still unconditionally clobbers policy->cur
>> down to policy->min, discarding the pinned value it just computed and
>> applied.
>> 
>> arch_freq_get_on_cpu() falls back to cpufreq_quick_get(), i.e.
>> policy->cur, whenever its APERF/MPERF sample goes stale. A CPU whose
>> tick keeps running refreshes that sample constantly and rarely hits
>> the fallback, but an isolated CPU covered by nohz_full with a single
>> runnable task never gets another tick, so it permanently reports the
>> floor through this fallback - even though it is genuinely pinned to,
>> and running at, the frequency computed just above.
>> 
>> Set policy->cur to the exact pinned frequency (pstate * scaling) in
>> the CPUFREQ_POLICY_PERFORMANCE branch instead, and only fall back to
>> policy->min for the general case, where the frequency genuinely isn't
>> known without a fresh sample.
>> 
>> Fixes: d51847acb018 ("cpufreq: intel_pstate: set stale CPU frequency to minimum")
>> Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
>> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
>> Signed-off-by: Jing Wu <realwujing@gmail.com>
>> ---
>>  drivers/cpufreq/intel_pstate.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index 5a0eeb84d3821..b2c60c4931dcd 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -2908,8 +2908,23 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>  		 */
>>  		intel_pstate_clear_update_util_hook(policy->cpu);
>>  		intel_pstate_set_pstate(cpu, pstate);
>> +
>> +		/*
>> +		 * Report the exact pinned frequency instead of the floor:
>> +		 * the CPU is pinned to pstate here and nothing else changes
>> +		 * it, unlike the general case below.
>> +		 */
>> +		policy->cur = pstate * cpu->pstate.scaling;
>>  	} else {
>>  		intel_pstate_set_update_util_hook(policy->cpu);
>> +
>> +		/*
>> +		 * Keep policy->cur within limits here: outside of the pinned
>> +		 * CPUFREQ_POLICY_PERFORMANCE case above, it is never updated
>> +		 * by the intel_pstate driver, but it is used as a stale
>> +		 * frequency value.
>> +		 */
>> +		policy->cur = policy->min;
>>  	}
>>  
>>  	if (hwp_active) {
>> @@ -2922,11 +2937,6 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>  			intel_pstate_clear_update_util_hook(policy->cpu);
>>  		intel_pstate_hwp_set(policy->cpu);
>>  	}
>> -	/*
>> -	 * policy->cur is never updated with the intel_pstate driver, but it
>> -	 * is used as a stale frequency value. So, keep it within limits.
>> -	 */
>> -	policy->cur = policy->min;
>>  
>>  	mutex_unlock(&intel_pstate_limits_lock);
>>  
>> 
>> ---
>
> Good idea overall, but it takes a bit more to do this.  In particular, the HWP
> case needs some more care.
>
> Also, I don't think that this really is a fix.  The code works as intended,
> although what it does is sometimes confusing.

Yes, and by agreement at the time (or so I think I recall) we
were trying to get all CPU frequency scaling drivers and governors to
display the same thing when the frequency was stale.
We wanted to: 1, make it more obvious that the frequency was stale;
2, keep the listed stale frequency within the currently set limits.
The drivers were intel_pstate (with both HWP enabled and disabled),
intel_cpufreq (with both HWP enabled and disabled), and acpi-cpufreq.
We decided on the currently set minimum CPU frequency.

There was a problem with driver = intel_cpufreq, governor = schedutil,
HWP enabled, where it would might not show the current minimum
frequency as the stale frequency, that remains to this day.
(i.e. I have never figured out a fix after my initial attempt was rejected, [1])

> Below is my version of this change (on top of linux-next), please let me know
> if it works for you.
>
> Thanks!

I was part way through looking at and testing Jing's version of the patch.
I'll abandon that and try yours.

... deleted the rest ...

[1] https://lore.kernel.org/linux-pm/CAAYoRsU2=qOUhBKSRskcoRXSgBudWgDNVvKtJA+c22cPa8EZ1Q@mail.gmail.com/

... Doug


