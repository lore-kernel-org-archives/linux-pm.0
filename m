Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2973B27FE
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453481; cv=pass; b=Ne0w+Ce8Nk+V6peEApMJPkyeYtaYwzI0E7Oc7uO1VEF/YdYEFcM0wfQvYZiWU0XLo0RQKGbAybZtGe0wpCAoAA6moynbsfDN21Eyafcf6orKNnBMaTm5HRu2eCfpNOCDyXkaU/FwBUk2MrC0xuhjtlKCQviCVPdYAAOJeXv4o+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453481; c=relaxed/simple;
	bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYzfRWrYEu9AzCBWrKUwB/Y9lPlJKXxHAgNhquL9yCSTSpJZGMFMnG6gm7eNdz1NGAs0XlFNao28OXHOv+yVpYYvkzUCw/La83ZjgulwC+E+H5UTNPLfAC7KNqxPXr8r9EqKrdlROBAK/qrtEX2xzu2WGFU8vWMtoyv/PvR6HRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WE+3jIY4; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WE+3jIY4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc80b585bfso24151595ad.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 12:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783453479; cv=none;
        d=google.com; s=arc-20260327;
        b=P+XPhHtuVUrBxgq8npO6Dl02YK+yq1kLu4MM6mDtdpwgvFpxwb1mjIOyrheKmulI1y
         Tv+cYrwyLiOvtEXNG2hcTO6uvSKKqNwRZxp5iRuwAfjOJl8Qba263bbd5KUtPc1vf7Tv
         bT4V06moZMUkxjmIa/XyADkX9q/yjo4oH7OSRQ1qvpR5ktakJTqy8GbgttJfdPmkVOeG
         3huxZq76ePG1CSqTSXHWyfzVB0Fg3F2LV9sFYksMdFPoMYVflQjx0DxOv9r8iPcmM/oU
         Vk43IIPF75gnHrWO2CS0gKt8nnWP4rZ6EjD//Ei1F1fD/3dhR5taiXLidCi7dNiOCXY9
         lSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
        fh=8jFBNEMqebRF3BJOuvkLSzaODxmBJG4twODjqECHCcU=;
        b=CZ41Lo5opQiGZEBrl8rVIpH+Apxh537cXIdzWRHuOHfq5yVs8e2+vZ4xQ9DQHnVnEu
         iQQqUAYj/FM7KtqF6iPX9fXxBQGRozjsegx5r88eo/40KXGqvT63KIvh0zH1FfHTUM8y
         E3uscyTxFj+rfwyrwha1NDemkCpQ6rkxTDnoDCCXKGGY95OW+OqH7iWAE/F4/bnw5iDl
         n+wMQ2XJGCz4jDy+LPoSa18qGnqr27hZXF1pgkUlCpppuDjzqdF+bOoJbL7zjxtkCCYh
         tTuq9tE8nfVQqqVCy6+i7wWIrcPLX1Tkb7QKGR9mPVNeOhYj/dJz5F4AuKfMBmhx/7+F
         hs3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783453479; x=1784058279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
        b=WE+3jIY45ci/rBMurJZg2VwgMrWEbxYXopp5BltcxQEDx7iv/3KqBhQ2lt+uWEVL4d
         f7kxbXq0icZoDmFobfF407EC0zL00Q4vBUuTM6Qup5q8EPZg48y9qWZ7aG59ZEgkrPM0
         vT4vNuUbDOw5KPTKjpWp3uRtfsN7A60o21VtnxmrFv49zxTSHJcZdRa/4s2KJm+L0dtv
         SyWe7mu2Dh10HbgRdTFxaGgNYqpxFyFLzzbw99OYwO3GuC0bt3yWXYqDxxfKsdOu8Fy3
         75prGzK+xRqO/YOwHRSel34rT4ynFi5fEhp0H5WTv5BBap0hz+KR2TipZB548MDd3+MK
         Cg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453479; x=1784058279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
        b=WUwt1Mmr9h0leg1LO6if8bDyfIGOYNWC24xUrNUIOC6GTckR+zaG7pDpJuxgCGAt+e
         wGvh8BBRqLWHt9VdlbZMJfO9C6QK+ewuEcYp2Cjgq7t5XjWEo8EEeXHkS0hW+I9S+QcO
         d1vuJOu6xJZxgjjLl2wxLlqWa/1qh41xfXaxCVcyAl1Ei8g+qCKj/6mpWQvLBDc1F589
         PgD/rv+jzIaMpEfqgGSea0XuJGQywfQH6/OT08VcX8pkTfanew1LVgJCHYxbs/0MCLJW
         owF96ILm8mdDw0chnpIzuaCcmVQ4ScjRybp1gg67hoYFwe5eX2r1yhHAmmeI1pOLAVMG
         ba5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqegepC0dlYTOTlV7HaxpHMRoo2em0uZr5okcOpqia63HMq5w6OhFRDzbLyQ9gCyE/WUmm0XMG/HA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vkArtAGkwBN2RWLWA5vJ4907jo75yQmcZkrj/S76agKjU6GK
	kNQvPYsoB89i5jRTvBFpn66A3d8Fjsy6gt3uQeuwCi5Y/yaVEAZSIpth4SvSmGsrOOD3HJM0Cac
	Oc9Y9XiZkYKlL5jY2WNCfU7CeBGBFblQ=
X-Gm-Gg: AfdE7cnyupz4PJioCGdavEhzEU/3HUMRV0JwhBWHc/asQOzdvMn2+Hg9WJR5tegaZcX
	XZ7aZlbur996ZOxqdVOLcF8sHvisEHef8YfmiSHCdhXcAuO+ffNa2LkglT+5klO0DvrKyhyLG+n
	9FvsjtuCHppne2cN99bQSCxBnakK6XgmXyABC9DruambhvwnQfQiN73aRWiPNy292lMrRE3DKX8
	gn1RIIimrFunsLy+InT89rLbrJ1ZhN/yTn8Mih1AgXT2EGTTlF5cpM0hQbQ+rZUXUmOwGarvTJN
	TqJzhLXDwCCFbs7KgAjdO8L0dw==
X-Received: by 2002:a17:902:f645:b0:2ca:9d5a:8b6c with SMTP id
 d9443c01a7336-2ccbe3fcc82mr64122445ad.5.1783453479150; Tue, 07 Jul 2026
 12:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr> <20260702-add-mcu-fan-khadas-vim4-v8-8-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-8-244feee91a36@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 7 Jul 2026 21:44:28 +0200
X-Gm-Features: AVVi8CdKrhqOEXxfOyDGizCGSCM2_7htBspGi7RIbYxEuj_pMgbN59CYzvH2GP4
Message-ID: <CAFBinCCkpgta_QfqDzye2cD46_Wad=2FO=oBcw9_zkxzQp3OAA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 11:57=E2=80=AFAM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> Enable and configure i2c MCU node to get fan working on Khadas VIM4.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
