Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290190;
	b=176b9LEZ+03tWNaxkHg1fGZHgGyYxb5LIaV5UpyAYDPYcOOhjW1FmYJXHJ1070oQAWNh
	 eOcjNaYua5ilFiqvFheO7zQF2unM2wzsPg9Zh7pgGU7nQn2p2EUVa4yp3fB8W8VPEDFFq
	 InImIF9GcrExrsC+ka5VIFqFW8Yh8Rbq2Zxr/jDIc6lQBehgxI3mH3A/nVqN8mn6zda1s
	 d2YNqDeqJWQ3VKVM/16p4ucHEBfA2FH5RYKuXeGr2NBnQN3aK20/Xrhmn8zNpOBJg9n0h
	 2vHPJc1pIu9Wt+qE5uJAIFU7VF00bJ6F0fqYu3IWvuvg8s8zj4W0awlr66jNg+KY/EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290190;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wje8FwG2UPim3o1XMNQhcPtkK2evzH/2elPS1xirYTg=;
	b=Pap0qAaNDV1kNgDuCIKHdE+WX8ZnqV2uN8GCS5ycbBdjtwkpG+cQoWlF3vbTFFGrlCbu
	 laaYDc5i3D/UlVlbdrdAlfwPGHKYVhkxQtk5eC/4oHN8qZ4q2WopCbbtvdg7uR6egmGsQ
	 ntPBAtOdny4AjZwXCcpwOd4RYk/57/c4Ur+ExEG9xDU3A6OCWE1v99/pZJl9VVpRPWWqZ
	 gi4Zpm9TXif628+0WEI7mNKmnop7LQNJuOLMARJ4eVGM5/0WW9esJUSw+FV59ohqsseua
	 r/i+3b+fWVe33bMCOTu6+pW7mfsBpPxeQ/3pM6rx0CQRMczg316b2n7xOAKAesjLdUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mlwXHVwF;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D939606A9E9;
	Thu, 29 Oct 2026 16:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D939606A9E9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mlwXHVwF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wje8FwG2UPim3o1XMNQhcPtkK2evzH/2elPS1xirYTg=; b=mlwXHVwFdN0YpiFH2TfVFQXp8a
	KQdRyJfUr9b+iazRyXGN16ZU4tEcvKPHvOFegFT9EjEv+hdviG+pvino0MhEHH9SwTezsHFBW/SQc
	LBqJXUAMDMH+rv3RgUTvX5nrDFewfQFFUMf7k2KTPabp9n7gMGS7j5Ipih1C5xB8qpx7k78+zIrlP
	XUKiePeFKD212nb6qpmK/4oZNaXbaNg5dp6x82fWzvzKF94tIn9B+0OjFQPtbmjaEef0TtB1a5SgY
	8Fc+j95+rOx3/oWrajFjmgaUy7mEfTzqxsIg0ZZ17hyp9H5/8C7/wAPuKNCs9um7M1w7BDrdcUIGE
	D1AmwRjQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMShJ-00000009lXW-18EP;
	Thu, 29 Oct 2026 16:09:49 +0000
Message-ID: <324eb8fd-4d3a-477b-8415-41230c451cb6@infradead.org>
Date: Thu, 29 Oct 2026 09:09:48 -0700
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
Subject: Re: [PATCH v2 7/7] docs: ABI: power: rt9756: Fix invalid inline
 emphasis
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <cover.1793225920.git.waqar.hameed@axis.com>
 <2d5ebe3886651217d55c338188f11a2711df19ef.1793225920.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2d5ebe3886651217d55c338188f11a2711df19ef.1793225920.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/26 3:39 PM, Waqar Hameed wrote:
> `docutils` warns:
> 
>   Documentation/ABI/testing/sysfs-class-power-rt9756:1: (WARNING/2) Inline emphasis start-string without end-string.
>   Documentation/ABI/testing/sysfs-class-power-rt9756:17: (WARNING/2) Inline emphasis start-string without end-string.
> 
> Fix this by escaping the `*`.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9756 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9756 b/Documentation/ABI/testing/sysfs-class-power-rt9756
> index c4d6c2b4715d3..e1ec7977a3402 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9756
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9756
> @@ -1,4 +1,4 @@
> -What:		/sys/class/power_supply/rt9756-*/watchdog_timer
> +What:		/sys/class/power_supply/rt9756-\*/watchdog_timer
>  Date:		Dec 2025
>  KernelVersion:	6.19
>  Contact:	ChiYuan Huang <cy_huang@richtek.com>
> @@ -14,7 +14,7 @@ Description:
>  		- 500, 1000, 5000, 30000, 40000, 80000, 128000 or 255000 (milliseconds),
>  		- 0: disabled

The bullet list above could be improved (probably just add
a blank line before it).

>  
> -What:		/sys/class/power_supply/rt9756-*/operation_mode
> +What:		/sys/class/power_supply/rt9756-\*/operation_mode
>  Date:		Dec 2025
>  KernelVersion:	6.19
>  Contact:	ChiYuan Huang <cy_huang@richtek.com>

-- 
~Randy
