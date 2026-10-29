Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256307;
	b=YzMVwb2Jt1p1AjCRrdXoZ47n/etiEsWFfs2pJ7nb1Re8+xUKetn6eyaCnvSLgGwFL46x
	 /iQtA6rY6wpQE7XxezPI/mwo8bYxa3nmFMxEDj1Op5rh8dsTZ+ByAUPeDe5zlNkswP9sw
	 iGIPFIo3O3SVBMts5e38i6Kiz7rvYeHVx0zCl0jYd3k3nePO4TuME52qOThh5mcP238w8
	 ld3DzKUJxZoTzYthMjgCKrvcu6om9UVJ1YdeM9b7MGnWKNWhQD8W1BEAnPPyMHOeuDsSe
	 z+nacYDAncI4YeQ/kF+2gjsqzZXqjpmd/2ofkVsc2diL8tnoVUuCTR3VqmrwHnFL8TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256307;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=4beEnSSDjYlacVLVyK+pNpsq6dloyN3BCH/sftoRCws=;
	b=QPvlf9KNSjt/PGwj5HZtgJjZQF7sqq0CxSG35BPR19NqxIBTuoOuccU7tdFXRPhakjAB
	 MD8xvR6xIm6Gmv1Jagvbq1oVE30XzrI80HO30v/aAdU0AueUrOpXrpPG1lyGHNIoPFYRw
	 jE+tgUZ0p3epojoscvG0ZCETInrcSEljHPKOwIXskcf5DPIisGo8Fv4DkmgwtNDJeYmj3
	 haXL+dViKbvOzNBEVHdQI2Gf4N8jep4tuAIgnzK1kSri0ljFgAtLI9u4rDekwkaEhRTBD
	 5aQaf/qj5Xm80AsHO0qLzHbzeQAFUF/VekKhWhTSmKU8Xfa1YHJV2hRKgwm99ldRzEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RoZWO1Qj;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE0606A31C;
	Thu, 29 Oct 2026 06:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RoZWO1Qj
Received: from [10.94.176.171] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id C271520B7168;
	Wed, 28 Oct 2026 23:44:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C271520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793256294;
	bh=4beEnSSDjYlacVLVyK+pNpsq6dloyN3BCH/sftoRCws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RoZWO1QjfFHOcHrc3AEzAOTSzZgUNuwwMMjoN0CmiyWKqkm3zphhYbOgzImuBKiQ4
	 VUKcCjRqDEmg67BWlyyCYVgA1Q3nSslMxUP9gCNS6Hbu4jPuJNtbKIhP7tNwyrcjz6
	 lujz1vLlO9iKDs9Q0idLsEL9F1SxU6DtwXH/6l9M=
Message-ID: <11334849-52a2-4a4f-b656-e3cfa7f04565@linux.microsoft.com>
Date: Thu, 29 Oct 2026 12:15:00 +0530
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
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261020-cpuidle-defer-v1-1-c86e0d450b4f@oss.qualcomm.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20261020-cpuidle-defer-v1-1-c86e0d450b4f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Loic,

On 20-10-2026 19:56, Loic Poulain wrote:
> psci_cpuidle_domain_probe() reports every failure with pr_err(),
> including -EPROBE_DEFER. dt_idle_pd_init_topology() returns that
> whenever a parent domain is not registered yet, which is a normal and
> recoverable condition, so an otherwise successful boot still logs an
> error:
> 
>    CPUidle PSCI: failed to create CPU PM domains ret=-517
> 
> Report the failure with dev_err_probe() instead, which downgrade
> -EPROBE_DEFER to a debug message while still logging genuine errors.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/cpuidle/cpuidle-psci-domain.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b9e4ad7d43a3310a76ce62018dff0af1488e33d2..aa73a2fa14b3af4d1e3edd607e058ba96132bad7 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -173,8 +173,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>   	dt_idle_pd_remove_topology(np);
>   	psci_pd_remove();
>   exit:
> -	pr_err("failed to create CPU PM domains ret=%d\n", ret);
> -	return ret;
> +	return dev_err_probe(&pdev->dev, ret, "failed to create CPU PM domains\n");
>   }
>   
>   static struct platform_driver psci_cpuidle_domain_driver = {
> 

Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

> ---
> base-commit: f49a343b305c0b6c19a3b50c0bbf10bcd0e2e8fd
> change-id: 20261020-cpuidle-defer-4e6184bef223
> 
> Best regards,


Thanks,
Prasanna Kumar
