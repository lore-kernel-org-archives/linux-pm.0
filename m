Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324661A704B;
	Tue, 25 Aug 2026 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623254; cv=none; b=jL3PdXrE9/2CX/RCEez3yEiJkWdrefHWzl3zahIws0bvaT0pVIRjtRhmdx92rkAv+jqC6Jkh29irE9QIptefv5Gc1MgUvHEO2LWVapxOmhJGvEbXmzfmUGXX3CzZeXgUZGtmOFDDv9biszveaiD7pJJ0p1nIiBUx7HT0fFBftGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623254; c=relaxed/simple;
	bh=guMQe8VhuUcx6ei2ldcPojriHPJXPEJIpjG3ME4KyDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mA3x1pKFJxu9Eg1e6yjeJmzXYWz57quw8P8l3Lx6lwpNvvlpopsRfG1FXZRFPsRny9cDjP9gFth4z3NdKAgmePvd6kTnpJB/LH2xMtqBfejavhgYr+Z+t1V6P0QQReJxyHDRgvR5BqvSlYEsIXmKq3kads0aNjb20XtUM5nFMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=09S7TYJR; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="09S7TYJR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eYNpA1Cjg66vAxWKuNBevFxzrmWfEW5RTnkNOKHT9Lo=;
	b=09S7TYJRR1spigIQyapTYNO3i1aTuoityuW2zcGz++GJZJQF7Eyieq6o3XkABKDLxiVJVrBPU
	SoDrMECSup+394btecfKJ/Ylk8UQWlet+lzsl2GSMdohwO47sZ6dNWeGU4GmiL7tXsZ5flRceTH
	g8m58xRMV+c84F5uR3U9hZA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hTW2B1SyqznTxv;
	Tue, 25 Aug 2026 09:50:26 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 676B64057A;
	Tue, 25 Aug 2026 10:00:41 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 10:00:40 +0800
Message-ID: <5fe88f15-3164-4a9b-b490-334e91ad7644@huawei.com>
Date: Tue, 25 Aug 2026 10:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Unblock runtime PM when device prepare
 fails
To: Shibo Zhu <3499129952@qq.com>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
	<dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>, <linux-pm@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <tencent_C5AC0A02FC01F700E764F8C2E3ECE4F41009@qq.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <tencent_C5AC0A02FC01F700E764F8C2E3ECE4F41009@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 8/19/2026 12:18 AM, Shibo Zhu wrote:
> device_prepare() blocks runtime PM for a device with runtime PM disabled
> before invoking its system-sleep ->prepare() callback. For a device that
> has never enabled runtime PM, this changes dev->power.last_status from
> RPM_INVALID to RPM_BLOCKED.
>
> If the callback returns an error, dpm_prepare() does not move the device
> to dpm_prepared_list. Consequently, the recovery path through
> dpm_complete() never calls device_complete() for the failing device.
>
> The error path drops the runtime PM usage reference, but does not clear
> RPM_BLOCKED. A later legitimate pm_runtime_enable() then reports:
>
>    Attempt to enable runtime PM when it is blocked
>
> before clearing the stale state.
>
> Call pm_runtime_unblock() on the prepare error path before dropping the
> runtime PM reference, matching the cleanup performed by device_complete().
>
> The issue was reproduced with a platform test device whose ->prepare()
> callback returns -EIO while runtime PM has never been enabled. Before
> the fix, last_status remained RPM_BLOCKED after the failed suspend and
> the first pm_runtime_enable() produced the warning above. With the fix,
> last_status is restored to RPM_INVALID and the warning is absent.
>
> Fixes: 3e5eee147b7b ("PM: Block enabling of runtime PM during system suspend")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Assisted-by: ChatGPT:GPT-5.6 Sol
> Signed-off-by: Shibo Zhu <3499129952@qq.com>
> ---
>   drivers/base/power/main.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f71467f6ada4..4ed2e9b7e99b 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -2234,6 +2234,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>   
>   	if (ret < 0) {
>   		suspend_report_result(dev, callback, ret);
> +		pm_runtime_unblock(dev);
>   		pm_runtime_put(dev);
>   		return ret;
>   	}

LGTM.

Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>

> base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
