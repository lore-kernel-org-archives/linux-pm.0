From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 1/2] intel_pstate: Add setting voltage value for baytrail
 P states.
Date: Wed, 18 Dec 2013 16:03:53 -0800
Message-ID: <52B237E9.5050903@gmail.com>
References: <1387302127-7614-1-git-send-email-dirk.j.brandewie@intel.com> <1445568.VWz2v5WUSg@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36915 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3LSAD5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 19:03:57 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so348565pdj.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2013 16:03:56 -0800 (PST)
In-Reply-To: <1445568.VWz2v5WUSg@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, Dirk Brandewie <dirk.j.brandewie@intel.com>

On 12/18/2013 04:37 AM, Bartlomiej Zolnierkiewicz wrote:
		val |= (u64)1 << 32;
>> +
>> +	vid_fp = mul_fp(cpudata->vid.min +
>> +			int_tofp(pstate - cpudata->pstate.min_pstate),
>> +			cpudata->vid.ratio);
>
> Shouldn't this be:
>
> +	vid_fp = cpudata->vid.min + mul_fp(
> +			int_tofp(pstate - cpudata->pstate.min_pstate),
> +			cpudata->vid.ratio);
>

Yes thx

> ?
>

