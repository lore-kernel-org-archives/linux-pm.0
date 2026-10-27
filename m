Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119016;
	b=IpJVo+1WfvbuepC5vhdtj8VjTicV2hAvdiARdOMg4bb/yCX+jI7XfuLX5rA86+38MhXp
	 AUHXvyiZcNoI5m4TL3C3iMk8/F0eVh9O45e5Jare1kyWVk4kfaEfICdR8MPrBxSE0GJ9q
	 WUHZnMhPUJN7M+66B3s7WDbXpbg3mrW8tsN+xzasKY/sx/zQFfUcyUU5N8t4hUvbyZz1M
	 QzvGeL7h3mk1H6dT+CtnnJHZqhGiWak0tFXCh4AF80NnmMS/FsfTn25CK5HLDcO+VY1jf
	 sXyDNfIqbeEW8NT1pX7xaUCsxMR/6yUt8s8s+RD07Ft6wU/Airw5gNWYFPr1fOzUAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 Content-Language:Thread-Index;
	bh=DgyxaXcpCEgbpB6+0qEWI5ndWEratI/KZGAOF1/cwnc=;
	b=anP66ibYyQXDeKVtPhS2K0Lk8qqO5/dMZftpwhNQgjLf4w/w3lNLFJCdztfacQX5o/zy
	 aR/q9THYvumTfA2fuaI4/Qyr376stJpWeghofLrKWju7iXTLAnKWRjYNAa1/T1ZucPkF1
	 RTFa8sD8OiHRbUS60mbKuDoD1PD4eGvHaVm/Lkpjq3RSyBMeUW9UnkdXPo7+ObfEs5CMj
	 rUzOGdvCkEkWxK4hetRJf1ZzpHbeOUOEOLWDnGvLDXBT4EljeIB497mq+WqpAZAMZXsZK
	 6G1iCepEHJwRJTv20zZWApMe9MHwmCUTzx3nNYOCsritIyRmvA/7Txry/1U8crmrPYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telus.net;
	spf=pass smtp.mailfrom=telus.net;
	dkim=pass header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=dXf3FYtH;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5ED606A330
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5ED606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=dXf3FYtH
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd3310348d2so553958a12.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1793119016; x=1793723816; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgyxaXcpCEgbpB6+0qEWI5ndWEratI/KZGAOF1/cwnc=;
        b=dXf3FYtHi6EApSS+succvYZUloGyMtcGm4itBNRUej+p2wUz1PdvJWyWBnHlS7IXyW
         Wvwc+7ohJcYWd7giLzyglW+KZ8S+dVpgaikh7JwqEQS9g3EF/eYF3mWEp89abTEdlQIT
         55iceKE5kDWXGvUrjlfoFiFN1aCibgH9B5n3IIqpxZ4f5t6nnq+OfOlK5UzK4GQ82KFv
         htE1xuXoMEYndJO5bmTbKpUTfY/6vCeF7IQsGi9sN6UOjSVxVAMTcwzseyF3yLhVEevY
         UTH19XCQvW+efQsT+IH822A968wBB8gp1u6h8vMAuqyZaOFNMTNQOn9tVIt9Ry3lvHIJ
         V2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119016; x=1793723816;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DgyxaXcpCEgbpB6+0qEWI5ndWEratI/KZGAOF1/cwnc=;
        b=d3oR9B7xUi+nDwpOT+SwQXjwFx9dgwMg97dcm2bJyS2pTJi9VHxBXifYPNYkYQqs9e
         oMcBhK4rL6Oo5JHHakEPqSXLwV7UDqBHUjMf1mqAnOrosbHHYpRs1sPfGNC0Qdxat2eT
         4uS7yX1jErHGIsKq51KG+Dxszq4uCdAc6Y89Rpn+xqBG6qph+sKqtQbGL4DQZQFwe93F
         sfzj1f5vgUFRFHgx8L+ES+fEnEMhbrMLfSN5FxC/mi/jpxg+oTo77+Vfe4485GDDKGgp
         nNYcIk+zDSbNiq4rcOYHT0aQl9uB9qorH6znuBMvoP4bAyrndB9PEgjh+0kSYxiFSkGa
         dcbg==
X-Forwarded-Encrypted: i=1; AKwUvBxys+urucWRYXOgzYc8ln1vsp3+fj6hq/FQdvfDLYgyg58vvfop1htzlcIvwb4NMD8nwoqUwpD6hQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL73R8L3d8bYQTkg2E/pv3WrwjNsytCdNmEYBMR0YHGRl4v1Fql
	hWmtWQcXmCKnShJrEK2hzSvptDz3xlnx8mKy6f9ZRww77nnL1PeT8nYgGDm4e/tNzHc=
X-Gm-Gg: AYBFou34ihk8rZhQ5BSLcbUpprQioNM+cl6d6ENuKxE+BUyctXj53VUl0Pd+E+B0Bu2
	bJF3rk1Ycddo9B37uPYOW9fM0iKMu0S/I099OOxPQM9lfRsVMMpLipY/+MzVlaWYCzoA4lXewf8
	/oHHfA9t7m4/gy2SponU8qR+KM2ebWsZc78WORp5GRK00LQRlpiypCDjEoFoELH9hdrY03sH2Vl
	26dARzhJjumk17PRDh95zMrSUQSdiD/TIfM8kl5m+0D6u+ZLXtDA4Z3qddEVmYNJJ8WIcV0unO/
	7cTwqGqDoD9Dok4LyeWWrgJNMZIiDM2CTFNY/zyVaPM4xkFfpwUYGSD4NnEq8XrNxx4p8/6cTrN
	EjASty+6tygS+GPjkTm67NzygvQeJwVm+4LXgSYwdcHxIQVH6KkKNatNJLHlNkAzo17tQcnX/7i
	uPNjB7BpCii4vN5yoqG9YlyfnxMVGrNoShi0qZVjY1zsJeA8gyPrW1XBIR4nxclvegdOIGfQlrp
	vmYG0VIERxQi2lO8Gms/1/nxQYbt8If8oo6xNi0C1LjTH/SvVnDFKIiFAAbJfk=
