Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FB2580F3
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401584; cv=none; b=XSJId+PPhMWinWIGbreLmrgs1M4JwXVSdXSghv8MrytevBjxSBR4Tk+yKLPaNe6kdmLKO8pslKRdLQSOjGD459Pi+FvfimSCPINIJgeq66UUA6I+rxSMcPYbmrZnvXbUcs8b9kLose7zIRgigRZBMOjeu3jCT/pEnX4rFeApcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401584; c=relaxed/simple;
	bh=JhAZBIgrLIoBTJdOFsRjCM+ogg30PSTlUaL+A+nmBa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1AKR4IbdbtI1kL5YsdOxdnpsZ/mZEgMSlXerlN2604Pwi6hdkgE7AOvajPWlFSaGkF4fTCmNyY7Iz0hUIwNuj0fZFL5LrU6Z1np61SwwQFxOouNTIbUIBCAJvD0N9ci49L2ifnqE54zTlIHE9UToKXDnVFbkUFWp8nOYcJzLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkNKdsNn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkNKdsNn"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c999f162c9aso2444954a12.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 22:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783401582; x=1784006382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SB5C9tyEm3VWD1NE71UelrCRk3oAe90XBNKtY+sIo5U=;
        b=IkNKdsNnsA6+87PuuyWz2MyKcaI9e//E1iZYFy/m/HzDE4SFET2lg7KKKAgLPsPFLd
         2XLF+EcoXpl1HBcjQrqJOYJxYQQeZ0Z5KMAc4wwPkotN6ZUK1APswnLvOzan5K1n7uCo
         YJKA0Zpx01EC+TsyItWNjV1nQqelBtmmPMRFa/iFUECa12FCi3uIvHhtRDBLoj0QyK3r
         dTPMaZE3fZqJ2AvehFvzkRflWbwXd44t/40GqKUd1++95ym41zWDU9zigdtezWl90mrq
         jlOI4S9mU7XrgIutsn3T0bZ6aomKFHu2AGYXTbwjz3iXBKkr4Hl6IfAn4N6OwPEGbluU
         sdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401582; x=1784006382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB5C9tyEm3VWD1NE71UelrCRk3oAe90XBNKtY+sIo5U=;
        b=TtupczZ+je9HX4Rw3m7QHtVIg8TCm+S2mDnEwhkfVxZWdh++wr8pMszeM8R9RR6hPT
         D+9hm7eO0y6OD3ppt/Gduc/tTKweCjdFAfgQmjYEj9f5m/qr2Bc3Tytr0fTLpGhLiCYx
         M0Whh2svuWaWEJCyfRFiy0ig8wmnRcHwT+JV7iBYP0h8Cvf1Kvt8lX3GzlBnVKdTZY5x
         zhVfxIZiNgK/pf/3VrAn3HjnJMNX0I90rfsQGtj2bUM2eSYHcwzhW/hWpRtrw5q87Jr0
         sLSdizBAgUaUP5YC0VtesW5+j7VZ1H9RoygsYdlOdnTi30poQaQSIDeuS8KnUigZOh2e
         WSrg==
X-Forwarded-Encrypted: i=1; AHgh+RpuO1uTyKPS3V0WrWsUXyD0G5nwbMUR1qafGlaTk/Iq+g2+cpoREkItC2HMJK4Juv/UfF2Ix1xTvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKk8DA+DrlxQGjJxqnkNC360IZaLXqWN8bhaEpZtPOkZCeY91R
	FpZPQEbXtNmpsD8Wn6JjVHsLGCkzUmati40bWzQaIS7/NQnx86DPdMuYsCb5Jea2Eck=
X-Gm-Gg: AfdE7cm+vnIWsBADy6/7JA2/QWWJRI7p6UkxVSYIzbfbeecEbsQYk5ZoRGD48qYiHVP
	gtATxiYXXt+k4SmUas+vMPefn+zDOsf3v9qvBQViV8y1UneBdKzgPhe4f1SY8wRjcCYE8uD3qzh
	IGshQdMakTjRuj2OXEzO+CQAGD2NF3GSJlbxCzxVajO8SH7NjMl86PdOTZ84YIrfMlNvDUipvEA
	487OyMbZibqftwU03A1DIXioaOWJ99G3VC/p3N+r9bgnwLbkEIOIX3MxFbWVJkC1idD6mTNRi6X
	Xb0bCTW0mG2ApmV+ClUHlnLkZe8hv+dUxFxFDZ5qepsGNeBU3zf6GpUAAsB7wNw1SkOyQjaqqCT
	KUnsW92xOo1QG/Jh4j94x24akDzJsX3r9lUNpoJCpiybhKJO0Wt62bgn2OqxN2q4Q9peF6/P9b6
	jKEZsNc8bDpSog
X-Received: by 2002:a05:6a20:1443:b0:3bf:c0f8:32f2 with SMTP id adf61e73a8af0-3c08edb21b0mr4344429637.18.1783401582172;
        Mon, 06 Jul 2026 22:19:42 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac0557sm4380324eec.26.2026.07.06.22.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:19:41 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:49:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yiwei Lin <s921975628@gmail.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: cpufreq: Backup and restore governor for
 sptests
