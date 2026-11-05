Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848200;
	b=H7P/OvlMopWSkC2MghQNu0E8+wv3kLSd1WloQkiW91h0V0wau/FgHQuUPGMmstCiKIRH
	 n8P41NPOr5ybw2exCV72ev+4l7AKF67ms/wLv7YwMtKCM30eyQrFg4ZS1rrcoWSk0xtGr
	 Vu4UMW0xd96TO8UAZpQ3Wt9akTMtw2h7EdkaupVR2S/7tLp+fxmZoAUHoc36EDN6sZ781
	 KNLmbNLQA70sI2kOWlvEX33RJiAst0qyXoF5bZXKGrp8RP/zzVZHfVx9FUGA/CnLEHgXM
	 pW7HVXpOy6WVe7CcZJz0lvrO5rT8FHFGmzP7RPIFURoWbxZi4Qozuv1MR3akcoV8HIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848200;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=lJwxCodrMvoIlziA4T20l3RHTNmdgNEQuVY0nf0TPRY=;
	b=IorM/0ubMVERe8RzdNYPA+vqJDuWy8y1vlT3kMCU/NfW/8CL3YLG7aSx3j9FKCjgDSUy
	 OSkiK/0NBWOZ8BO43g8c0tUfs/53oo7TYoM3ToJpPBsnqfxNrDE60QLDOz+GI3nuZF7g3
	 wwg2ygsQZQPFECU62BL1pHAGyXrx9d2osRi4c3amF0Wy/pT0uOEg58VrQAgYBDbhyFV4Q
	 Q3YUS+bblyupjRlfyMLdefCHJBZ4uYty9/IZmSypr7jbscRp1bBuIOQ9PY3bdf+3xSdoa
	 ivxY93x4pBvuT4ZXH1l6JbUGYzsttOvCFyd9hI7WZnPiKjKbtwMljfwPk/wC6XrfFwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SK10VClE;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8553606A31B;
	Thu,  5 Nov 2026 03:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8553606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SK10VClE
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lJwxCodrMvoIlziA4T20l3RHTNmdgNEQuVY0nf0TPRY=;
	b=SK10VClE/qDx6P0Hkp6NBUaWt53fqxodULEIwg1NEkTZS8+iXFJuR8umpjFo4qv5egcqwIMIH
	6LMA35JoTZTbdfPcDlOO/P4gPOC6o1uOU1m3vm7M36NpcfKlBawACqkws9TTlNYlZ/6v6CwbJjv
	vtUu46X4yBIi5nN6XsXnqXs=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jKnNY6b2dz1prLY;
	Thu,  5 Nov 2026 11:09:49 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id EC6F440575;
	Thu,  5 Nov 2026 11:09:54 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 11:09:54 +0800
Message-ID: <0eec150c-b8e6-45ee-b6b2-30fd97f72539@huawei.com>
Date: Thu, 5 Nov 2026 11:09:53 +0800
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
Subject: Re: [PATCH] cpufreq: Preserve global boost state on failed updates
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sumit.gupta@nvidia.com>, <zhanjie9@hisilicon.com>, <superm1@kernel.org>
References: <20261104161657.546370-1-christian.loehle@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <20261104161657.546370-1-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 11/5/2026 12:16 AM, Christian Loehle wrote:
> cpufreq_boost_trigger_state() restores the opposite of the requested
> state when updating policy boost state fails. For example, a failed
> write of 0 when global boost is already disabled enables the global
> flag without enabling any policies.
>
> Save the original global boost state using a mutex and restore it on
> failure.
>
> Fixes: 121baab7b88e ("cpufreq: Force sync policy boost with global boost on sysfs update")
> Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> On a platform without boost_supported the unfixed behaviour is:
> # cat /sys/devices/system/cpu/cpufreq/boost
> 0
> # echo 1 > /sys/devices/system/cpu/cpufreq/boost
> echo: write error: invalid argument
> # cat /sys/devices/system/cpu/cpufreq/boost
> 0
> # echo 0 > /sys/devices/system/cpu/cpufreq/boost
> echo: write error: invalid argument
> # cat /sys/devices/system/cpu/cpufreq/boost
> 1
>
>   drivers/cpufreq/cpufreq.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..d95c849f79c5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2810,18 +2810,24 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>   
> +static DEFINE_MUTEX(cpufreq_boost_mutex);
> +
>   static int cpufreq_boost_trigger_state(int state)
>   {
>   	struct cpufreq_policy *policy;
>   	unsigned long flags;
> +	bool boost_enabled;
>   	int ret = -EOPNOTSUPP;
>   
> +	guard(mutex)(&cpufreq_boost_mutex);
> +
>   	/*
>   	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
>   	 * make sure all policies are in sync with global boost flag.
>   	 */
>   
>   	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	boost_enabled = cpufreq_driver->boost_enabled;
>   	cpufreq_driver->boost_enabled = state;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   
> @@ -2841,7 +2847,7 @@ static int cpufreq_boost_trigger_state(int state)
>   		return 0;
>   
>   	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -	cpufreq_driver->boost_enabled = !state;
> +	cpufreq_driver->boost_enabled = boost_enabled;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   
>   	pr_err("%s: Cannot %s BOOST\n",
Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
