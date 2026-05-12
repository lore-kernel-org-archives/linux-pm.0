Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41430379C24
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569720; cv=pass; b=Zbva06MALX3rN2rO/1lAWaNT9MLpZ4vufP9duhCX9r7CNmg0NZEdWwfTDZgivRyDbpd8twy+aWurBf9OY7euDDXo0NWzSq/t0nxoy179ivZMiEBPHjwn7cfD34sY7wGblc2l5hiSTrM9gdqJuECWFUi1a0aZqzwMRKpermyN47Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569720; c=relaxed/simple;
	bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQj/pHIwkff9A57D1xAAL1923axQYfCOwLEmEXeOOwx5lopJ/jCyA2kNAUZ2QLunpkbMkSNcLwgv07SxtroduQqTss53xDIsEUmmmLBj3R1FEnVwytGknwJptGtKet466xhIIsrwLvPqlBDifMU2g9UQjjEM5qDCNDxxcHyxLes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iigrshKB; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iigrshKB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bc64ad08bf9so771974066b.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 00:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778569715; cv=none;
        d=google.com; s=arc-20240605;
        b=CiNPA1h+VkS8ZtUPBlSIj4kCXRcGKmftWyc74oKW1L737wbwhVU5QTYzp2mnqSpAAQ
         zYrKVFJDuvapPas51Lmp0uQSlna8irTgIDMNajBKoHTkBpv+3lmUVao+Pq4/7Pr6WyCW
         Yg3ouBJ+JgVOG3x5HJaKHrNlvXZ5/Q7HpEdPYZv1OEstCrzzEjqcu6Z69xy/ye0PF/w3
         BN5UZbXUdpWgyQHkFnGJi7uXELVIfZayb7eYfE3gOeTAXdGUVRfGx673C5XMMif/WXYf
         uSMeGMQiNlhimoiI1KZ1EgBvv5jqEfDL3P8XMN/JjQLd2EWLvWDaPw3LTeRUHAOK2Odk
         /N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
        fh=Rjng/9Ox4EbhNJIPgN2KN0kgTO8J8yf/3kqNqNLUIVY=;
        b=fEEBuRvAEBbhsl8g3LedVRmfvowLSc/+kFot5okHSyT7UIdZ+1hlpDaJq9LcRbkWc0
         svanzJl85EsgUDXeofGx9FZr0dEuxVpREDQ9xGQAinJP47dpq6olqYovGa83aB8op9nJ
         B57emkBQFlJCBPZ5lOqh4h3JwNCHIXE0gAuKzxc39GAZk3F3K1ftsBf3EIXa6uLgsNZd
         7ULOnJTGt6gYM1mVWkn4Z9X3bmRauvGDcmU6xaQi0lJWN+Pahc98vF5FB6ST/k4pB1ld
         oY2GIYnMT+7iACzkYjNVWOOzjSCSPrSBUjYaSyyKr5eQ347TUPjJufKsZaqUDNOrrPGL
         AuIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778569715; x=1779174515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
        b=iigrshKBo0am7I6P5eCDAyfBD298mmufQAIOkJPvsGwke2WZmo26E1KD/S0dbEapqK
         lHv6+AANpxfU08BKqjipRPVuHEvqWTp0rWZh1cvNZ+b7MhzFH7j0WjcJpxpaK6SMmHza
         DMfd2VTdjr2S/myQKVMcmKA2PPvhqvBUvODV1l8qVDuRRdy7pxPGZC0126e6hYMp2oYo
         d9jFhVECRVjctnEZ093Y5zEpQMPAXMIOj5ObSv46HrO2jfU/nxcVaPa0WCd09kEb+dX3
         rSm+UpmzT3fJP5BBwaYe6+xDvLX3eDYA9vmd2vg5qtJ84A31ihdbPGuaMnPAIIumjj8a
         te7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569715; x=1779174515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
        b=Il8Nag8lt4OYZA8leazC64sdZYyQAWJgQXHvL3NQdq7iFfkbeLvhxujT0Ia+STg0Jv
         qUCjP16mT4T7DpGrafk4V1F9Zgcm7blGLl5RyZwG4cpNSJAOfXpSh76UEuTf0qIT74/J
         hdqCegyWImaXTh0GW/qHfIy6QRjPLuLPdwuBMlMqfAxAJ6sKFWyFQ4mrGUJw3TkIfMBt
         ZdpZFA58g6bSEoDWZaGDAuplBLUpSyI9NfwtD8tOnJFUMEtpVSZbg2WZL5heCIqLqw16
         gcRRZXsdMxto6KyZauXWRt9TXvTtv+Uc3IKQ28eS6l93TNCLBNyA0HhC2BEBLBE5xBnz
         FexA==
X-Forwarded-Encrypted: i=1; AFNElJ+9Zn8bSvXojPRKH/GZQxLqN+kazMiHOCLYwJ5rmQMD+qrufqp6FBYWQd02JCXCq7tXmTt7gPLGLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlVQ/xRRXD5eIy+YxYyDLH/p/EsDJ8byaWi2Hyyt476yVNKeC
	7yDnl47+J3xg+HtvUpXm6aevp+VQVnEVDE6TWzKuFU+V52RUc7kRKSMpG7SG9eHklgo485TVVPC
	zI3tfXwjX4GHX+yHbRgQ7n5TDPuSq1KM=
X-Gm-Gg: Acq92OG6vCptd+vT2Iw4DJFZoHULwtoPsufQFOOIXnuUdn9Czx/E8ivITOfhzSk/8xJ
	mTOajbGvKk2jUhIIsMUTnVaYwnyGR6b8I2FvA1ahXo/yIbqFSs3aBHYv2LPrXQiTw7k9I79tEVP
	MQYqrihrRjOh9muG96bjGIiSovckUlAs5/QOAhqccO/Gc+yIgeVKSG5z5p0HewatAVyu0XSM9Gm
	O4jFpstvBCD0q/MZRzvuc5L43wZ6FYLd3jRmcx4Ok1ZkmHO06/fDiaFFLAdKpbS+ArTzE3aw/mw
	tr+8RJ/VBxJwKW9ajn9/ER/KUdrALPKGMphy14XODkjeFono2p1uL80/x1mlFIsIHaliEQJUIkF
	WYtAUeBk=
X-Received: by 2002:a17:907:9412:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-bc56de100damr1755416366b.21.1778569714611; Tue, 12 May 2026
 00:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-10-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-10-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 10:07:57 +0300
X-Gm-Features: AVHnY4Jipzfnw1owf-ZULaa0oh4jwzOau62Z8kgQLDNNHax4pisYq4PVzs9Mr6s
Message-ID: <CAHp75Vfi8VwJvBLAAnRO4ZdoFYCCXcC62UOPC5hCcYpTpf-+og@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] mfd: mt6397-core: add mt6323 thermal support
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
<devnull+rva333.protonmail.com@kernel.org> wrote:
>
> The mt6323 PMIC temperature can be measured using AUXADC channel.
> Register the thermal in the mt6323 devices array to allow the
> corresponding driver to probe using compatible string.

Wouldn't it be better to interleave these MFD patches to enable each
driver just immediately after the driver provided? However, in
previous review somebody ( IIRC it was Krzysztof) asked how dependent
are they and it has something to do with the device tree bindings.
Take into account that one as well.

--=20
With Best Regards,
Andy Shevchenko
