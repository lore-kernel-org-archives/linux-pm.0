Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.21.61.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711252;
	b=3Iv07k09yxuhkCyCbDkVSo1wwWMXDiAjoEM/SnoNVSK92R08osflM/ZygigIFwDSxg5Z
	 ihvXJ4B7qhKO0aujgXGpt4IB25d2mD0BMP79J6PenhQe7nInmBWA/wQcFAzgx5K5v0x/u
	 pwrftQUxJ4DT+WR3pDA6k60/XPKZJFUivBsZqsuAM3jiPnm3f0NZrPtrggoe3BbRt4vxm
	 nt9fAg6FfB+slziHJYIktonayBISsK5VL1oAcTZL1Ue2cUC6hVqh4d9nWlLDetAat+z4N
	 gZQmL29VfNgYZSGDfdm/raIGkzk6yYmpUdZYCXEqDdkzL8bZK042SlGI9sWyfQnOSgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711252;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+YI0+cCWiIWWts2OssvvcQWLQx3/G5bzwzK8FuCJTlk=;
	b=gREfTG3lQ2H/iAUPOp/nm/gsgAqg+yCyQkYWNJzNaJB7pPHUrBqnbu23krNn/vDZKhs7
	 BcdvIn3gzU9O88/uJUkq2LaepMKqt8YaQ9g1J86S95uGzncGrViysyimuyXe7PCmYBxn3
	 9V/Psdb3gHAAusQqz3E2QCA99G62FI1ffG31K7GLFyy0hvOehUKud954CC/dPCHwqFFcO
	 4aC8zocP/QAfRqTrgUt1qSGMIzMZkCC7hqLRquNv50NV0/9pY2UF8z/NYCg9d32e1Jbi6
	 UPfw6ImLFSbYMEeGXjL+fIwrxF9v2JCvOP3QGa7QwLpJ/nqwmfkXEqTxHfKh36YDBjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aliel.fr;
	spf=pass smtp.mailfrom=aliel.fr;
	dkim=pass header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=nJj+NIgZ;
	arc=none smtp.remote-ip=65.21.61.41
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F1606A31C;
	Thu, 26 Nov 2026 16:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C85F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=nJj+NIgZ
Message-ID: <c31cbdf7-87ca-46bf-ad89-cb4c8b5dfe55@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1795711248;
	bh=wA6+NWNs2Pzeunxgi7qRF97OZsO9dKoJhUUzdBBn10s=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=nJj+NIgZX8FjurIbJnvn704fI1Ag9bw1pNgQEwogjT4rkDWjON5w6WPe4X3747V9Y
	 xfU3ptTlMU1VSCBsHjmzmaSodmVyQHiMbDD7K923DneifPJ61ATyZX7sw+FSTMip4G
	 zMz6cilJzCvbtD34XhkhAyP6Vnk1CnQT8P0Co1k4=
Date: Thu, 26 Nov 2026 17:40:46 +0100
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
Subject: Re: [PATCH v4 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
 <6e408f48-17ca-4927-ae09-c4153e294371@linaro.org>
Content-Language: en-US
In-Reply-To: <6e408f48-17ca-4927-ae09-c4153e294371@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/26 09:14, Neil Armstrong wrote:
> On 11/24/26 23:05, Martin Blumenstingl wrote:
>> Hi Ronald, Hi Neil,
>>
>> first of all: thanks Ronald for picking this up!
>> I like the overall approach. Before I dive deep into this series I
>> will finish the code-review of Valerio's AUDIN series.
>>
>> Two quick notes below.
>>
>> On Mon, Nov 23, 2026 at 8:38 PM Ronald Claveau via B4 Relay
>> <devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>> [...]
>>> Overview of the series:
>>> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>>>    add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>>>    "hdmi-phy" child node under the HHI syscon.
>> It's been a long time, but I think we've been asked by the devicetree
>> maintainers to have reg properties for the nodes within &hhi
>> But I can't find the message at the moment.
> 
> The hhi syscon nodes doesn't have #[address|size]-cells and so far it
> wasn't required, let's wait for a review from DT maintainers, I'm fine
> with the current design
> 

I found an old discussion to drop a reg [0].
My understanding is we don't need a reg here.

[0] https://lkml.iu.edu/2311.1/05612.html

>>
>>> - Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
>>>    PHY configuration ops, along with the temporary legacy creation
>>>    helper.
>> At quick glance your PHY approach would also fit phy-meson8-hdmi-tx.c
>> There seem to be minor differences:
>> - two additional enable bits in HHI_HDMI_PHY_CNTL1 on GXBB and newer:
>> HDMI_FIFO_ENABLE=BIT(2) and  HDMI_FIFO_WR_ENALBE=BIT(3)
>> - newer SoCs seem to have HHI_HDMI_PHY_CNTL3..5
>>
>> Meson8/8b/8m2 HDMI support is not upstream yet. That's why those SoC's
>> won't need the backwards compatibility code. So if you need to tweak
>> the driver: feel free, there's not much you can break!
>>

Yes I did not want to break the Meson8 driver. I will send a proposal to
integrate the other SOCs into it, and make it generic.

>>
>> Best regards,
>> Martin
> 
> Thanks,
> Neil


-- 
Best regards,
Ronald
