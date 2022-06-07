Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444EAC43334
	for <linux-pm@archiver.kernel.org>; Tue,  7 Jun 2022 13:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbiFGNQx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiFGNQv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2022 09:16:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BD9F33BE;
        Tue,  7 Jun 2022 06:16:51 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHW7Q1L39zjXR9;
        Tue,  7 Jun 2022 21:15:30 +0800 (CST)
Received: from [10.174.178.212] (10.174.178.212) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 21:16:48 +0800
Subject: Re: [PATCH -next] power: supply: ab8500: add missing
 destroy_workqueue in ab8500_charger_bind
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sebastian.reichel@collabora.com>,
        <gregkh@linuxfoundation.org>
CC:     <gaochao49@huawei.com>
References: <20220512093844.1109923-1-zhengbin13@huawei.com>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <b507def7-df79-79e2-844d-41763a989d47@huawei.com>
Date:   Tue, 7 Jun 2022 21:16:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20220512093844.1109923-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.212]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

friendly ping

On 2022/5/12 17:38, Zheng Bin wrote:
> ab8500_charger_bind misses destroy_workqueue in error path,
> this patch fixes that.
>
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>   drivers/power/supply/ab8500_charger.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
> index d04d087caa50..a5d055a628e7 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3378,6 +3378,7 @@ static int ab8500_charger_bind(struct device *dev)
>   	ret = component_bind_all(dev, di);
>   	if (ret) {
>   		dev_err(dev, "can't bind component devices\n");
> +		destroy_workqueue(di->charger_wq);
>   		return ret;
>   	}
>
> --
> 2.31.1
>
> .
>
