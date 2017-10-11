From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 6/8] PM / devfreq: Remove unneeded conditional
 statement
Date: Wed, 11 Oct 2017 11:36:35 +0000
Message-ID: <20171011113635epcms1p5d6597fdf6a6091737f43adba5c5daf50@epcms1p5>
References: <1507691364-3899-7-git-send-email-cw00.choi@samsung.com>
        <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030947epcas1p3172d6bb79615a17e08164a150031262e@epcms1p5>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32872 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdJKLgi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 07:36:38 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20171011113636epoutp0165dbecc181944eb1dfe7cd6acfe2957e~sgPxdiQz62895828958epoutp01a
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 11:36:36 +0000 (GMT)
In-Reply-To: <1507691364-3899-7-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> The commit 0ec09ac2cebe9 ("PM / devfreq: Set the freq_table of devfreq
> device") initializes the freq_table array of each devfreq device always.
> In result, it is unneeded to check whether profile->freq_table is NULL
> or not.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 3b9662ffe603..b28810cae7ee 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -315,10 +315,9 @@ int update_devfreq(struct devfreq *devfreq)
>  	freqs.new = freq;
>  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>  
> -	if (devfreq->profile->freq_table)
> -		if (devfreq_update_status(devfreq, freq))
> -			dev_err(&devfreq->dev,
> -				"Couldn't update frequency transition information.\n");
> +	if (devfreq_update_status(devfreq, freq))
> +		dev_err(&devfreq->dev,
> +			"Couldn't update frequency transition information.\n");

To make this commit really safe,
in this commit, please make devfreq_set_freq_table to return error
and let add_device fails when it returns error.

In the current code, we cannot guarantee that there will be
freq_table and trans_table available when it hits this line.

Cheers,
MyungJoo

>  
>  	devfreq->previous_freq = freq;
>  	return err;
> -- 
> 1.9.1
