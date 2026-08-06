Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDCDF76;
	Thu,  6 Aug 2026 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984259; cv=none; b=Pb6rTazDsLAaI8f8iuyq4zM2RbUTNf4lJI13/xhTuf9CQXx6VL2toSoQjSkJKx7uipJiBwWoPjZ8bSHEwiX1QiNrGGzRCFLQdENO0g+4KWfDJBNvI38vSoKM36Rajd31q9swxYprEv+nKVGejKKDfbCdSgNwhrq7mqFWIhHpKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984259; c=relaxed/simple;
	bh=fdKINRgR9WJwx0vmYWSAcr2iuXt9HdtdCloAto6b8lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UhcLyt+MN3C8lHKGnCoencmGniUAfKLShacxTKNfZFzaOcQ/89un9cH09g0nP5lToGVokRAJ+QPjuQcXXO56kLpN45fI8chjWGcxdV6qkH4PojdyyQjLUuBFyomDT2SoSvS3UfPgGlgP0NZG0K2yPGiUkMLN5Zp0OGiCUZv4nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b2eed532914011f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c371c1ee-ebea-4b17-b729-418e0d974607,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b944984e5793b53cccfeaf2f5f05f109,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|52,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b2eed532914011f1aa26b74ffac11d73-20260806
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1300538191; Thu, 06 Aug 2026 10:44:09 +0800
Message-ID: <89380ae2-0777-4518-9393-171aeae613a7@kylinos.cn>
Date: Thu, 6 Aug 2026 10:44:06 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: spacemit: k1: add shutdown action and reorder
 registration order
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, shuwei.wu@mailbox.org,
 rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, dlan@kernel.org, daniel.lezcano@kernel.org
References: <1967d2bcc8fede6fbd25fc8eee07f2873fb41472.1784184867.git.xiaopei01@kylinos.cn>
 <DK4XSEPSTY3I.O9ZFCZ9BJGNW@linux.spacemit.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <DK4XSEPSTY3I.O9ZFCZ9BJGNW@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/7/22 15:54, Troy Mitchell 写道:
> On Thu Jul 16, 2026 at 12:04 AM PDT, Pei Xiao wrote:
>> Add a devm action to clean hardware interrupts, sampling, and control
>> registers on driver unbind, mirroring what k1_tsensor_init() sets up.
>>
>> Reorder the registration order within probe(): register the thermal
>> zones first, then request the IRQ, and register the shutdown action
>> last.  On removal, the hardware interrupt is disabled first, then the
>> IRQ is released, and finally the thermal zones are released.  This
>> avoids the IRQ thread accessing an already unregistered thermal zone
>> during devres cleanup.
>>
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
friendly ping.
prevent being forgotten.

Pei.
Thanks!
> 
> Thanks.

