Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285342010EE
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264852; cv=none; b=dCwMKfsKTlZVWax432N6jFMWRcsSSqxitfSh/7HqKLH+h1QkxaTlNxHe1qGESEnnjgFz4xouSfWh43lPW0LL4jIlXOr5LgaMdJ3cp2cj5TSrghcvj0Xeq81htiTTI8nlZWYdqsqH9RQcKXiikn4y9BDEqMXDHeiccIqM8vAK0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264852; c=relaxed/simple;
	bh=MzEyGSpOEQTPXhyx29xRDaWjW9jMTuWE29zrMeXP5A0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oIC4QSAm7UOqIPl+Ao6R5NnIS7icJdbCbVb0crLrn7eeUMxDrIGl/LAyWQMACgTLh/VyKkj7w50CyuiR8FO6KTwwwTImaEvA4ArJmF2MDIDfoeI49kw3EdY2oCypgLN0qZB6Vc0IcFuleomyF/XewKB2EwvWUvVS19ZZbnYREps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vhcInlkV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vhcInlkV"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82748257f5fso841999b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773264848; x=1773869648; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7T6BzAyZ6zvZPDDyyrSv8iqVUUqxy8QrR8kmFoTvh3E=;
        b=vhcInlkVa42qc4szL3ZcFG87p3GQjuTTCjvr4AGT58FdxOZ5c2RCow045cr8qkbSUK
         YQYZi2JE7o7P6/FjVSGS02EcEIL+xseR45Nueuf8mJEliF1gaEgQdCU0WhEWFgM3QLY1
         DAUOX9RDbWXcvCZ7esYb7sk1yOoMfR2braWqO1WoeUC7eVJDn1kI17rlw70zc3RgqRA8
         vgBplWT1srEKc7fMbjD8+C8iAo+oh/zN38qqtQ6ezFW9N796Jy5e7H3rhsyR2S7fRx1w
         UeGJYtS+YDybJtJDd/OLoi7vREBBNodSs1OID735udGoQIHMX7hDFBmqpnFWNxmGq1xb
         UKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264848; x=1773869648;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T6BzAyZ6zvZPDDyyrSv8iqVUUqxy8QrR8kmFoTvh3E=;
        b=Cy/6AGo24VWbStLM7YLtCvd3ymp/DhrYWX0hYEsbtMzI1ZiHdtxm8lGEtjDxjcibt/
         fwN7wAN7cneGg0gFHIpgHqya0BIH1WHSGiwsW62+8CbfZbK0smojasZA2bGwFSyukQPb
         Z+pEoqT9t/XxR5eL9/N1S1XFrFv+7ITKbdnsJBPtDw8T6jN06dZiY2KrnfWguoQVhlDa
         zyOoMW3sAdSnqqvBG+YsFkJQidk0TDUucxA/w5NLPaZ+yRlblPjbDc0+J2cuXDLU7qk5
         Dpg4vKKWb0qfS7MIar9WbFfPt8iULClINUFtUPTQaoRu8bNdSPSij7lW2EfVvaQIDCky
         6jpg==
X-Gm-Message-State: AOJu0Yy7IxeIJOW5bYv3CORLgOV0OUQ/8HRw/wrUopb4Rom3DqYhzUuJ
	kZ4naYPPtmyea+9Is1wvERF5ecjCn176O2P2FR9LRk6VS/OSe89ZEgu6JrnKA2sd8f4=
X-Gm-Gg: ATEYQzxyC/h/WjckNVFz4AJsHlczvf2I8OcSl32RjSeH7cd7yOxapzPnuufjp6NLiAa
	VVauvj6mbynWlelu9oQN9Djm4b9le28Miowdjh0tzXse1ofxdQma+ZVXWqmIQx+CdrPCxlY4jGn
	2Bh8/sETg/9R7eZzDGyMZquT/OIXDJkkwMvPioEUsy9D9oNf950TEJEAHd5YafVe3DQYxh+mOJe
	7WXkov09aTHiDm9HL3IxZ/LZzDbwLPBn0Act6YnNiM5GlRK+kELCs9rXh24z6ZtZ7e/YScqZf9V
	1jyOLnpA92M5yEPyBmt6l/xZxA4aN22YxIIEyhXHdLuNAzXcvx0XdN20VpWTg90+AXtVaZlamw3
	TC0YgW2vkHq635zFtP8MUpQGC2QlQfeNdWc/C2Cos/GvBavc7wF+8Yp9EMSLKo9zxMZmV6nbHu2
	XDIdhyP7sjs/yYx5R2IcA/2e8kbA1rdUM=
X-Received: by 2002:a05:6a00:9501:b0:81f:be27:8d16 with SMTP id d2e1a72fcca58-82a0722304fmr941796b3a.21.1773264848531;
        Wed, 11 Mar 2026 14:34:08 -0700 (PDT)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm595730b3a.55.2026.03.11.14.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:34:07 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power-domains-child-ids
 property
In-Reply-To: <177319309976.1426147.15580608651927678828.robh@kernel.org>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-1-5361687a18ff@baylibre.com>
 <177319309976.1426147.15580608651927678828.robh@kernel.org>
Date: Wed, 11 Mar 2026 14:34:07 -0700
Message-ID: <7hms0eyrsg.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring (Arm)" <robh@kernel.org> writes:

> On Tue, 10 Mar 2026 17:19:23 -0700, Kevin Hilman (TI) wrote:
>> Add binding documentation for the new power-domains-child-ids property,
>> which works in conjunction with the existing power-domains property to
>> establish parent-child relationships between a multi-domain power domain
>> provider and external parent domains.
>> 
>> Each element in the uint32 array identifies the child domain
>> ID (index) within the provider that should be made a child domain of
>> the corresponding phandle entry in power-domains. The two arrays must
>> have the same number of elements.
>> 
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/power/power-domain.yaml | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>> 
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/power/power-domain.example.dts:136.13-26: Warning (reg_format): /example-3/protocol@11:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/power-domain.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

Noted, and fix will be included in next rev.

Kevin
