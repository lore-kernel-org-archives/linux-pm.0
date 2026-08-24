Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359A36A37E;
	Mon, 24 Aug 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598926; cv=none; b=I4xUd/zm4ji0r6KYUvnw7lzRKLF4lMjUTxTc5LAgIG6QCmzJWNRrJa8Gn1yGn/BWY7uTBjdqe8iY+0D0a2n3IALJRwGN48Nz7zqjboJZXfEq7e64biYwwTTTQeD2YTM2dtXjux5vn4FK868wicaDRIbCu8B8KPCWewo5hQ8D5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598926; c=relaxed/simple;
	bh=HqNXYXT/K5L4WdeDMjIhWkk3929AA47cz9x7eg47Tb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PysHkncPlHK3CcQblCMX7uFBihEXemFEhYOr65FzTIVf+QLvfhOpvauzEFvNjRI4NTmY39pmK+RqKbtIvlOwLCIJ2EalYSWbZF8qhreBU2sr0H7m2h+I8gp7Ex6WPxdSv+tnTLNLeZnxsD9WeNrogZNvPDAnwMNCqjeuWrZaqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AzMKfU2i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AzMKfU2i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=C7emD2Ak7PVgPwlA8d2PECNEaLVbFqROe+sgjgxQXs4=; b=AzMKfU2imNx6L6lbzhXR+Mcl/A
	6rNeBoAIg8NO24KwMajZ7+5X+vtzZQpnMj2BmV7s/nh27UMNJMy63Jda43VMGIwx7csvk/RZj8zxi
	LXDMgIsQN4xzbvHOMZZKEHpVC7q5dk8XdDOapgKVl6MvUZ61LwkSg1HQilPpWdPd/MqkGemED2hS6
	gQgcKIY5vpDlOLorgQ2rjmFhYeISMrUyK0JnOW2m+xoK1PAiHI1quRGOjGwLPPNCHaOb0sE8erODw
	ZpE0N8FPxf2axHMnOyZuMx61yKtn23OtpDsR/N37tSEup1n/7mEQegGqTf67ilftbmBkGh1gZ+8rU
	blvZIryA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wya8a-0000000HIbb-3GLr;
	Mon, 24 Aug 2026 19:15:16 +0000
Message-ID: <580f9129-de4a-472e-bebb-d08d9cabad7f@infradead.org>
Date: Mon, 24 Aug 2026 12:15:16 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Aug 21
 (drivers/thermal/qcom/qcom-spmi-mbg-tm.ko)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Linux ARM MSM <linux-arm-msm@vger.kernel.org>, amitk@kernel.org,
 Thara Gopinath <thara.gopinath@gmail.com>
References: <aohvcP8ch-Zn6tV-@sirena.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aohvcP8ch-Zn6tV-@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/26 8:32 AM, Mark Brown wrote:
> Hi all,
> 
> Changes since 20260820:
> 
> None.
> 
> Non-merge commits (relative to Linus' tree): 7073
>  5989 files changed, 509370 insertions(+), 156446 deletions(-)

on x86_64 allmodconfig:

WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does not import it.
WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but does not import it.

-- 
~Randy

