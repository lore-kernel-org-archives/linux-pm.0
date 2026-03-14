Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F4261B8A
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773471227; cv=none; b=DE+/0qPpe/L6lil6yEmVILLfJf7GKxyq5RBcoAUi7Q5O+ANeQxa6Rgld0l+IwC+/WHBQ8KLsMxZlHi2QrCCtPB7LZdZEzMMuAru7BHkspFn4c2xObiwUrqqdFld8r8b7lNFCGGMXA16OeuLfNPxaDieA+Gp06GH0vbsK9fn+mW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773471227; c=relaxed/simple;
	bh=OGqE3n15B8Oam7oaufyM4egmtIok/tvgCx592UaF9pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyMaBApRxZwF2g56MNmnIcX9PXrczxgw6bbT3NRr8gQuxCPZvaokdZ35R79VYszItWqDFW9/a/gNTae+9ITss0Lj8ww/Y1AKTS5HJZ9kSwozGdw/U7L5c6H3COkAQvOAMeIhFobFQCQMg4TqKugMGE2ujqpc078z/y3RPnu7lZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWElYE72; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWElYE72"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so28260515e9.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773471224; x=1774076024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGqE3n15B8Oam7oaufyM4egmtIok/tvgCx592UaF9pQ=;
        b=AWElYE72LPnq++Y88iKIndzwe0yzI6583D6RQQRf9sJMpk08yGPuJ/2opVl4WNBHca
         vpk8zz4Wam1MOllrJK8vnBRJPuzvANvdE9GauzASNtpRq6Iuiwyh3o7tvfOwqBmR3RPz
         Yuq4BTxwpvrOXyRr3TWUwFG7GhY3cem1n2QWUQZuRX+juThOhE+wZ7UEwh8c3aMfJJWM
         /1o4ekhR2EAFRT+H1y9I7e6NL2k3RpMueknHP+KCmCOGiFgbRawuJNac8WXEM3l9rNH2
         ZPNk7asnMtcYtfmMXMRlfYRINshV7xD42CD4lhyNEp6Hl9qRJ62dPboQWU1tL6e9DPCj
         w/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773471224; x=1774076024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGqE3n15B8Oam7oaufyM4egmtIok/tvgCx592UaF9pQ=;
        b=WO7vnkEWvzajQEjsq9yA4fcVL0ZWLxglUGnF8B9rqq/tJPhjOLmCrcy3OzEAXOB2Nx
         AZL7DhtqfZDN3VC55dm4/yLHqOgCDmntyWYAXdKZroUIbxu6viOFgm5K3H1YK8v9upb9
         JQlIqaiPs/wm+f2Pk9Fg305ldxe3h5Q6o3TRumq8vKUSj0SZ0h/jaAhXPKANc7ZnfcLP
         9nPMTdcxW1YQ7tIVXCrDyGNwi3Tsh3xeuXENzeBw1+lluBsfxogFXb4bxU1wnGwPVFvP
         QgfNnrZUF6wlTDzBP5bztqk0Ce47wvbr41WQyK/nHUA+BgTmF8hMKSkF0MowS8N2yXaX
         wf5g==
X-Forwarded-Encrypted: i=1; AJvYcCXrLCMzjeA1q2IiiX9c48Wy/ByONFbL8Paacu9E7WpsyR06qB7SU+wu1U10Fvf7yiQTewQyLzJ6fA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMoiZeeqpmOaFDeBmALfMSUbTZqHX57NB66q9FNjIXHxuyjVb6
	i5ShDVMy22u17UvvHl5VI9w8xWhoWjnt+7PD+q/kjrc3YdrSYVGfexrq
X-Gm-Gg: ATEYQzwl8Ow1NFhdfiQbSLTLMBGGKz9/KwETof09PJj52CdtNSYZKQ+QRgEY3LPsTZM
	UogBnal2VNHAhhO5yGVgBja6k8+bJ6I3FXH4G6uPesFrJkRtXs7XJxNat51MHzc47300HjywI+L
	VLl9OywF4/G7uNqkfzpKyRpZnHhYfpckq/u5sEtO1HqCC9sdKC03T8cJGx1txWTSDH/xftofJUW
	w5ZuK3D3qcQ1qwc2aTbcAXDAT5HcuBRXjDlFJxh48Rot72veRivI10CI0U0ObupnVI0vdpE4h4L
	EEU8GzWIkJ+nBeSJX/MFzhSHg1v9SI6+hE6QL5xg0C0z+/AgtDxyoc/cNmjHQgRm/olx6SmR8zN
	cSEHOA3W3ao4+uPoc0AyBTT+QSRooJ9F2vYR6cqruJDLQud1nQ5IPxqYhzS8VvV801AhOUdNj7u
	EbA+gGnk8eDe3rd/mzVNS2ufWYpiI8DQxl+hZv820c5duvznU0t0EWRu1fefj4sn4R+affyZTUa
	SU5yA==
X-Received: by 2002:a05:600c:4f8b:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-485564981d8mr105428765e9.0.1773471224016;
        Fri, 13 Mar 2026 23:53:44 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-12-163.dynamic.telemach.net. [86.58.12.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556422338sm40021775e9.7.2026.03.13.23.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 23:53:43 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Yuanshen Cao <alex.caoys@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>
Subject:
 Re: [PATCH v2 2/2] pmdomain: sunxi: Add support for A733 to Allwinner PCK600
 driver
Date: Sat, 14 Mar 2026 07:53:42 +0100
Message-ID: <5083201.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20260305-b4-pck600-a733-v2-2-ba6bbed7d253@gmail.com>
References:
 <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
 <20260305-b4-pck600-a733-v2-2-ba6bbed7d253@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 5. marec 2026 ob 04:34:08 Srednjeevropski standardni =C4=
=8Das je Yuanshen Cao napisal(a):
> The Allwinner A733 PCK600, similar to A523 PCK600, is likely a
> customized version of ARM PCK-600 power controller. It shares the same
> BSP driver with A523. According to the BSP provided by Radxa, unlike
> A523, it doesn't require reset, as well as a different pair of delay
> values.
>=20
> Make reset optional in the sunxi pck600 driver and add support
> for A733.
>=20
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


