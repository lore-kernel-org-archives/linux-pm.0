Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BD3B19C5;
	Thu,  2 Apr 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127787; cv=none; b=fr3JXaDJBblHb92esYIWx2TkJOJ//BzqGzRXv6PZ5pRg+SKhOxbTY0cgkHbU3wy/WKysGVAx0pOW0oltyOjO2J6od2KDYkRj5zA3JHB8u7yDINQ9I0ROkIT4AbDUcVdIj9ezkXuW7CJxnkOepmgt2tQXkJ/CtPI1Pb9Qs2DRRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127787; c=relaxed/simple;
	bh=3UTdHgS/lubEnGGLdPnYjVo1jf8EBQnES+q5NnB/EfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEmBAbsBoJg29YB6EwSi0AA8ADcEuSN+XKqKLFmBCVKljkyWFuImbX4ft9ZIu4Yb0o/uBMKKQKOqYPT25Bw/nqvrnuBRZypI4aSvBBM17MEBmDoEefomjTub/rsxTrGZX5qD2bBFIQjgCzTp74H5ClnJrxcRiiSIkF283PHX8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r6FZr+QC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r6FZr+QC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79EDA2C43;
	Thu,  2 Apr 2026 04:02:58 -0700 (PDT)
Received: from [10.57.21.221] (unknown [10.57.21.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F41CD3F641;
	Thu,  2 Apr 2026 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775127784; bh=3UTdHgS/lubEnGGLdPnYjVo1jf8EBQnES+q5NnB/EfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r6FZr+QC01BKSCoW2nlux0KPqQKxualO5tBTJetIByJe4LwkLJhDbluNUxgCZbbqd
	 RxTEQwzLtrS/vAKI5gF8djAFLAYmUohXokjdqmh+cWvBctZctY2lRIJqQjEWWsqHtO
	 rB76O+bxyQvOeHSEJIafbx7bv3v9rEKODRCyo8XA=
Message-ID: <bdd8684b-9ce8-4c7a-b27c-a2d67b29367c@arm.com>
Date: Thu, 2 Apr 2026 12:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Remove pointless variable when registering
 a cooling device
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org,
 Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL"
 <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260402084426.1360086-1-daniel.lezcano@kernel.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260402084426.1360086-1-daniel.lezcano@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/26 09:44, Daniel Lezcano wrote:
> From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> The 'id' variable is set to store the ida_alloc() value which is
> already stored into cdev->id. It is pointless to use it because
> cdev->id can be used instead.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> ---
>   drivers/thermal/thermal_core.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index b7d706ed7ed9..02ce58223f9f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1061,7 +1061,7 @@ __thermal_cooling_device_register(struct device_node *np,
>   {
>   	struct thermal_cooling_device *cdev;
>   	unsigned long current_state;
> -	int id, ret;
> +	int ret;
>   
>   	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
>   	    !ops->set_cur_state)
> @@ -1078,7 +1078,6 @@ __thermal_cooling_device_register(struct device_node *np,
>   	if (ret < 0)
>   		goto out_kfree_cdev;
>   	cdev->id = ret;
> -	id = ret;
>   
>   	cdev->type = kstrdup_const(type ? type : "", GFP_KERNEL);
>   	if (!cdev->type) {
> @@ -1135,7 +1134,7 @@ __thermal_cooling_device_register(struct device_node *np,
>   out_cdev_type:
>   	kfree_const(cdev->type);
>   out_ida_remove:
> -	ida_free(&thermal_cdev_ida, id);
> +	ida_free(&thermal_cdev_ida, cdev->id);
>   out_kfree_cdev:
>   	kfree(cdev);
>   	return ERR_PTR(ret);


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