X-Received: by 2002:a17:90b:582f:b0:3a6:e159:a229 with SMTP id 98e67ed59e1d1-3ae40443725mr1880815a91.49.1793119015745;
        Tue, 27 Oct 2026 09:36:55 -0700 (PDT)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc90d74sm3015675a12.20.2026.10.27.09.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:36:55 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Zak'" <zakbrightonknight@gmail.com>,
	<linux-pm@vger.kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc: "'Len Brown'" <lenb@kernel.org>,
	"'Viresh Kumar'" <viresh.kumar@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
In-Reply-To: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Tue, 27 Oct 2026 09:36:55 -0700
Message-ID: <001101dd6631$6167dbd0$24379370$@telus.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+ka4iSAouj32QbdBtcmCOlo9WerdPO5KA

On 2026.10.27 07:37 Zak Brighton Knight wrote:

> From: Zak Brighton Knight <zakbrightonknight@gmail.com>
>
> On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
> the CPUs stop using turbo after every suspend to RAM when intel_pstate
> is in passive mode with the performance governor: they stay at the
> 2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
> policy limits change or the system is rebooted.
> 
> During resume, the firmware sets each CPU's P-state request register,
> MSR_IA32_PERF_CTL, to the base ratio (28), and the kernel never writes
> the requested turbo ratio (38) again.  Without hardware-managed
> P-states (HWP), intel_pstate caches the last P-state it wrote and
> skips writes that would not change it.  In passive mode the cpufreq
> core also skips requests for the frequency it believes is already set
> (policy->cur), because intel_cpufreq sets CPUFREQ_NEED_UPDATE_LIMITS
> only with HWP.  Neither cached value is updated across suspend and
> resume, so as long as the governor keeps requesting the same P-state,
> as the performance governor always does, the register is never
> rewritten.  Governors that change the request often, such as
> schedutil, mostly hide the problem.
>
> Fix this by writing the cached P-state back to the register in
> intel_pstate_resume() when HWP is not used, as is already done for
> the HWP request when it is.
>
> The problem was found and root-caused, and this patch was drafted, with
> the help of an AI coding assistant (Claude, by Anthropic) during a
> performance review of the machine described above.
>
> Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
> ---
> Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
> with v7.3 plus this patch and a temporary module parameter, not part
> of this patch, to turn the fix off.  intel_pstate.c is the same in
> v7.3 and in the base commit below.
>
> Each row is one suspend to RAM and resume (rtcwake -m mem -s 25).
> "Request" is the P-state read back from PERF_CTL on all eight CPUs
> 5 and 17 seconds after resume; "clock" is the measured speed of a
> single-threaded busy loop.  Before every suspend, all CPUs requested
> 38 and the clock was about 3.8 GHz.
>
>  mode     governor     fix  request after resume  clock
>  passive  performance  on   38 on all CPUs        3.8 GHz
>  passive  performance  off  28 on all CPUs        2.8 GHz
>  active   performance  off  38 on all CPUs        3.8 GHz
>  active   performance  on   38 on all CPUs        3.8 GHz
>
> The passive-mode failure was also reproduced twice on Fedora's 7.2.11
> kernel.  In active mode the request was back at 38 after resume even
> without the fix, so on this machine the fix only makes a difference in
> passive mode, the default without HWP.
>
> Not tested: systems with HWP (their code path is unchanged, only
> restructured), other machines and firmware, and suspend-to-idle.  The
> patch adds no warnings with W=1; sparse was not run.  The tests were
> scripted and run by the same AI assistant.
>
> drivers/cpufreq/intel_pstate.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 17158cb..53db91a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1371,6 +1371,7 @@ static void set_power_ctl_ee_state(bool input)
>  }
> 
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata);
> +static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate);
> 
>  static void intel_pstate_hwp_reenable(struct cpudata *cpu)
>  {
> @@ -1404,11 +1405,20 @@ static int intel_pstate_resume(struct cpufreq_policy *policy)
>  	else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
>  		set_power_ctl_ee_state(false);
> 
> -	if (cpu->suspended && hwp_active) {
> +	if (cpu->suspended) {
> 		mutex_lock(&intel_pstate_limits_lock);
> 
> -		/* Re-enable HWP, because "online" has not done that. */
> -		intel_pstate_hwp_reenable(cpu);
> +		if (hwp_active) {
> +			/* Re-enable HWP, because "online" has not done that. */
> +			intel_pstate_hwp_reenable(cpu);
> +		} else {
> +			/*
> +			 * PERF_CTL may have been changed by the platform
> +			 * firmware, but it is only written when the requested
> +			 * P-state changes, so restore it explicitly.
> +			 */
> +			intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate);
> +		}
> 
> 		mutex_unlock(&intel_pstate_limits_lock);
> 	}
>
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> -- 
> 2.56.0

I confirm your findings and tested your proposed patch. It all worked fine.
I had not seen Rafaels's reply about a possible race condition until now.

Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.

... Doug


