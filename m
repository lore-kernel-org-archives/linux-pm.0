Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C936B047;
	Mon, 23 Mar 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262640; cv=none; b=Ja2w8ESxvnoHHV7jfDt9d+A9yAxqpST2eEbNnPJUwVsGHSXTp6KNaQWqbJxvleEFo0ZACfYKeCgQG9Hycq+Bzk1VqBNCS1R+ZFbrQADlJUrWz+TSuG+FSWSp1LRRXrGqrHsUDbPO1gMexVzi4t5bNcd8lpLkcLy/CHXOqJAlaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262640; c=relaxed/simple;
	bh=IHTGS4rTsLwIC4Aj3avB8zo9FqBfJN+5IEuIttqR5RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEzXR2whLAgFIKH9pjAITYZ127MjwDpwRXKjI+0EKFt9Zd2AsiORKsAsuO0mRwRtL6SBHOYGP+w7jBEG73pBJUcYVrM4EUHj+PKNG8l3MyEBLBQPVI7Y6GTkV/2wgPsfAsU1XsKvA/IbJ/LM7l5K3VTKzi2URu9cAoI74FqVG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B1A41516;
	Mon, 23 Mar 2026 03:43:53 -0700 (PDT)
Received: from [10.57.17.171] (unknown [10.57.17.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3B8B3F73B;
	Mon, 23 Mar 2026 03:43:57 -0700 (PDT)
Message-ID: <d46ef894-ff62-4493-bd17-660004640eca@arm.com>
Date: Mon, 23 Mar 2026 10:44:09 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: devfreq_cooling: avoid unnecessary kfree of
 freq_table
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: rui.zhang@intel.com, daniel.lezcano@kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20260323094018.2264-1-mohd.abd.6602@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260323094018.2264-1-mohd.abd.6602@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/26 09:40, Anas Iqbal wrote:
> dfc->freq_table is only allocated in the non-EM path via
> devfreq_cooling_gen_tables(). In the EM path, it remains NULL.
> 
> Avoid calling kfree() unnecessarily when freq_table was never allocated.
> 
> This resolves a Smatch warning:
> calling kfree() when 'dfc->freq_table' is always NULL.
> 
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> ---
>   drivers/thermal/devfreq_cooling.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 597e86d16a4e..1c7dffc8d45f 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -472,7 +472,8 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>   remove_qos_req:
>   	dev_pm_qos_remove_request(&dfc->req_max_freq);
>   free_table:
> -	kfree(dfc->freq_table);
> +	if (!dfc->em_pd)
> +		kfree(dfc->freq_table);
>   free_dfc:
>   	kfree(dfc);
>   

LGTM, let's calm down that warning.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
