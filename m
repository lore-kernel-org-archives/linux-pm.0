Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C7C4167D
	for <linux-pm@archiver.kernel.org>; Wed, 23 Nov 2022 14:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiKWOsp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Nov 2022 09:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiKWOsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 09:48:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7C6E553;
        Wed, 23 Nov 2022 06:48:36 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHPB45PChzHw46;
        Wed, 23 Nov 2022 22:47:56 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 22:48:33 +0800
Subject: Re: [PATCH] thermal/of: Fix memory leak in thermal_of_zone_register()
From:   xiujianfeng <xiujianfeng@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221123143325.183870-1-xiujianfeng@huawei.com>
Message-ID: <1c39e64f-6691-eb58-fcad-59f16ac2e6ec@huawei.com>
Date:   Wed, 23 Nov 2022 22:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20221123143325.183870-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sorry, it seems someone already sent fix patch, ignore this.

ÔÚ 2022/11/23 22:33, Xiu Jianfeng Ð´µÀ:
> In the entry of this function, it has allocated memory by kmemdup() and
> save it in @of_ops, it should be freed on the error paths, otherwise
> memory leak issue happens, fix it.
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   drivers/thermal/thermal_of.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index d4b6335ace15..95d3da9051c4 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -604,13 +604,15 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>   	if (IS_ERR(np)) {
>   		if (PTR_ERR(np) != -ENODEV)
>   			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
> -		return ERR_CAST(np);
> +		ret = PTR_ERR(np);
> +		goto out_kfree_ops;
>   	}
>   
>   	trips = thermal_of_trips_init(np, &ntrips);
>   	if (IS_ERR(trips)) {
>   		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> -		return ERR_CAST(trips);
> +		ret = PTR_ERR(trips);
> +		goto out_kfree_ops;
>   	}
>   
>   	ret = thermal_of_monitor_init(np, &delay, &pdelay);
> @@ -659,6 +661,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>   	kfree(tzp);
>   out_kfree_trips:
>   	kfree(trips);
> +out_kfree_ops:
> +	kfree(of_ops);
>   
>   	return ERR_PTR(ret);
>   }
> 
