Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289991;
	b=sG1+2/hc+ieKOkyqCBzvONvKXy6bEif2xkg55LlF6kuLjc7jKuSecdAxrx0qFUQw6krD
	 3CmaFqr6upqRoJ589P8bblW7KRAbXf/Fu6Fsuu4jlXQe2IyMU5sm8lZzNUBc1sfj5ibZZ
	 QaPNZyG0wQbtg1Gbn61x231+bs9Jk8GtbhKp0OBfZ/wAPYtSaghRBAZX6jk1r+ixNGC7H
	 G5oZM4sPv6TvEqs+7Kb4kbaYB3UlOZAAEeYuGgt4go1sP/WRPhjagSM6FXvmmJaDnObnZ
	 HY6IK0Ny79u86KTPjejDVA6VFth5vHWVvJls9RiKApnHKJkAn1TQgcdlcwgMHVmEbrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289991;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jIIAnQ7uXEa4UtsEKj6nL8SBMyzaURmJdqb5REyVF+U=;
	b=lff0yB7SHcaQ0hgX/c1tb8rX3CxTEEKJMbpwAD8UH42DNqmIoJ0Z+thN3kFsVeQnEsj/
	 rU28PFDHSi/eIdUmySXwr8LtATk4kVz3Ccw89lZh7Tbhl0YfB4H9Vf4bPyH/QA3/P5Jdk
	 GA1HZt5BIH8aGYx17JrRzeO/9GbwTgA0Ig4izKBBPAo6OoLtrabAixiOR425JaNFIYcWR
	 VzAYQqrb7H38m3aRnw1h1N12l4Bg+XIVonFLTalRWsLN565X120214M2JMfA1wEYra6TI
	 jqJMmpeZFnoY7W39UdLyyHrIp5IPYta4HDdZjBEr1DCJIbUiPGjIF7rq6pDhQh4ezRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qx41xw8y;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730C606A31F;
	Thu, 29 Oct 2026 16:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4730C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qx41xw8y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jIIAnQ7uXEa4UtsEKj6nL8SBMyzaURmJdqb5REyVF+U=; b=Qx41xw8yjygWpQsNo4rYARCVf+
	BkzqE7MppStrNyeM3qJBUE/IeXRgkRWXOkFilG7DNOlEtT3jtlZCJnOHpXAEmcV4WJ9UeUgJRu6mz
	BwHZLcP1R6IRQ0pye04/BGyLA9vPpelCO3vhWykj5b+VuO1vugDg0SyLrTwW7xXLQpcJafuNwFfal
	GOgFUQzxCmAnam6sZyGnrjltt1DConMChnBxbeiQGVS2riT2VV1m44p4WQtvN7ZYMrqGv9Ma102AD
	Ad0swBQSXSgu2fMJO0Y3vlSeG7aioF9iD50YpfjWxt1dqZY7m1S6l67ASgqO+6OYcFC9jbUaTz3m1
	4p39V/3w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSe6-00000009jlF-2STN;
	Thu, 29 Oct 2026 16:06:30 +0000
Message-ID: <62a1b6df-88cf-49be-9664-4db8ec2e03f7@infradead.org>
Date: Thu, 29 Oct 2026 09:06:29 -0700
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
Subject: Re: [PATCH v2 4/7] docs: ABI: power: rt9467: Fix invalid inline
 emphasis
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1793225920.git.waqar.hameed@axis.com>
 <11c2308c9bbd739d3e72f0a2fc614232a5ecd6fb.1793225920.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <11c2308c9bbd739d3e72f0a2fc614232a5ecd6fb.1793225920.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/26 3:39 PM, Waqar Hameed wrote:
> `docutils` warns:
> 
>   Documentation/ABI/testing/sysfs-class-power-rt9467:1: (WARNING/2) Inline emphasis start-string without end-string.
>   Documentation/ABI/testing/sysfs-class-power-rt9471:16: (WARNING/2) Inline emphasis start-string without end-string.

rt9471 above! :)

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> 
> Fix this by escaping the `*`.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610151025.1g5IgCv2-lkp@intel.com/
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9467 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
> index bfbfd78ec1c19..bfb9c0f478e45 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9467
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
> @@ -1,4 +1,4 @@
> -What:		/sys/class/power_supply/rt9467-*/sysoff_enable
> +What:		/sys/class/power_supply/rt9467-\*/sysoff_enable
>  Date:		Feb 2023
>  KernelVersion:	6.3
>  Contact:	ChiaEn Wu <chiaen_wu@richtek.com>
> @@ -13,7 +13,7 @@ Description:
>  		'Disable' also can help to leave it, but it's more like to
>  		abort the action before the device really enter shipping mode.
>  
> -		Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
> +		Note: use /sys/class/power_supply/rt9467-\*/load_switch instead.
>  
>  		Access: Read, Write
>  		Valid values:

-- 
~Randy
