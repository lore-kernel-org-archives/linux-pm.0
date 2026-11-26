Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700954;
	b=1DHbvvLlHTLpfFkEzEwAOXnSf/2WZRg7ujc+dYWHJrx3d6UTJ7giiKXPvRFfErIhbzI3
	 NrYxkk1Ix/cF4+3SGz67B1MmNHMRy2yz+XxYpMJcyDgBARlLJMiW9/xBiCEdARtBM+yeZ
	 WIo8QGQHC/w6JkZeV22fZA/csmfTFQTMPAP4IAEfKF7eGXia2i1hY3ZE/5yt9IVdP/IkB
	 t7PtRRYASUTYIM297/yiRiWIBc1Hh9TxQO5sGaBfKjO7zDWaJC/9FS/ARj4FaP0dXcFJ+
	 A977Cl7nh4DXm4N4sDZbYjs0Lj884V5kUnRJVXOMk5idG3aUbZwNgaNnnJH/Eb3JxwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=abQVRWaWyiTm6hUoXCzZ1KjvGKpnnRPAgTgJRVUoJB8=;
	b=o0Xpzov9fzhCkjJ9xj+ngaLVzKIdn1QQl+vDC/gF9flxvuu7x5fsj+LvPHaupwApjD+z
	 GSQ/6x9wS+ELPcdvFA242RDi7Np4/n4ILki6T2wrANt7TGlxhvFcEwLMBgK12LIxB9da9
	 5scAV5s5OS9NBjaHvrhVR/xjjz2d/GpUFVYeXHRVyD2PjMRh6cWvMnCna/xjcYr98cFUU
	 MD6PJeeoW2EGTddD+5YvKPjMpnIron20nPMpQTh2nV+MnRXD2BWz5KJ/uRoxG32390XTO
	 P+m09ALGqraaJKAsruyGjwF17tiN5F3JD0GARfUCW96p/zmSe+2v48toMlELPEpTtvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wy74fzNf;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E8606A326
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24E8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wy74fzNf
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38190551625so13644059eec.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700953; x=1796305753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abQVRWaWyiTm6hUoXCzZ1KjvGKpnnRPAgTgJRVUoJB8=;
        b=Wy74fzNfYiiW/ZD4Ae02UZl4OkxY7noXb+FIksDvlC8uepBGgoECpni3coEXewvBoG
         Ykyn5fkHj0u1sdpAiRVTBGfJB5qlpTmuleoEwUNliIzgJxznnnnjgPkI3WURudl3ahI9
         2vtNF6qSxzdYn7E1A0/q+CsHSEk+uagEsNm8ORCsHEtGk9dBxsyOQrVkglBiTr0UHPXm
         M/ohxrRe1K5zCfmmf+cpLiNU/RRcBt39EjBS4AbeT35D2KYvnqBx4vf7jGdpCf0kDqlM
         ar9FgO1SDUzel0JoopDrG+HMvRC0Vy6BJ1UshUBySKqzfyE5kT7/4L83M2k7uq2piVLS
         bpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700953; x=1796305753;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abQVRWaWyiTm6hUoXCzZ1KjvGKpnnRPAgTgJRVUoJB8=;
        b=Lt8u245/ayytIJQ8eFD18Qy5Pg+Bxiy72BywMWLFHVV3MYSYOsEdLcAN797Q62Xkuc
         8+4b/HTzo8QCyWsHZRPWSo+X4eMrOFUu/C/TOBAEL9d4KpLgDPcz+prXr6D1/vplElec
         sjofK/pHDqT1Q4I/yHTvQX+AVueUdrsNI6Wm20NXdYMV76W4mL8VzQR4Aj6Gn1Z+KjBD
         8hQN9XHLCa/qfhiVVaSgdGb82c1bJSTpb1f2n5QrXG8el20EJDDOh0pxO7OmF4LI+L/q
         ut36AdILHXMZaOhYmKpjKKSIQiR0rtY1dK8neTaYBBjB4CpAxy0larhPf81o1Pqz2QUv
         maQA==
X-Gm-Message-State: APuU4Z9zGPghZgbg5K5X7Bz6WGgHhtuG0c6YLrlmAgX5J2KY6kV0Ooue
	Iuxesrc1UoCmbu5UJIsGycsLeBAym5DY3z+45aL/deCSklnga0OGAnmX
