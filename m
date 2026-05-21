Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DA395AC0
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350804; cv=none; b=fDZluwpLtbNL4sNh0tOFAcPirNBAxogZUjkR3VkvgbORwWM7B7EKUBfirEDpdhjM4Yp6iILNTnLx/Z0QYALyXs1Fhowj1b52w3t6K0tkWEFWeii0jp8UEv9Y5qTZYHxaQVgt9tpvu3iW/4PWFhg/2VTyRBf9n2SHA00YeUBTakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350804; c=relaxed/simple;
	bh=i9cp5IYOt2CpCFxMUt6dWzj2fN6UKxcj91XyctT2P+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AYkO93UdHcR1K6RwiHZUCVdd4QMPONRx7sRUqFFaYUy13hf10X14NsJdJ58+P4mYO1xHXQK0Forxk/OZpCch8zRrEA88mXF6fG0MveLxSlkaEcDCDLDJ8JKdmiLHz9a03koRMvLh/ajVBGjPrYl3iOqGwGuQFLtIR+Ad0xM5alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TSNNapNB; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TSNNapNB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/SoalNNKO1spLRzAIXn5OOTFcvvlQyTKSuUb8a531F0=;
	b=TSNNapNBajMBhYedLA2x/rJ1f/g2V5QCsEKPcXFvz3BSsGxgFupUNFVsiYJdZ7hEPttoMbQxv
	QId/x0scSJHTxyXCgslGs8+zMb2xzSfH3motBZ+Hh7KY5Shbvbk5r8L1Suomv/tKf8V/oxZIZg7
	vNwwaniwABE60Ktjs34NJCc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gLglb3z6MzLlTk;
	Thu, 21 May 2026 15:58:51 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D6C740565;
	Thu, 21 May 2026 16:06:33 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 21 May
 2026 16:06:32 +0800
Message-ID: <fdc3886e-7e5b-46e3-a1c9-48e2c2b596c9@huawei.com>
Date: Thu, 21 May 2026 16:06:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] devfreq: Factor out devfreq_set_governor()
To: Jie Zhan <zhanjie9@hisilicon.com>, <cwchoi00@gmail.com>,
	<cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20260519113251.3745140-1-zhanjie9@hisilicon.com>
 <20260519113251.3745140-4-zhanjie9@hisilicon.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260519113251.3745140-4-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 5/19/2026 7:32 PM, Jie Zhan wrote:
> governor_store() and devfreq_add_device() contain similar logic for setting
> a governor when devfreq->governor is NULL.  Merge this into a common
> function, devfreq_set_governor(), to reduce code duplication and unify the
> entry of setting governors.
> 
> This also prepares for further changes that get / put a module refcount of
> the active governor and prevent the governor module from being unloaded
> while it's in use.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/devfreq/devfreq.c | 117 ++++++++++++++++++--------------------
>  1 file changed, 56 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 53c40d795a13..9e3e6a7348f8 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -318,6 +318,59 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  	return governor;
>  }
>  
> +static int devfreq_set_governor(struct devfreq *df,
> +				const struct devfreq_governor *new_gov)
> +{
> +	const struct devfreq_governor *old_gov;
> +	struct device *dev;
> +	int ret;
> +
> +	lockdep_assert_held(&devfreq_list_lock);
> +
> +	old_gov = df->governor;
> +	dev = &df->dev;
> +
> +	if (old_gov) {
> +		if (old_gov == new_gov)
> +			return 0;
> +
> +		if (IS_SUPPORTED_FLAG(old_gov->flags, IMMUTABLE) ||
> +		    IS_SUPPORTED_FLAG(new_gov->flags, IMMUTABLE))
> +			return -EINVAL;
> +
> +		/* Stop the current governor */
> +		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
> +		if (ret) {
> +			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> +				 __func__, df->governor->name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Start the new governor */
> +	df->governor = new_gov;
> +	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +	if (ret) {
> +		dev_warn(dev, "%s: Governor %s not started(%d)\n",
> +			 __func__, df->governor->name, ret);
> +
> +		/* Restore previous governor */
> +		df->governor = old_gov;
> +		if (!df->governor)
> +			return ret;
> +
> +		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +		if (ret) {
> +			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
> +				__func__, df->governor->name, ret);
> +			df->governor = NULL;
> +			return ret;
> +		}
> +	}
> +
> +	return sysfs_update_group(&df->dev.kobj, &gov_attr_group);

Here is a little problem which is not introduced by this patch. When
starting new governor fails but restoring old governor succeeds, this
function will return 0. This might lead users to believe that the governor
has been successfully modified.

