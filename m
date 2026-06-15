Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C841325C
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543394; cv=pass; b=YB7T8+Hynk6GHGcuBDB+CyACiyJkW0uPePsiSVfgrFrq3L+MayYrH4lFkzRKVx9ngO+UfGgtZMlRMQZLQXNjCzgf2/S9U8UvKBw3coaWhUFaIdI9OgODHh4XQR7tWoOqd3C+SVbVyZ9LV3wpRGe3tUX3DdjxAxym97aLEUGloBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543394; c=relaxed/simple;
	bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kW4UtGOHhgEHQGtjF/+ctrMMOHXfgeeEbapPl2Q/JpQJXTre4hes54h7VzR88sMEnqWO1Xi+dKvRHulQWeVepL/5gsFDCtfJHTWPczVDRzDEwl8/nKhGgGqidsKzupgx70Lisgvb7Nn+vuJXnL4nucq5YYDVZldIKro97I0Jp4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU2Iblhk; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU2Iblhk"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-becfa735b9aso448041466b.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 10:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543391; cv=none;
        d=google.com; s=arc-20240605;
        b=QH7bOViEUR5rvpM2dGebIKH0ivU6rjqv1t6SPnq1Zu/zPPEN7FUdz/1VFiSbTZ43Nq
         0cY6f1aC1Sbj7s5VhgQ99iCfmQz4BdzKSYwcwn1L0O4qrLH6ODTIdW5JMsAApWtvIdVP
         Q0iURCfUcenAPeZsi5twiJWlypBjsV2/HCElUOjwXt5Z4q3Xlat8UFU+z+ktYEQQXKyc
         WPWiWIpB+nHLLmh4aMOWQ9QsQvQVUeRmu6v/TG2MGou+u93VWTvAiL0o8WBqHIygQ9JH
         xmArGW2kBy04xQ89OANAAq49sHSwAcIIcDS5fJAviJmNQd5TYGd4GXepYFysLg7O9xrA
         78ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
        fh=ECSpPCdmrzy1hm6yFdKyACtxYyVoBHLR+lCJkAFRkdg=;
        b=KQL9xNBJ/EwAROfYVfcFXXn/xYUnQnsB/25jnqqQwyCImRZWUdboQesB5BK65FR4Cu
         XXjs9gb+goSvXkYRhaVXzKTxAlcEC+ZPE+b77ehQNwffzCQnIzhZTLbhgqptDoIrzRsR
         fJhPm9afdJ5KBXAHLcD0ZAlzD5n3Y7fqR/fjcRQDSOtqyayPJ+BgwsGOrFQt2difaX46
         wlEACbt4kqYlp8ynxbulRxXgc6NEQOEqVncOILHBBwcM7tByUqpq4g/9Z1N36idRLSq/
         LspNQWpY2iB/0erJvVx2rtEn5XzoPAWK1K48bdHVjWNLUD83ssbTV05GTJVcbRzwRJko
         5cHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543391; x=1782148191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
        b=bU2Iblhk9vnsDgxKxhXjiCS2mj7KbveT4augZWlTS6ux58qPS754bw7G+7+uJqKHi6
         94kyHYvMEuQOn17rovkHBYwgLZ8V2jwcTV/FJ8meab5Jbv74cOonR7apCDQj5rlH/KJ0
         /4yVzA8HArrPKtkyyb0ssZSbr1jfVj59ntpAdQV71pDu0KzeibnBqtdwdDVQiwaPnu1M
         Mw5AMag5P2ngaFmhlJrCA7D6lvASB7VtVykTakWfnEx6uOCaDGJMcyogV8FJq+tld6g2
         1dIHFO+Fu+J2UK9OFZ5wsroZG7o440c59fGLL63lcLUc8p9y0sADHiHVsbD2E8QSHUeb
         nHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543391; x=1782148191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
        b=jCdMu5ULKMV/ffDDRNAlAa7lMXmJApUIET7v3uCnrMAn8ETxXSs3bz7wumD8s4vAjB
         Nk3z1hqYYKWoCGwuWsuyfiMm3iNauMo/T7oQFu4l6kNIfqVzdJZRCKKZ5wwhCr0OzWx5
         8cWxvpujcuokUsMAXnR8aPkGpYR0+eWFqQoovLZcfVxtKa0bLTLUjdzwty4wa+CXwo7i
         IVgudmNXhGvLmlpr0s58v/qHbJI8rzIqFJUfOga/u+YRKX7CBy25coiHGXmma5X+SDOl
         kuhe9LqaxKvjO1MHY1TQPNIJnosN7jmBUKnxw7fl3q6653EjP49Q0D2lWuILQkDgv5CD
         nCKw==
X-Forwarded-Encrypted: i=1; AFNElJ/X+nQp3Pk1satQAOVl/9MQsb1xeT2DfGSUznQ1FF7wvZ33bTMcd7f4TTPv8ZBenleEIUlmGzYFKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfzJGbDnQCxRRqcAdWzqGG0K/WtDs9W2/GUgKYq4IlkmrwkOt
	U20UA7NBKngAYZSIsGqb5+SfoClE+esfKzul03UMXFezl72oFnD/pCuaVQ3nNhJWV0RIe4fi4CB
	1fzBoE+8vNVsCQefm2IKxaadoWNsAh7c=
X-Gm-Gg: Acq92OHrLZzKj/bTj6zJoOIFknH2NwqZE5Imq2GqS/DyYEb3ucGAtN7E9YGIdJrO8HI
	O+84nlJVQKS6ZWBAK3z3O27gU22PYrLVNISFkIhS2LvLbHC5ozmNF8IGBD5OjoGYzGtm73fjaCG
	sglD0I5EVScvsv2BAZB3OPMC6w3EiNKcLP15GXFdz6Ey1t5nra/Y5dU14kTLNCYX+HgBxcbYaWo
	i0glWXlO1Wcrueswi65YVLdFwjgvmrMnxApINURW60zDNaYcGU/WHaHdwlkOvIwAPDSWKkydz7b
	mRgZwN9ayHxDydfX
X-Received: by 2002:a17:907:3f8d:b0:bed:2a8b:3e73 with SMTP id
 a640c23a62f3a-bff4cddd831mr594131266b.41.1781543390991; Mon, 15 Jun 2026
 10:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612200717.361018-1-l.scorcia@gmail.com> <20260612200717.361018-2-l.scorcia@gmail.com>
 <20260615-palatable-aerobics-3091229b6ada@spud>
In-Reply-To: <20260615-palatable-aerobics-3091229b6ada@spud>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Mon, 15 Jun 2026 19:09:39 +0200
X-Gm-Features: AVVi8CcgapzCFj6cwsB094FQLtSSMmdLrOP26pKMcjV8D9cFGpyiqQvrj10_jjw
Message-ID: <CAORyz2+4EquYcUHEnoq0N_p7vCmDpPONEhVrmAfO1eX_RNMYbQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Conor Dooley <conor@kernel.org>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Julien Massot <julien.massot@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
yes, sorry about that, series v6 has been superseded by v7 (I replied
to the thread and marked it as archived in patchwork, please let me
know if I have to do something else to mark it as obsolete).
Sashiko was correct, the regulators node is required for this device.

Sashiko also has suggestions for v7, a few pre existing issues and a
few nits here and there but some are actual improvements. One bit that
caught my eye is the use of the modeset register in the
mt6392_ldo_get_mode function. I have to double check that with the
data sheet and the android kernel sources. Not sure if I can do that
before next week though.

Is there any way I can trigger a Sashiko review before sending patches
to the ML?

Thank you,
Luca