Message-ID: <qtcyti7hqhr5sgzkhp2rt6h4kh3lfxmgjx5spi4nn7il63ckvl@woiclsimqqqh>
References: <20260706161430.16949-1-s921975628@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706161430.16949-1-s921975628@gmail.com>

On 07-07-26, 00:14, Yiwei Lin wrote:
> After executing cpufreq sptest, the system governor
> will be overwritten with the governor switched
> during the test. Restore this setting to maintain
> consistency before and after the test.
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>  tools/testing/selftests/cpufreq/governor.sh   | 21 +++++++++++++++++++
>  .../selftests/cpufreq/special-tests.sh        | 13 ++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/cpufreq/governor.sh b/tools/testing/selftests/cpufreq/governor.sh
> index fe37df79c0871..5d105ab9c9222 100755
> --- a/tools/testing/selftests/cpufreq/governor.sh
> +++ b/tools/testing/selftests/cpufreq/governor.sh
> @@ -16,6 +16,12 @@ source cpufreq.sh
>  CUR_GOV=
>  CUR_FREQ=
>  
> +# Per-policy backup, keyed by policy so multiple policies can be saved at once
> +# (backup_governor/restore_governor also keep CUR_GOV/CUR_FREQ for callers that
> +# read them directly).
> +declare -A SAVED_GOVERNORS
> +declare -A SAVED_FREQS
> +
>  # Find governor's directory path
>  # $1: policy, $2: governor
>  find_gov_directory()
> @@ -39,11 +45,13 @@ find_current_governor()
>  backup_governor()
>  {
>  	CUR_GOV=$(find_current_governor $1)
> +	SAVED_GOVERNORS[$1]=$CUR_GOV
>  
>  	printf "Governor backup done for $1: $CUR_GOV\n"
>  
>  	if [ $CUR_GOV == "userspace" ]; then
>  		CUR_FREQ=$(find_current_freq $1)
> +		SAVED_FREQS[$1]=$CUR_FREQ
>  		printf "Governor frequency backup done for $1: $CUR_FREQ\n"
>  	fi
>  
> @@ -53,11 +61,13 @@ backup_governor()
>  # $1: policy
>  restore_governor()
>  {
> +	CUR_GOV=${SAVED_GOVERNORS[$1]}
>  	__switch_governor $1 $CUR_GOV
>  
>  	printf "Governor restored for $1 to $CUR_GOV\n"
>  
>  	if [ $CUR_GOV == "userspace" ]; then
> +		CUR_FREQ=${SAVED_FREQS[$1]}
>  		set_cpu_frequency $1 $CUR_FREQ
>  		printf "Governor frequency restored for $1: $CUR_FREQ\n"
>  	fi
> @@ -65,6 +75,17 @@ restore_governor()
>  	printf "\n"
>  }
>  
> +# Save/restore governors for every policy at once
> +save_all_governors()
> +{
> +	for_each_policy backup_governor
> +}
> +
> +restore_all_governors()
> +{
> +	for_each_policy restore_governor
> +}
> +
>  # param:
>  # $1: policy, $2: governor
>  __switch_governor()
> diff --git a/tools/testing/selftests/cpufreq/special-tests.sh b/tools/testing/selftests/cpufreq/special-tests.sh
> index 8d40505dc4682..c7eddadd047d1 100755
> --- a/tools/testing/selftests/cpufreq/special-tests.sh
> +++ b/tools/testing/selftests/cpufreq/special-tests.sh
> @@ -40,7 +40,9 @@ simple_lockdep()
>  {
>  	printf "** Test: Running ${FUNCNAME[0]} **\n"
>  
> +	save_all_governors
>  	for_each_policy __simple_lockdep
> +	restore_all_governors
>  }
>  
>  # Test 2
> @@ -56,7 +58,10 @@ concurrent_lockdep()
>  {
>  	printf "** Test: Running ${FUNCNAME[0]} **\n"
>  
> +	save_all_governors
>  	for_each_policy_concurrent __concurrent_lockdep
> +	wait
> +	restore_all_governors
>  }
>  
>  # Test 3
> @@ -68,17 +73,23 @@ quick_shuffle()
>  		echo ondemand | sudo tee $CPUFREQROOT/policy*/scaling_governor &
>  		echo userspace | sudo tee $CPUFREQROOT/policy*/scaling_governor &
>  	done
> +	wait
>  }
>  
>  governor_race()
>  {
>  	printf "** Test: Running ${FUNCNAME[0]} **\n"
>  
> +	save_all_governors
> +
>  	# run 8 concurrent instances
>  	for I in `seq 8`
>  	do
>  		quick_shuffle &
>  	done
> +	wait
> +
> +	restore_all_governors
>  }
>  
>  # Test 4
> @@ -112,5 +123,7 @@ hotplug_with_updates_cpu()
>  
>  hotplug_with_updates()
>  {
> +	save_all_governors
>  	for_each_non_boot_cpu hotplug_with_updates_cpu

Don't you need wait here too ?

> +	restore_all_governors
>  }


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
