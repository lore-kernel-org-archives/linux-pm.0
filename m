Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766219;
	b=kYgICm2RWXX60hn2k6PC8AMo85o1pyvZd/8JForVLCrHUIWHy6rFEr0MeQk+1hkVnvX/
	 72QqoVmwDqNSzemYsBLbPf9HrkI7YMB8pjvl7HSEuL7uhF05/sbtpvDvghw66WQHapxjB
	 gS0eB/+HItRnYeAm2TwXqbRpA7R+Uy30EV5Jj4/ZryBrfEiEPXLLMOo5eSvPXhKPvdh8V
	 KY5z6RTOBQlvMoB3/Zcb/2JO9MrdtseSTZk94F0B0n2llsFtYfSxkCMeZrUiJ446mb0ch
	 3WiOS+XOT/+j6YLJUTLTAUUwP5j2xjbQSBwXflptdb53HDFI854nQQm/YfTKRuIAw6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766219;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iU2cAE+xYO/XnMnj0sK7wZQrb/1tZMsmaB1KYuOpEh8=;
	b=fP3MGLDqEhHui4obybYP6DtrVnT+LbYAD2pPyqiphKXZonwDHwYXWoM/McJVGrbu1sri
	 M/JWv/dEhrEfKe9/xtCMfyoCIeMlHWZjCidZ+8mXHaXeGSQTnK4FmKNzH6Tht1Dv5zB41
	 svjsk0GlumX3mo506+vrtcbaciQ+pcmMpxLShSwNTpkfAedyZyPdPh6F62wYc9ocI7Fx6
	 LlZ9+pA2XEne7fbGdQBXc1lGZjiTWXHMo4Xeusi2ze/7KeKzsslowvyTVMfu8cjVw8IlO
	 S5WdT6jnoQMxYBaBEv2JbAlkVuHjKP1EOF3wB1L+U2J6td0JUkWyY0Hdh+HAaDMuTDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DP1Z9LQE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90D606A31E;
	Fri, 27 Nov 2026 07:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B90D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DP1Z9LQE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DB991758;
	Thu, 26 Nov 2026 23:56:54 -0800 (PST)
Received: from [10.57.17.186] (unknown [10.57.17.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 979A63F632;
	Thu, 26 Nov 2026 23:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795766217; bh=PrA/UIWGkZfLu7/VDanfK31U4E5RWlHDG7b/xeQiNTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DP1Z9LQE621aQtGwlP0u5SgfbO1qyP/dYvlgXX2JfS6jNVxWT8FZV9uDp7JLmFcpG
	 AGLsDPG69rVS7cq9rCQgqexON/XjnqJnYJBjDilZzD9r2UNJijyCFdS7dlVmkQDUmw
	 063AiYrsPJ8sEtmQrX+8mFn3oxS+qdFuOg8Cx2JU=
Message-ID: <5bb03d26-f912-4c15-80c2-c070c40cafd0@arm.com>
Date: Fri, 27 Nov 2026 07:57:30 +0000
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
Subject: Re: [PATCH] thermal: thermal_of: fix OF node leak in
 thermal_of_for_each_cooling_device()
To: zhaofeng2@cmss.chinamobile.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20261127074225.1798-1-zhaofeng2@cmss.chinamobile.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261127074225.1798-1-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/26 07:42, zhaofeng2@cmss.chinamobile.com wrote:
> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> 
> thermal_of_for_each_cooling_device() calls of_parse_phandle()
> to obtain tr_np, uses it only to call of_find_trip_id(), and
> then leaks it on every subsequent return path.
> 
> Drop the reference with of_node_put() once the node is no
> longer needed.
> 
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> ---
> Verified against current tree. Leak found by code inspection
> (OF reference-counting audit of thermal_of_for_each_cooling_device()).

This function doesn't exist anymore. I has been removed with
94c6110b0b13c64161

> 
>   thermal/thermal_of.c | 1 +-++
>   1 file changed, 1 insertion(+), 0 deletion(-)
> 
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -365,6 +365,7 @@
>   		return -ENODEV;
>   
>   	trip_id = of_find_trip_id(tz_np, tr_np);
> +	of_node_put(tr_np);
>   	if (trip_id < 0)
>   		return trip_id;
>   
> 
> 
> 


It's not a valid patch.
