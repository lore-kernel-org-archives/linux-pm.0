Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785736;
	b=U17GuHkJY/R6qPqy1vgwzH+GGpG8+0nV0y7+ret6YjhFWSHN6fRrXn+3VwCHSXSoMIkE
	 8xbq3jlxKkJql7ZqWUBWSX0Kf3PHDjYY160hy4+nbAmyGWcJYILUFygu8SVEHZSG/7y0I
	 YbrpR6jgmJSPNWudM/vVXyajE3dxXNzvl2Xarlbtm0xeTSc1p+NmUEuyydyaplBNArx5f
	 eGkDB1r1VP50PFIi9/9YRyOMjh9FEyyXrmSQuQSJJzWn09PraoBZbHJFpdpznqp08KFBg
	 H/sVEoiFlZoMOTsbiflSsO7/m01+4OUD5tO+TmG7eInFVh5uV5zEXG3pyiubSBA4uqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785736;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=8fgOWFGKS36bIlBCMwklu8S5vPCSUuRNSX+uswJBK3k=;
	b=U5E6orXqlTjnthgv4/0ZfJ+t/eyVzqXe1nnRU7+lGb3s8abr2udbZp7IFjuLesFyIjgA
	 lL4YhqygxnOl+XumHGZc1ZmKA6D5DBcBYCjhaattm3T248Zh8IGZKoRN7wKDPYpPY3MmO
	 axBmr4uMw9D6uZQ1Zyoc2GnSOvSLGPOCNaTcKZHcw667/ztwb0eUz7jxXgQakIv4OlLjb
	 OhwdKHgzPv3juDeaaY0yS+Y6TCVjHesS/HNo6+U+2JXEUZXyKIBZHZJwzw0UjWpTiIX1V
	 8cFg5yPiwtHlkrIvlgKAuq5gGyS722Z1z5oZ6WaQphevD5WlaoOJI0UQYndlktii1jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=HcQ9FMmR;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1123606A31A;
	Fri, 23 Oct 2026 20:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1123606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=HcQ9FMmR
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46BF51D881E7;
	Fri, 23 Oct 2026 22:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1792785727; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=8fgOWFGKS36bIlBCMwklu8S5vPCSUuRNSX+uswJBK3k=;
	b=HcQ9FMmR0gYZKmC2o07dz2B6tzIWd6w8+7bUHw7Lys6uE/izbb8/MhG3tRQz/gHPI3RvCw
	045jt+mFCnqO09Mdw9uLPlII6rJoD9LYD2bDl4xvBuOK0pxDXb3g04jSJ/UGnaigYPOPGY
	4CRxGdiRWiBEp1oxq6akSxj1fNAHOkNHJBR9L2ij0pdqV2zVRCiVuK8QJy81rPKBqbu6FH
	9+ee2F8m+DKgt3FVFGwziwW8OHsf5Uf5pWOBd/+E8wj485OqDy2pQYskpoa97T4x+7aN18
	oGBaM/DlmDoieZ9JT0hsNucYxcNZlEo6+atjrezkMVG4tykGauYqKKe9LYPLNQ==
Message-ID: <2f78c7a6-5955-4d21-8f61-b3199b493840@yoxcu.de>
Date: Fri, 23 Oct 2026 22:02:04 +0200
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
Subject: Re: [PATCH RFC 0/2] interconnect: qcom: sdm845: Drop the bootloader
 vote on ALC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261013202611.3070778-1-mick@yoxcu.de>
 <d58c1d15-49c3-4740-b24c-17b850b3ddf3@oss.qualcomm.com>
From: Michael Auer <mick@yoxcu.de>
Content-Language: en-US
Autocrypt: addr=mick@yoxcu.de; keydata=
 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
 ShbHn51QMVl4y3nkTQ==
In-Reply-To: <d58c1d15-49c3-4740-b24c-17b850b3ddf3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/19/26 2:22 PM, Konrad Dybcio wrote:
 > ALC essentially translates into "prevent DDR from sleeping to reduce
 > latency", I don't know what a good framework for that func would be,
 > but interconnect (even though it has the plumbing for BCMs) doesn't
 > seem like it.

Thanks, that explains why the vote is so expensive in suspend.

I don't really want to add a consumer API for that.
I only want to get rid of the vote the bootloader leaves behind.

 > On msm-4.9, the downstream kernel for sdm845, the driver unconditionally
 > writes a (x, y) = (12, 0) on the active-only context and (0, 0) on the
 > remaining ones and that seems to be the right set of values. I don't
 > know how secret their meaning is, maybe +Mike can help.

That fits what I measured: the cost is the vote in the sleep set. With
the boot value kept in the wake set and 0 only in the sleep set, the
SoC also reached CX collapse.

I could only find the (12, 0) write for clients marked with
qcom,msm-bus,alc-voter (update_client_alc()), and I found no such client
in the sdm845 DTs (CAF LA.UM.7.3 and 10.3, and the OnePlus tree). Did I
miss something? If not, the only ALC write I see is the handoff removal
at late_initcall_sync, which writes 0, so downstream would end up with
ALC off, like this RFC.

Would it be acceptable for v2 to drop the dummy node and the binding
change, and instead let sdm845 list ALC as a BCM without nodes, which
icc-rpmh votes off once at probe? Or is there a better place for this?

Mike, is off the right state for ALC when nothing asks for low latency?
Or should Linux vote (12, 0) on the active-only set, the way msm_bus
does for an ALC client?

Thanks,
Michael
  	
