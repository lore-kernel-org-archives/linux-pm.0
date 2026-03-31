Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF527FB05;
	Tue, 31 Mar 2026 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940704; cv=none; b=q0QHsgOWsIVX+n0kcUeWF5xMsb6iN+pVM14yjhOg8Vxsj/L2agNpxqz1tub3B6I+x9yV3me26+q0KNk4lk7z3Kah0/CYj6edbg0CMIH0onBxFIxgjIssuiAoZFVBEC23YCvVEVLBEpgHrVb9v1A/36GAe5UcpBaxBJQ7IMSeSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940704; c=relaxed/simple;
	bh=FbTiUjSH7L5wSNITVkpkgcbD5oNt9662DZqKjZIH1fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XwdL82DZ1IES72f/2CQh7FV4dLq1sEozvo6z5+OYEMa828oy9bfFUQdx+toOnbwAgLHVyX0wN8WQ/2O2g4A2zdKcTUoA/DzSeXUJz7ajRwC0PcMGjmRzvRHJx5OGrRCq8gOQ6x1keEJW/LORWEe7tr8qAsIT2iycbd1jbkdGBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4flJqp6YSrz1prLH;
	Tue, 31 Mar 2026 14:58:46 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id D6A8B40569;
	Tue, 31 Mar 2026 15:04:58 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 15:04:58 +0800
Message-ID: <f167d24d-73f9-4463-889e-89fb9f1e4a1a@hisilicon.com>
Date: Tue, 31 Mar 2026 15:04:57 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] PM / devfreq: Fix possible null pointer issue
 in devfreq_add_governor()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091653.1005878-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260319091653.1005878-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/19/2026 5:16 PM, Yaxiong Tian wrote:
> When a user removes a governor using devfreq_remove_governor(), if
> the current device is using this governor, devfreq->governor will
> be set to NULL. When the user registers any governor
> using devfreq_add_governor(), since devfreq->governor is NULL, a
> null pointer error occurs in strncmp().
> 
> For example: A user loads the userspace gov through a module, then
> a device selects userspace. When unloading the userspace module and
> then loading it again, the null pointer error occurs:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000010
> Mem abort info:
> ESR = 0x0000000096000004
> EC = 0x25: DABT (current EL), IL = 32 bits
> *******************skip *********************
> Call trace:
> __pi_strncmp+0x20/0x1b8
> devfreq_userspace_init+0x1c/0xff8 [governor_userspace]
> do_one_initcall+0x4c/0x278
> do_init_module+0x5c/0x218
> load_module+0x1f1c/0x1fc8
> init_module_from_file+0x8c/0xd0
> __arm64_sys_finit_module+0x220/0x3d8
> invoke_syscall+0x48/0x110
> el0_svc_common.constprop.0+0xbc/0xe8
> do_el0_svc+0x20/0x30
> el0_svc+0x24/0xb8
> el0t_64_sync_handler+0xb8/0xc0
> el0t_64_sync+0x14c/0x150
> 
> To fix this issue, modify the relevant logic in devfreq_add_governor():
> Only check whether the new governor matches the existing one when
> devfreq->governor exists. When devfreq->governor is NULL, directly
> select the new governor and perform the DEVFREQ_GOV_START operation.
> 
> Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 54f0b18536db..63ce6e25abe2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1288,23 +1288,21 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>  		int ret = 0;
>  		struct device *dev = devfreq->dev.parent;
>  
> -		if (!strncmp(devfreq->governor->name, governor->name,
> +		if (devfreq->governor && !strncmp(devfreq->governor->name, governor->name,
>  			     DEVFREQ_NAME_LEN)) {

Probaly do:
if (!devfreq->governor)
	continue;
so as to keep the line short and the "else if (!devfreq->governor) {" below
can be removed.

and also:
if (!strncmp(devfreq->governor->name, governor->name,
	DEVFREQ_NAME_LEN))
	continue;
so we don't have to indent that much.

>  			/* The following should never occur */
> -			if (devfreq->governor) {
> +			dev_warn(dev,
> +				 "%s: Governor %s already present\n",
> +				 __func__, devfreq->governor->name);
> +			ret = devfreq->governor->event_handler(devfreq,
> +						DEVFREQ_GOV_STOP, NULL);
> +			if (ret) {
>  				dev_warn(dev,
> -					 "%s: Governor %s already present\n",
> -					 __func__, devfreq->governor->name);
> -				ret = devfreq->governor->event_handler(devfreq,
> -							DEVFREQ_GOV_STOP, NULL);
> -				if (ret) {
> -					dev_warn(dev,
> -						 "%s: Governor %s stop = %d\n",
> -						 __func__,
> -						 devfreq->governor->name, ret);
> -				}
> -				/* Fall through */
> +					 "%s: Governor %s stop = %d\n",
> +					 __func__,
> +					 devfreq->governor->name, ret);
>  			}
> +		} else if (!devfreq->governor) {
>  			devfreq->governor = governor;
>  			ret = devfreq->governor->event_handler(devfreq,
>  						DEVFREQ_GOV_START, NULL);
