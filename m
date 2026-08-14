Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44D3FE351;
	Fri, 14 Aug 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712292; cv=none; b=D0Ec5arnRmP/IqZguVPP0aWGo9zXYza/RJ7U/jwoAmWBcZDCa+JmgnUkDB87yAli97rG+Ym7r05zKgxW/TJQNPkbZFqJ0v13NJpmJgHUusqpWX5iVyuH0pgo5RVGv/kzkv/lgBLZu++TGTvjis2AC/UATJhm7VMbMN4wyp3jNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712292; c=relaxed/simple;
	bh=bThWytFpYUxSrbAZFD1rkash1i2itXrGKiXynyWgc94=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VSuCH9EuG8IucWMSYZIgP4NljwLpKRm4DJYjKmaLHtHx34a+iln729erMuILULPCEPCZxqFmy2g3nBjm3gd6bTlwC0oYwDXLEKSLjVfc5/j8DLP789t92BPKAFdjQ4bhB9pE/KjowptkdebzOlr3n70z43J8kH9/nIq7oxN2hbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tDrOj5T0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tDrOj5T0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=RtP9rEHDYWCZQzY08CA6ndxIt6cmOVlxFKKTvr2YjGk=; b=tDrOj5T0bv5tVU2O4+OIdo5/Tq
	s/fxzd8fb2Gyayt0K0bQ8PttpbBgnGKpZ4BKg6DfAC6PJUo83qg/U98TGdBXOu++wVP/+PE7TzMnq
	vdu7pS4wyhtKzdJqFSKGlSF0cM+vxO/gIoU2Lje4lyZd2Ez+R94zrDv9Fz1hgHYJPDp0n+yijtW1c
	4H6i65HH68Ej90zyCxlfuENK4AfDuJcFVqfqEEnylbrvp6pEiBIXmu9qigcgTfm0umfQgx8U8eOUm
	vdo365Oos2+HuhVZJb1PATVF6DayoPTcx6ZGs7Tce4gnI1ye4OLIEOvfoEGTd8lrEiRb+zVyLVmpl
	XSClI3RQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wurU4-00000002gbj-3123;
	Fri, 14 Aug 2026 12:58:06 +0000
Message-ID: <29265449-4438-4765-aac9-42e97cdfbd27@infradead.org>
Date: Fri, 14 Aug 2026 05:58:03 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Doc: admin-guide: pm: Remove unnecessary backticks and
 fix a spell
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, ray.huang@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814095716.2905589-1-unixbhaskar@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260814095716.2905589-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/26 2:51 AM, Bhaskar Chowdhury wrote:
> One,
> Removed the superfluous backticks in the sentence.
> 
> And second,
> 
> s/peferred/preferred/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  V2 changes from V1:
>  Randy caught a spelling mistake in the same sentence,so fixed
>  Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index c7bf7cc2db87..6fd72ba52df2 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -471,7 +471,7 @@ update the core ranking and set the cpu's priority.
>  Kernel Parameters
>  -----------------
> 
> -``amd-pstate`` peferred core`` has two states: enable and disable.
> +``amd-pstate`` preferred core has two states: enable and disable.
>  Enable/disable states can be chosen by different kernel parameters.
>  Default enable ``amd-pstate`` preferred core.
> 
> --
> 2.54.0
> 

-- 
~Randy
