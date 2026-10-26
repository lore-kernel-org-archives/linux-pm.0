Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981751;
	b=rTLV2s52ycZ9ZMsrHqKrOvN3chGXnP6d1Yku/k+BkTF7T40a8WjazK4NAR4fvSFq0PwY
	 HnaNLSyanCIcPPDK8NLcVb6Am6Fd7iZGaWnQpKGG8aSMDPEt1kiKiVOrmRG6KnqdEMfxE
	 Nt/+7gTNG2v+ZK4dir6tT+3KGaFMpFSyzUiQu2Mv/aqg86oiWFDgvy2m2GvzObvwlkONU
	 lkSzdUFW+Z1WxUXIsliqo4GEldy1fblUa8Z71UpxEFH7rxadi5w1Byy94Y5Kyg5hjfmq4
	 +50VrM1ZfU/bXj72OPGR1M+qYjlKVZ0qMb5YYvq/nbh/0f/dS6RblmfkvOji1cRRZRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981751;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8GIlngdOYpkCQ54tZek2AbzCBUnRS2yxF8KYowfA6jI=;
	b=Yi65X78UK2nb03NyJbTuAGTDARcicoYT5HWvQMyiBREfqL/GkV/MXS9F0cijo0ELBTgz
	 GYArv9e1cLbk3sVe1ASKMl0jPjNXK3D2/DOZnK5++GbOcz3yWWQ/iULjjVAIPQrhmM7nY
	 HWLzDJyaKWAVhfC9jU3kySvKENa1i5xmYc3e7bXTVKAAI0wRMYBl5DVO8t8KUaNNHV2pi
	 NSmt9ENuMkOzFMsAKr73VlCXsbzcgR0WDvIFJ6qy02FmT+obaCnw8LrBQ87fU9ftymXBF
	 Cctgr/n0tw7ozSwrxAw+P4SdAJNInwp9IbbcAUDYm51Y8a6WiEPUkVRg9M7ntoAmJgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rsi9bLEP;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA94606A31A;
	Mon, 26 Oct 2026 02:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA94606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rsi9bLEP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8GIlngdOYpkCQ54tZek2AbzCBUnRS2yxF8KYowfA6jI=; b=Rsi9bLEPT9QcmcMuVKL+INM0Gb
	ERZYX6HpIZW41rvQ6sx9SuljDCsEURqHn+UM47HjkYdZqSOCplvmqOxwmMqfvf1pfCaLdhyXaWLq5
	sxpcPl0d0MOUceTBsoAILqBXrTUo84muj4xPWUVL5X7heAnlBJ/msTD+/Bes9HN7IcVl4uNogTWQP
	B/5pjJe+K2leVymeDy6WKplbhO0rQfJMhP4NcHq7X7HyfciIlp+1+P0LNDVfbiqUUmovE8cdHy8qh
	YL7IvMVd6UmytpRwZLZdKsbL6VDjEtyDPNtVLvX+6AuCJZp1R63XIHltzeOU7piz3jt0Sn9ldKRDr
	IgYaU8OA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLASS-00000001cMK-3KeW;
	Mon, 26 Oct 2026 02:29:08 +0000
Message-ID: <45832309-7569-4a9c-b24a-f7838407caa1@infradead.org>
Date: Sun, 25 Oct 2026 19:29:08 -0700
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
Subject: Re: [PATCH 2/7] docs: ABI: power: rt9471: Add newline for paragraphs
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1792965060.git.waqar.hameed@axis.com>
 <eb8f0f6be0386b0f114c3d7cf2be1594d062d94b.1792965060.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <eb8f0f6be0386b0f114c3d7cf2be1594d062d94b.1792965060.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/25/26 3:05 PM, Waqar Hameed wrote:
> To split paragraphs in reStructuredText, an empty line is needed.
> Otherwise the output will be:
> 
>   Access: Read, Write Valid values: - 1: enabled - 0: disabled
> 
> Add a newline in order to properly format it as intended:
> 
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
> index 04a771cd23512..c306e2ead6bb7 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> @@ -12,6 +12,7 @@ Description:
>  		the action before the device really enter shipping mode.
>  
>  		Access: Read, Write
> +
>  		Valid values:

It would look nicer to add a blank line here (and below) so that the 2
following lines are processed as bullet items.
(as Mauro suggested)

Same for patch 5/7.

>  		- 1: enabled
>  		- 0: disabled
> @@ -27,6 +28,7 @@ Description:
>  		datasheet for details. Normally controlled when TypeC/USBPD port integrated.
>  
>  		Access: Read, Write
> +
>  		Valid values:
>  		- 1: enabled
>  		- 0: disabled

-- 
~Randy

