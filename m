Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867048;
	b=4TBL73qaGzJCttrSlHfW3qr9m91+Vz+YT/qjaGHCTVbY4dBQBvYs6pV8Bg07hNYsQNA8
	 ZenLwdSAKXbmr/smZYz2NTiqwATcdx5L8iD+O4VMj7Ypx9IG4FcVFQRjekGn681YxIrN2
	 Ohf+FDJHeVd2/zbek3jmRaRKSRrm5yQjmfCUqhULTTUOp8USHgW+hlgLcnYpe4YBEBpsI
	 9loA5ToY4i8zXOGw/r+tcRN01+jB0Oo+97h7wU5+X+CEZAuhhuoiqAJMvrGcAD7DVlLU0
	 webBqU7PIegpoN30O+ZkVIkuQZPH39Bmf4S8/fNctd8CSvRWrYOy6y1XXZwldK6EVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867048;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6+ADUqVtFDrfgQJ3OhV70TKxA4b9WrHMTSHdV9mWIWc=;
	b=h72c1VEBHWej04vUn9SXfOBNZiHKY0/olE/gghGBQTbfecUXzm7HiM8q4OU7p2qr6Zit
	 04MVwMAod+ctR3+56sby4BxU0GhI6hw2XjkTUesM773o06zcwDEQM3C/EJG+8JZkfLnWJ
	 EdgIBxLL61BHDcjIF7RfmR2jB9RxxVXUri457uE2ShbcQMP5DXt0mg6aJmQEXAqgqwzPe
	 88+MxDLiuPNmH4lFsFUwy/bOgrFFyvwe48DAsd24KQC+/Qh15RAHIg3VOp03Pj2KM2h9i
	 szNIdb5aqqGIFWoZEw2gzbuIpRza7XywJKizxvLlbRqcYk4ai/0wjaM4xWYQHLiq2jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nDz7CJiN;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AE606A32D;
	Thu,  5 Nov 2026 08:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D0AE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nDz7CJiN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793867046;
	bh=RctHusTE/ZE8d6je51Pq4bj7K1e6qmeDSw38M5NLaVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nDz7CJiNR0D0Np06ekAx7PhNA/r85Mx7xWEW0Vj82tl82q4NpdUkm+E1cC1TzEiTY
	 93noRkqJ1HAppXU0XlTsMeRtHa/iia3BMl3YFhHf8GEVPbDbDyRdEWn3MISziq76qf
	 k8Vs7TtY1samutFJh8KJSaYUpHrI+cD+9fkijoBaU12GP9AVdKC80YCrwrKoXKJad+
	 gQVO+PbK+agADkozFxSuUB0Wxu4kcnKrYfhxNZfufoFFsLff5INcMGTgcq7qRzr2Nm
	 etW85kcIC25PvpXZcXI/kFraVgNtnYg+zQXi/tVU6koxKeav7gHgsbxXAQAvr5YEU/
	 Lxjrw/9LW6tfw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B90AE17E0048;
	Thu, 05 Nov 2026 09:24:05 +0100 (CET)
Message-ID: <b627d513-d587-43dd-b555-584b05e7d043@collabora.com>
Date: Thu, 5 Nov 2026 09:24:05 +0100
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
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8188: Use
 access-controllers in the power controller
To: =?UTF-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>, ulfh@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261011184755.2058017-1-michal@nozomi.space>
 <20261011184755.2058017-5-michal@nozomi.space>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261011184755.2058017-5-michal@nozomi.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/26 20:47, Michał Kopeć wrote:
> List the blocks that the power controller accesses in access-controllers
> instead of the deprecated per-domain mediatek,infracfg phandles, and add
> MFGCFG, which the power controller needs to enable the GPU timestamp
> counter whenever it powers MFG1 on.
> 
> Signed-off-by: Michał Kopeć <michal@nozomi.space>


....did you instead mean to send

https://gitlab.collabora.com/mediatek/aiot/linux/-/commit/01c35e0524c8adffb4c19f1005c5d71a347acb3b

this commit that I forgot to send for a year?

Regards,
Angelo