X-Gm-Gg: AZFdTZeBhGW0GFbNYfO269cQoeMBedx6GNtnu0SB8noH9V3qm7sa7rHF4Yj/gijVySW
	78VpQFXA+M0xVYOqQglbl6PL7IAmV8rsIS4DXy7j3X5QOUyNosT+1sZBLqIcPbvN3gqOrnFD2ID
	o3zbPBPRjCYPdVuAzxXQ1HZMmlNQN+xQBs0YPi7z/eHRV8AFtK+ZejR0iT2jxPTYzLlH0OGw4G4
	ry+M4lPylPF96UO3Prz63SnrSydKogPUxQAVlYNRhJ5wZLxkmqXyz2Q5VZusock4Z5xhUWGn6fP
	aWaWRqipDUrGoEko0D+Vbnt9NCol9nUdLBsbo7ZKRQR//CddU/lm0CCJaBDvjSAqhl0Yl5Ij00q
	wi/DzdeZt0sXc+jWVVHtyWS20yY+7ReQBqRVudBNTxP6ifxZZGFf/A0bmarsBEt0pntv6586d5P
	tbGi1o6ozl+rCt95Mi/ZZpqPbqDPnxRh/LCeuVBCaCza+u3E64V3XUW4z3SKqB2m8BQVvso2NUe
	9pef6R9hBZKcb9Vwg8itbeqzOfnt4THMGrozbWX7JTtj1LXIVa0lyUuOCEiYpCOog0PKv6nnfC8
	lGC6rCDobne+RM/ARF9feV0Zs2t57qOlIztDU5yEzb2CLyK4nFXcLLDlrW21/GjYlGk0
X-Received: by 2002:a05:7300:2301:b0:385:4c54:3c8c with SMTP id 5a478bee46e88-3856c0c9403mr30927525eec.1.1795700952814;
        Thu, 26 Nov 2026 05:49:12 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm63023504eec.23.2026.11.26.05.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:49:11 -0800 (PST)
Message-ID: <b9eba3d4-c3c7-495a-ba45-34f993ccac1c@gmail.com>
Date: Thu, 26 Nov 2026 22:49:08 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Resume at the frequency from before
 suspend
Content-Language: ko
To: aiyengar1990@gmail.com, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Jonas Karlman <jonas@kwiboo.se>, Dong Aisheng <aisheng.dong@nxp.com>
References: <20261119-devfreq-suspend-sync-v3-0-ef19fbf94d83@gmail.com>
 <20261119-devfreq-suspend-sync-v3-1-ef19fbf94d83@gmail.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20261119-devfreq-suspend-sync-v3-1-ef19fbf94d83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/2026 6:16 AM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> Since commit 62453f1ba5d5 ("PM / devfreq: Use more accurate returned
> new_freq as resume_freq"), devfreq_set_target() records the frequency it
> sets as resume_freq, so the suspend transition in
> devfreq_suspend_device() overwrites it with the suspend frequency. The
> device then resumes at its suspend frequency and stays there until the
> governor's next update; with runtime PM (e.g. lima on RK3528) that is
> after every idle period.
> 
> Keep the frequency from before the suspend transition as resume_freq.
> 
> Fixes: 62453f1ba5d5 ("PM / devfreq: Use more accurate returned new_freq as resume_freq")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f25304bca37f..795a01d012ec 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1144,6 +1144,7 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>   */
>  int devfreq_suspend_device(struct devfreq *devfreq)
>  {
> +	unsigned long resume_freq;
>  	int ret;
>  
>  	if (!devfreq)
> @@ -1161,7 +1162,10 @@ int devfreq_suspend_device(struct devfreq *devfreq)
>  
>  	if (devfreq->suspend_freq) {
>  		mutex_lock(&devfreq->lock);
> +		/* devfreq_set_target() overwrites resume_freq; keep the pre-suspend one */
> +		resume_freq = devfreq->previous_freq;
>  		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
> +		devfreq->resume_freq = resume_freq;
>  		mutex_unlock(&devfreq->lock);
>  		if (ret)
>  			return ret;
> 

Looks good to me. 
I'll add Cc: stable@vger.kernel.org and wrap the comment line when applying.

Applied it. Thanks.
-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
