Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B542E8C5
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508409; cv=none; b=pQHlqcmnVvesKJYjuxmsKyL/XE4HQF1hCqVVL9/bizanwFKSgc0PQREf/euImy39qNmIljTtBMis3VpWQUOfXZbHkXU21VGbo7KDEYNuNYCDnuZEOj3Ar8ceaJNvTlkyZpPg4Sm+QSS/AeBF5cObDJv+rfFaPKKPaJgdktoc/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508409; c=relaxed/simple;
	bh=ijNh1l6urWW2UsORZiLTXZySDEmKMwL5HbqApkuKIsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTQs6kxT2F9FhVL9zxh6nwuXPljr84SoluA+BQ64QfPSJ+9Bf8i/VL/3ChbBlRurBMIHDmyKWmSrMF1kIijxaftkWmVpv4WJGi8Zh8Q0aC/9BcTZ+xiv5rN6VV/hhpb3Hl+N6XV1kGbpiImdgSFsoiGyhVztcZKKQTbB7DEe+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9AfqtSF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9AfqtSF"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0148201fbso1038387e87.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785508406; x=1786113206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eA4/Jfq3oApsdwkMmM8JpBKsrNAF9FmOl3wpFinK2xk=;
        b=e9AfqtSFJDgyyeRFiG2tY3K7naZGDh1FN+F2CE63VVSaP6TmSheGFJXylc8oaneNlI
         6EDtgbsNHcQCZsRQjl7dmEhGgCOdeqV51LsGsjgrOMQWVFZ2XzD1CHFB3gWGKofKPD1y
         jcM5CorF7o9gZz6vEzn80KErhxaSyCzX3scFUZ3D5NvAABqe9P/hDR3sX09ibkkRQPQa
         0UOKYz9Qv1Uc8yfFlJM57D+eOTyZ6xDEY7yW31ZdPTdgQDQZjJAUiFr4uHybzcGqwnCP
         9VkyHhi7XDSmdXyGH9vHvW1fqpjF1qUbesJ8l12xezYyala8Fl1e52OHZGt8wQZH5qdx
         p6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508406; x=1786113206;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eA4/Jfq3oApsdwkMmM8JpBKsrNAF9FmOl3wpFinK2xk=;
        b=kJ+LDn7ESDXd7kuyky3Iq7aj17kKQizIoHu3bQjc8dFQ4HAyeW7FTcsS6tEXQiwsfu
         oaUhoPjNYhlyhk7+HQwJFjf429gHpXNylp/kzoWWUZlRELCkHj8ogshw7+Oiyp12Msc0
         kZju2lJu58wHqN0UuKtQ43OD20QGRfnsh17WgPm7wIdqlY0D+4CVzRtESM6t0TB2MOf/
         +FEV3O5dNhBWXJb1UjQeVYE2CrBEvUArLot8haaiAjytPkqdtYekWlnaey0PfBPSHYjJ
         KGXuxPOnjVpz0uFNaTCETizoqtdYO/AWIfGn6YAAq6WpR8yJt1YsqbDvXjF573O2NNKU
         ztFA==
X-Forwarded-Encrypted: i=1; AHgh+RrZoxWnU5NfLsJGmwuIxKZ2PKS3ay7Urhs1lOGaLsCCRW2M1XzTLTIayKtd+vfWh3OlSdQ+zadYnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKFhPzKVVzvFd2H1IJQariet/ltlJmdcLwzWCWlDDEMjL7xlQ
	C7n4/ETLzb8gy1hmL1M2imdM3fNmHoB935EuGzVjhMLxpM4/FpTaLg4S
X-Gm-Gg: AR+sD11EmeyZR7EUurfRU4ue+TESqTqXxujsJiT7SF4TlarvJZDyg5Thh1P0zecouFN
	wkWusuD6AfZHiiPAdaWzmgDXKzMwe2yXQdmZklyORretK2IXoHfG3KfNv1aE/C4TlNq2nHa2piH
	3WEiyLCyPiwAGTd5gGqsEiK18ECCYHsJg+LlrPCsezXggWScgKXAEzCuEHzhAzi1lR6yQWqq29k
	xVc3LP26RREYlduohCmnam2V5q9r8cCHPIu9dT1s8bcUlBBoOj8apeT+ceBGCZ9v5U83q+lI6Tn
	3vyXI0XEk4s+Yh364jYujcoQx/JJFr/xfQLgTO+vb3KXtfzL+088rZGFL1Tqkpjkw9KMVB9lx+L
	MVoC+qPWB/xd5F0uyamCxHliCBeO5kVDc1W/NBTKDtBTxaAdZM8GoGWMJ+dJ1BHcY1ATxuPwVlm
	oFsctLWmqkcDyYTaw5zJHJKhrGpTrWvStqDH5KPPowVLL5TzA7yMHGeEsZanThjOZPfZ8/Gi3A
X-Received: by 2002:a05:6512:3d0f:b0:5b0:17e7:67cb with SMTP id 2adb3069b0e04-5b2e1fc6317mr582376e87.17.1785508405470;
        Fri, 31 Jul 2026 07:33:25 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23c556asm341380e87.9.2026.07.31.07.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:33:24 -0700 (PDT)
Message-ID: <38397324-56b0-41e9-960f-152a16ce8b12@gmail.com>
Date: Fri, 31 Jul 2026 16:33:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] dt-bindings: usb: mediatek,mtk-xhci: Switch to
 ports for USB connections
To: Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260721065413.2306137-1-wenst@chromium.org>
 <20260721065413.2306137-12-wenst@chromium.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20260721065413.2306137-12-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 8:54 AM, Chen-Yu Tsai wrote:
> This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.
> 
> MediaTek's XHCI implementation supports both USB 2.0 High Speed (HS)
> and USB 3.x Super Speed (SS). The block can also be synthesized with
> either HS-only capability or HS+SS capability. The SSUSB controller
> handles the device or gadget mode. Saying that SSUSB handles the HS
> portion is wrong.

[...]

> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Super Speed (SS) data bus if SS-capable;
> +          otherwise High Speed (HS) data bus.
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: High Speed (HS) data bus if controller is SS-capable.

FWIW this is opposite vs what the (most common) DWC3 schema defines:


(also true for mediatek,mtu3 and renesas,usb3-peri)

-- Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
  ports:
    $ref: /schemas/graph.yaml#/properties/ports
    description:
      Those ports should be used with any connector to the data bus of this
      controller using the OF graph bindings specified if the "usb-role-switch"
      property is used.

    properties:
      port@0:
        $ref: /schemas/graph.yaml#/properties/port
        description: High Speed (HS) data bus.

      port@1:
        $ref: /schemas/graph.yaml#/properties/port
        description: Super Speed (SS) data bus.

Konrad
