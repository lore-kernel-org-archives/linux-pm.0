Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A83C4332F
	for <linux-pm@archiver.kernel.org>; Fri, 14 Oct 2022 09:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJNJrA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Oct 2022 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJNJq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 05:46:59 -0400
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA11C2EA7;
        Fri, 14 Oct 2022 02:46:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1080127|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.017724-0.0126778-0.969598;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=kant@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.PcAxJcE_1665740811;
Received: from 192.168.220.136(mailfrom:kant@allwinnertech.com fp:SMTPD_---.PcAxJcE_1665740811)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 17:46:54 +0800
Message-ID: <7cfeafef-519d-b6e7-77fb-bd5e611faf71@allwinnertech.com>
Date:   Fri, 14 Oct 2022 17:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] devfreq: governor: Add a private governor_data for
 governors in devfreq
Content-Language: en-US
To:     Chanwoo Choi <cwchoi00@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010072202.78731-1-kant@allwinnertech.com>
 <00ed0b46-54db-330e-8ff8-146ff9a09491@gmail.com>
 <abc402b1-1253-fe94-94c4-afb1dfb9aebd@gmail.com>
From:   Kant Fan <kant@allwinnertech.com>
In-Reply-To: <abc402b1-1253-fe94-94c4-afb1dfb9aebd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/13/2022 3:19 AM, Chanwoo Choi wrote:
> 
> In addition, the devfreq driver pass the 'data' from devfreq driver
> to governor by using devfreq_add_device. I think that 'devfreq driver'
> is more proper
> 
> * @data:	devfreq driver pass to governors, governor should not change it.
> 
> And then, there are extra changes required.
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 63347a5ae599..0c59b7978391 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -776,8 +776,7 @@ static void remove_sysfs_files(struct devfreq *devfreq,
>    * @dev:       the device to add devfreq feature.
>    * @profile:   device-specific profile to run devfreq.
>    * @governor_name:     name of the policy to choose frequency.
> - * @data:      private data for the governor. The devfreq framework does not
> - *             touch this value.
> + * @data:      devfreq driver pass to governors, governor should not change it.
>    */
>   struct devfreq *devfreq_add_device(struct device *dev,
>                                     struct devfreq_dev_profile *profile,
> @@ -1011,8 +1010,7 @@ static void devm_devfreq_dev_release(struct device *dev, void *res)
>    * @dev:       the device to add devfreq feature.
>    * @profile:   device-specific profile to run devfreq.
>    * @governor_name:     name of the policy to choose frequency.
> - * @data:      private data for the governor. The devfreq framework does not
> - *             touch this value.
> + * @data:      devfreq driver pass to governors, governor should not change it.
>    *
>    * This function manages automatically the memory of devfreq device using device
>    * resource management and simplify the free operation for memory of devfreq
> 

Dear Chanwoo,
Thanks for your kindly advice. I've modified it as patch-v3 [1]. Please 
have a look.

[1] 
https://lore.kernel.org/all/20221014094359.100995-1-kant@allwinnertech.com/

-- 
Best Regards,
Kant Fan
