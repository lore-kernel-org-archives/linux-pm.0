Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982374;
	b=jj9dljbvJA/vYhpaO1UxsT6lNwp4h9KThTf04k/CV3AOj5yan52Qd8VCLc8MCZUbkkQq
	 oGHGGg5R8jjvNYGq8YkCfgfRgadLDD0zYhGAFl4M8AlGibp7KrtKsaQ74I8FwXawyog/P
	 qzdPMIqiJ+KC3ZGVtnmpJ7Ej3xyTQz2ZPtCEFtMZrK9HyWNAVn3N4swiFSQg2tz4ajKWl
	 GiHxGLKBdz4hOonXLnx97d922raCYqq4YVjrVPJHmK9piISv5vDHn98Wvx1UNkROeV+75
	 W/I+XKyjRKV5+bhSbieXkPSYWAvQA1mgHCL0jLDeP5bYZv5BzngepHUnilDjwF7AfFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982374;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EWIAgwzBcg7K8A8tYbwaBO/laAOinWsGzDghXjTvN3M=;
	b=KiA1zz7h6WQd5XI95jJKewCVZC25W+/L0LmXXYJUn+l2456hyDwhZxrsUfnq39e0My3m
	 KJoQgonnAIK2B5mhMY2C94eIs3fnDpuVBcc3Qbe4SBPXjeYCWNh0oLzvOtSCZjshqIVKB
	 GmOz2xtXKsztymqpPVccKesgq0BoKAqJVGn+nn/7cEEcuRsU1cj3dH6VGTBqJnCmUmBQS
	 SG5b/LaPkGTvIeFfrOHNaDHfkz4s7qz5ejdSAHf4o5NtqY3qFr+67gZyVpdhdyf4oBdYt
	 EAH4fdjieq9DpVUcGjjwTp+jkzScSLsY0vuCrG9ifuiTZ1uOBSRBm9fa8PVAhT1zY4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aSlFAcPN;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BD606A31A;
	Mon, 26 Oct 2026 02:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aSlFAcPN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=EWIAgwzBcg7K8A8tYbwaBO/laAOinWsGzDghXjTvN3M=; b=aSlFAcPNmvamUP6oh8yhFU3dbt
	pDzZiUh0KJYdgfvaDJA8JRIl1ze8ftTCn4F1DhnAemxrgfjgkvHVC/8PWuIC3K2NkFFNNmiimmgbo
	GrFerzcy8HWPNd2jDoz5/1z3raxq3O5ywXq3mg9guoQ66gRsLe2ogzhjU3i+vNrwzsOwCYu2Bsgpl
	jbwmukGTeC4DrKqW2MpkI+HY5EokkDvjoXNxVV9afkkwzEvJ+auaQhfoh47f5XvjWfyTf4yMxoNTQ
	yeqcWbnDCszkc0NjjCnn3tL3+0fCYdGWQ5H1nOgycTRseJ30fB0g8OwaYahPGtCV0qb2dXLlsfDg6
	RAGrS8hA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLAcX-00000001ccV-0oxL;
	Mon, 26 Oct 2026 02:39:33 +0000
Message-ID: <004fbff3-7fbc-440c-9c44-44585795521c@infradead.org>
Date: Sun, 25 Oct 2026 19:39:32 -0700
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
Subject: Re: [PATCH 1/7] docs: ABI: power: rt9471: Fix invalid inline emphasis
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <cover.1792965060.git.waqar.hameed@axis.com>
 <ba11515d8e0dc45ad90f162302bcd1b20db9bd92.1792965060.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ba11515d8e0dc45ad90f162302bcd1b20db9bd92.1792965060.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/26 3:05 PM, Waqar Hameed wrote:
> `docutils` warns:
> 
>   Documentation/ABI/testing/sysfs-class-power-rt9471:1: (WARNING/2) Inline emphasis start-string without end-string.
>   Documentation/ABI/testing/sysfs-class-power-rt9471:20: (WARNING/2) Inline emphasis start-string without end-string.
> 
> Fix this by escaping the `*`.

I'm still seeing this issue after the patch is applied (same for patch 4/7).
Maybe we are fighting a docutils your-version vs. my-version problem
or just a moving target.

$ docutils --version
docutils-3.13 (Docutils 0.23, Python 3.13.16, on linux)

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110722.GAZVme6v-lkp@intel.com/
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
> index 0a390ee5ac21c..04a771cd23512 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> @@ -1,4 +1,4 @@
> -What:		/sys/class/power_supply/rt9471-*/sysoff_enable
> +What:		/sys/class/power_supply/rt9471-\*/sysoff_enable
>  Date:		Feb 2023
>  KernelVersion:	6.3
>  Contact:	ChiYuan Huang <cy_huang@richtek.com>
> @@ -16,7 +16,7 @@ Description:
>  		- 1: enabled
>  		- 0: disabled
>  
> -What:		/sys/class/power_supply/rt9471-*/port_detect_enable
> +What:		/sys/class/power_supply/rt9471-\*/port_detect_enable
>  Date:		Feb 2023
>  KernelVersion:	6.3
>  Contact:	ChiYuan Huang <cy_huang@richtek.com>

-- 
~Randy

