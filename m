Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FE33BBD0;
	Tue, 17 Mar 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735214; cv=none; b=tgJqwd0S1bFixaIXLJDbC0HZZMhiWODb1yFVM3wgH3oY+1F7dNmsq69A7+okQKVpGe00H6hFhoNeEk4kkAj5rKRt8gQIB3o47XQx49gAUScs5GipAFujGqz0uzLD22Q8SZcVttU0ZPVQAPFQQng0jID7ofEwjrda7adMhou+UVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735214; c=relaxed/simple;
	bh=uvspNaXpu2J9/Nm1bv0JR0kACgTIE5+q6aLY/vaB27Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N3UEqA8wLvd9Hi5DblXsaJYBKsrObqdi9n265IEiCPNCT1liWdLXT6k533iawKcfc4VRpVZe5fWnrQB9eH660Jq1+Vf4uhnACE8bjpsGonFN/N5qi1rd92kyjZpOJKD/5z/VrwhK3TO+B537pzIzx2imOhBveWCNGJj2nZEFpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MbgqYM2Q; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MbgqYM2Q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=07n5Pz4vbldw3q/pwQeqfyxCuDvs2DcVZZCaO5nShUc=;
	b=MbgqYM2QMTNgPULm1iOWCJT4WP8onQWpa/wx6EkjamAh3Bb1e65TrxX7eaA/lJ9i5UsP2hkHV
	3A64SIbYbKrNlgDgaS5wPmfSaSlnbdUysptxA8+x/LMMc33Acd8UfNvNFcZwljI1f+Hsew9QWqx
	fc4qhmN3LhzIRX2bRDWmqME=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fZl2g6B5Xz1prQB;
	Tue, 17 Mar 2026 16:08:27 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 097E34056A;
	Tue, 17 Mar 2026 16:13:29 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:13:28 +0800
Message-ID: <023bc3c2-29cf-4b52-ac72-4e82c2efe4d2@huawei.com>
Date: Tue, 17 Mar 2026 16:13:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
To: Viresh Kumar <viresh.kumar@linaro.org>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>
 <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/12/2026 6:27 PM, Viresh Kumar wrote:
> On 10-03-26, 21:17, Zhongqiu Han wrote:
>> Thanks for the patch. The fix looks correct to me for the reported
>> issue. I do have one question though - should we also consider the
>> interaction with commit abb6627910a1 ("cpufreq: conservative: Fix
>> next frequency selection")?
> 
> Thanks for pointing this, I missed this change.
> 
>> However, that change was subsequently reverted by commit abb6627910a1
>> ("cpufreq: conservative: Fix next frequency selection"), which noted
>> that using policy->cur directly broke the algorithm when freq_step is
>> small relative to the distances between available frequencies. In that
>> case, the governor may not be able to stay within a narrow range
>> between two consecutive available frequencies and instead jumps through
>> steps faster than intended.
> 
> Its the opposite I think. The governor stays within a range and never
> goes to a higher or lower frequency. This is how I think this happens:
> - Lets say frequencies are from 1GHz to 2GHz with a gap of 200 MHz.
> - Lets say the frequency is 1 GHz now and the step size is 100 MHz.
> - conservative governor will try to change the freq to 1.1 GHz and end
>   up selecting 1 GHz only (due to CPUFREQ_RELATION_H, highest freq
>   below 1.1 GHz).
> - With my patch, we will keep resetting to 1 GHz (cur freq) and never
>   change freq.
> - With a recorded requested_freq, we will move to 1.1 GHz (actual 1
>   GHz), but a subsequent call will go for 1.2 GHz.
> 
> Here is another idea, once everyone agrees I can send this formally:
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index e0e847764511..df01d33993d8 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_policy *policy)
>         dbs_info->requested_freq = policy->cur;
>  }
> 
> +static void cs_limits(struct cpufreq_policy *policy)
> +{
> +       struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
> +
> +       /*
> +        * The limits have changed, so may have the current frequency. Reset
> +        * requested_freq to avoid any unintended outcomes due to the mismatch.
> +        */
> +       dbs_info->requested_freq = policy->cur;
> +}
> +
>  static struct dbs_governor cs_governor = {
>         .gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
>         .kobj_type = { .default_groups = cs_groups },
> @@ -322,6 +333,7 @@ static struct dbs_governor cs_governor = {
>         .init = cs_init,
>         .exit = cs_exit,
>         .start = cs_start,
> +       .limits = cs_limits,
>  };
> 
>  #define CPU_FREQ_GOV_CONSERVATIVE      (cs_governor.gov)
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 36eb7aee4bcd..acf101878733 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
> 
>  void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>  {
> +       struct dbs_governor *gov = dbs_governor_of(policy);
>         struct policy_dbs_info *policy_dbs;
> 
>         /* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
> @@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>         mutex_lock(&policy_dbs->update_mutex);
>         cpufreq_policy_apply_limits(policy);
>         gov_update_sample_delay(policy_dbs, 0);
> +       if (gov->limits)
> +               gov->limits(policy);
>         mutex_unlock(&policy_dbs->update_mutex);
> 
>  out:
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 168c23fd7fca..1462d59277bd 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -138,6 +138,7 @@ struct dbs_governor {
>         int (*init)(struct dbs_data *dbs_data);
>         void (*exit)(struct dbs_data *dbs_data);
>         void (*start)(struct cpufreq_policy *policy);
> +       void (*limits)(struct cpufreq_policy *policy);
>  };
> 
>  static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)
> 
> 

I tested this patch on our platform, and the behavior is as expected, too.

Tested-by: Lifeng Zheng <zhenglifeng1@huawei.com>

