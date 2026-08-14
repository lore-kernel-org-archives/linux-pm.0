Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A334A773;
	Fri, 14 Aug 2026 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683369; cv=none; b=CBESiL3lZxZNYFNWzykYpFb+vaSX//d4V/HIs/cwmgOYmZLfToNjLUkxKYOup1Kt3opzNteTkL5uCBfRpy5GkwBdls7aOMNtjEn4i/OU8WPHYGEGw0lyJfczkrrrHD3Jbe5Aej919eV8/gTLzkmrtrZxOC4jzW/1EFTMjj6ED+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683369; c=relaxed/simple;
	bh=Ks1V5XSRODmumNlyPA1TO0YOQ2IvAcisEQANVgM5r8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hb6pxYArt8dRSqfMQlNFO3kKITJqBAY2ao/sSzmfUX9qC3KywJAmaYgLdx2OCTNZrUlQmbYWFSywjqto26jzlJljScM9XEq78Y1g/aTTA48RFQqaO1o0GCzF73C3UHQp6URNrfx69kzDqrBt9BFzM/3CjtJ0SKCv+gYAqtTVu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XpNmq1Or; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XpNmq1Or"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=bDP63tpL4siQ/lHSUsYZcgI8mBQWH6zkvM1fIiNwoUs=; b=XpNmq1OrgfuJBQTTJRRlhOh976
	ESM45S/OcCAf5VbAT0Je+G1ltop2AP8grklMsC647a6dr8Dr8rrkwZv4H3SAB8Xss/8bDs8CLFFKq
	kRr+EJRZ/uA80S84eCyu+iw85XGErfO2iPPuQgZy+c62wheKJtShaTY/d7xeHiQ6HkaQSqh/LacOh
	PDY9d32+SHBblyXUY2p+9/qOL+Hktba71mBcEJxnEZC5hqh19kqLKygRpS+TXNhP4P3pmuXd85Piy
	WkRJfTahsW8bcqxEYWQe5bkaJ5Zdz8RypM4WIBy9zIFemtUC56cB8aF/HOd+9QJ0Xwmi6kpoW+QeK
	ccMUXW/A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wujxX-00000001ws4-3IcM;
	Fri, 14 Aug 2026 04:55:59 +0000
Message-ID: <b28f5646-48db-4d6f-89f8-409551f1b7b1@infradead.org>
Date: Thu, 13 Aug 2026 21:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Doc: admin-guide: pm: Removed unnecessary backticks
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, ray.huang@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814035753.1978031-1-unixbhaskar@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260814035753.1978031-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/26 8:52 PM, Bhaskar Chowdhury wrote:
> Removed the superfluous backticks in the sentence.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index c7bf7cc2db87..a37a51c8b042 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -471,7 +471,7 @@ update the core ranking and set the cpu's priority.
>  Kernel Parameters
>  -----------------
> 
> -``amd-pstate`` peferred core`` has two states: enable and disable.
> +``amd-pstate`` peferred core has two states: enable and disable.

                  preferred

Otherwise LGTM.

>  Enable/disable states can be chosen by different kernel parameters.
>  Default enable ``amd-pstate`` preferred core.
> 
> --
> 2.54.0


-- 
~Randy

