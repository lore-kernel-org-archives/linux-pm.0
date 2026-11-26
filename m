Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.21.61.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707903;
	b=RM6cPiyiCbgJByOQwKDgMvQB3UF4Wz9CsiIUgEaSPzRC/A2s9TQA3SfPwDw5V21yGK5C
	 bvYrDu7lQT4mLvaj8semy6V3KbQgxTaloXI7SEd12dwANL573hlsZkjbsl/71u0NLjYuO
	 heDNhl8VV66TSz9PZnNbN9iFotfKue5zXsuIcjl0Hv3b0vtJEuq9Bdrbog3xNdaYgbbK5
	 aWUniU/MINS2IisGq2q5FEmVggAOORYkQUVCr9GkYiegyhlCkIfrsmXEFvzMQ28aPk133
	 sr04+sr7sJjnW1pdKUofgtJ+VW11Y62pbyP0UNKIgGGHkP32euECbX9qNb7li//U4hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707903;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/1dJn4TAdBA4XljLfYsGFbvNTFReoQoHMmfJqvxrooc=;
	b=GAxMHhOoWEegRJ7AQx5Pvoyqj3/dXMZIdYVxQiteTAvqZ9lQRbfcW+RmOrg9+OCS27Wn
	 5RwKCLopEv1TNaD1Zdl2RxM4Tbh6zO9HSu0tDKHKRF9pa5nGDmqN/kmAOEJnwV68tAsHG
	 MlwXntDmpBIpzTddjGD9+tpZLEpb5Ez9lq2MhpVkrjQOLTp0JIejvpDZ+EuJF7s9OQnrv
	 +oLzIL8v7x2CJTnc74iZJjuKnizPbO0LW72XsB2sYzaqAySu9V4oAmiEy7AWSnLOWtFV1
	 wi5EjeDrZzrMyuJMM2jfTRGETVM2W9dAOCTskoD1bBwc18QqRM3tV8Nz9M3MZYduXRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aliel.fr;
	spf=pass smtp.mailfrom=aliel.fr;
	dkim=pass header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b="RzUt/cFA";
	arc=none smtp.remote-ip=65.21.61.41
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55865606A321;
	Thu, 26 Nov 2026 15:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55865606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=RzUt/cFA
Message-ID: <57d28bc3-04f1-4a86-ba9a-aa851e42610b@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1795707894;
	bh=04dcLTbLWG5N5d7t79/Zb1pDQ+FtO2giwNZpa42wm9Q=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=RzUt/cFA0YHKfXN4T41/CPi6x2ah6O7gE/XstF5FnOYX1T84uet60DKZtR7E5seTg
	 HFpwgcyCVQTGtMh6z22U0zua9LkkjUIJ3vhk/Gx0Gt1ftqGeS5OSG5K3LAMkWfBwby
	 PhIGC35qaKLr/agm8X0j+s2MbCFx7wG8pYDtL6cA=
Date: Thu, 26 Nov 2026 16:43:03 +0100
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
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v4 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
 memories for boot-enabled domains
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <20261123-meson-drm-create-hdmitx-phy-v4-6-3fb94f5534ca@aliel.fr>
 <CAPx+jO_K+sEwm4CCBUdYz0FzJuYNhKizy4VDpQ=Ystm1aPxbZg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPx+jO_K+sEwm4CCBUdYz0FzJuYNhKizy4VDpQ=Ystm1aPxbZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/26/26 13:04, Ulf Hansson wrote:
> On Mon, Nov 23, 2026 at 8:38 PM Ronald Claveau via B4 Relay
> <devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>>
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> When a power domain is found already powered on at probe time (typically
>> the VPU domain left enabled by the bootloader), the driver registers the
>> genpd in the ON state with GENPD_FLAG_ALWAYS_ON and never calls
>> meson_ee_pwrc_on(). As a result, the memory power-down bits of the domain
>> are not touched.
>>
>> pwrc_ee_is_powered_off() only checks the top-level sleep bit, so a
>> bootloader that enabled the VPU without waking every memory block
>> leaves those memories powered down, and nothing in the genpd framework
>> will wake them since pm_runtime_resume_and_get() is a no-op for an
>> always-on domain.
>>
>> This is a preparatory change: a following patch drops the explicit
>> HHI_MEM_PD_REG0 write from the meson_dw_hdmi driver, which relies on the
>> power domain to power the HDMITX memory.
> 
> A question, is the target to drop the GENPD_FLAG_ALWAYS_ON bit for
> these PM domains, once the consumer drivers have received proper
> support for runtime PM?
> 

Indeed, that would be the natural follow-up to me.

> In any case, this looks good to me! Do you want me to apply this via
> my pmdomain tree?
> 

Yes please, that is fine to me.

> Kind regards
> Uffe
> 


-- 
Best regards,
Ronald
