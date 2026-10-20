Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508609;
	b=RsnVM+epEtoFN6vWyDcHvH9dzanf+dNNh2ngmj068NrK49af0YIEGm0PUVI7KjS+KjCV
	 TIK3FMLKip1mf4l8FhSIXDJqTfEenrz/Zb8QYKeyxRQlcQAEu+jNAdszN+MdOocYzg1Ku
	 7UuvL89RN6Zj3LSSADBBPfOCho3Ar94OCdCmvzXhMKPhapnWlEfJ9NLAWSXCVFZiDJcLM
	 7KvMlN6BYooMaQHBYESlQsmp5/e/6kXX5jRbzOlzBepfCg8ykhRoRunweT0HSOIHLZ0zQ
	 X1+jwlen827J6gVw9C+JFbYVwwx5sSMyAnpgDitk6CXxJbW38YkQ9VgHclWym4rCFuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508609;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RqANyPBVKb1V6pHlRKt3NQ6Ocz+jeVWfCBZGSbiTll8=;
	b=s69FqjeMkRf9dIM486XgcnGtkkFrdQLUD5A3yObYxnL/CDSnNovo9wfMFhrQ1e0K/Hro
	 OHhJggkYkLT+7a42/iTZLbVcP6iaFzlphHFALSC6OClDJprPlVlodqpOgS+EmXMvWQpZq
	 mnhGjVrUv+yiCqQtqUrJKeVK1F25sIvGgXh+gSkGOFVnmKR9Dl7OQpHXUpd1M4WRgokOl
	 Vxz5ifB4+vkxsW0Mh25QMtZUtPAZeZrq/picKnGk7LEBUlz2WtARVow/VRqz9GPp1Nxib
	 jm+S79J+8IKNYNdrzgCIr3PN1bhSuZR86GCbNNYcxmsU0nJYkgqo87YpW8lrtfH+iyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="dwa2/2mp";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BF606A31D;
	Tue, 20 Oct 2026 15:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 718BF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dwa2/2mp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD12A16F8;
	Tue, 20 Oct 2026 08:03:18 -0700 (PDT)
Received: from [10.0.128.106] (e127648.arm.com [10.0.128.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3E7B3F7B4;
	Tue, 20 Oct 2026 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792508602; bh=exlXZ5LNhGnN6GWf37HBftprwysKrWdhPAxWVsVZnGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dwa2/2mpL1Ht/iQN5zB71Zivd5y3oivwHNR7BaVDIjpFi1bTiqQV2LEY60nxyV6a+
	 2THIUWRIDDYXSkn93LRt1nOfPCTAWVNx1fE+8NZ6xbeMyw4Fn3Evrq5qFQzCaf6Cwu
	 btZ5Wxg37QmxwMhfOPy3El60uQDPX3N1uqM38r9U=
Message-ID: <19c334e2-267f-4b85-8eaf-40e23259c961@arm.com>
Date: Tue, 20 Oct 2026 16:03:18 +0100
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
Subject: Re: [PATCH] cpuidle: psci: Do not log probe deferral as an error
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261020-cpuidle-defer-v1-1-c86e0d450b4f@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261020-cpuidle-defer-v1-1-c86e0d450b4f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 15:26, Loic Poulain wrote:
> psci_cpuidle_domain_probe() reports every failure with pr_err(),
> including -EPROBE_DEFER. dt_idle_pd_init_topology() returns that
> whenever a parent domain is not registered yet, which is a normal and
> recoverable condition, so an otherwise successful boot still logs an
> error:
> 
>   CPUidle PSCI: failed to create CPU PM domains ret=-517
> 
> Report the failure with dev_err_probe() instead, which downgrade
> -EPROBE_DEFER to a debug message while still logging genuine errors.

s/logging/returning/?

> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

in any case:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b9e4ad7d43a3310a76ce62018dff0af1488e33d2..aa73a2fa14b3af4d1e3edd607e058ba96132bad7 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -173,8 +173,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  	dt_idle_pd_remove_topology(np);
>  	psci_pd_remove();
>  exit:
> -	pr_err("failed to create CPU PM domains ret=%d\n", ret);
> -	return ret;
> +	return dev_err_probe(&pdev->dev, ret, "failed to create CPU PM domains\n");
>  }
>  
>  static struct platform_driver psci_cpuidle_domain_driver = {
> 
> ---
> base-commit: f49a343b305c0b6c19a3b50c0bbf10bcd0e2e8fd
> change-id: 20261020-cpuidle-defer-4e6184bef223
> 
> Best regards,

