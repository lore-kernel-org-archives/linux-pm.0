Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662F26C385
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782028537; cv=pass; b=TaAe9dxMlHYrCRJwETgOHrKR85NZo4KjR2ZHHf/1BMYaD5iMKY79+7quOPXZ6gki/shmskidXhsfITeRnvC7iVJl1VUamKjWbe8HW/kIUqXtTFf5C+imda6NaNuwVA8G6/nbKD6X8S2Cx+Yt5dkcr2NRytY/qaLP89ObpkQA5aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782028537; c=relaxed/simple;
	bh=bT+kSAr+cktWWhCVIYao26NUUMqDDZx8mDGFg9kSW1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcUsJqKno3h3E1dbAqCulr4+j3Zf2l7GHKAUZAlKneyDe9xm3QTHq/fluo2yosP4UlCX83S6FyaZOFc9nR7vJgbaUpnuIL934f+rf6J8izH5gUHnZ8jrtNUjI2XsVD2WJV+6MxkCCKb9CC56QR46eg3m/aPVqMvQSypwU5uxm84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWEeaYI4; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWEeaYI4"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c074ac8adaaso399266566b.3
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 00:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782028535; cv=none;
        d=google.com; s=arc-20240605;
        b=buuyZDyHSaQm0kF21/cRu6h0gqxM3f1xni/sTKMXCJMB3btbyP75S1cFwyoFaR3Gn4
         uiqP1PXdfhqfYjaWALHyJ5sFWDcI5zIOOOnGj/9ravE4z+91GGb/G/j60BXYtgU8xN0f
         TH8GtEEpl2YzIUvP/FWB+ToDAzzOA12WUJGlYbKmZzmTf35o4Im/EImyKB0T+0ut7sYr
         r1JgKuHK4T2wIri7XdsaIp3sjsOpsnmnpXJMysrjxtFflfyv4va0kfLdq6nSIyAdt0VY
         OuUaYES0agTbhqKhryDzIipC3PywlbR/9F92SdVpgncq50gkwW4sfUDg24f/NYQjUhfg
         pnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hMvYItPyzRe1gzBuo0wIhzY+wWucW3fQKtqTXdUcD40=;
        fh=93xzQRDTjJGM/HVjTVe1N+a+8cDbXi7wYbCOsiUE/v4=;
        b=A/UQVzgeRzGUvXW77JVQhbT9RqfcSr+z62atbTIW5be1FqysJhNqI3rtYZkMOxwN/R
         umia0X60IfxvcxasF5TBWx1WSB6ZaDM0euDqj3x6b3AzDhzlglgFDRc/u6ss0TctgLht
         kL6D3Be7JQL4zWHGZAhrS6lJ5YTuf/Zny8nfZd9YSVC4MNhbxZYkiNDMF34oxjNE+6r/
         Ig5e96a0qjuEhOkk3TpuoSkXm+hedeQMWIn2MVKriQ9QsjttXVDj61OsSMN9pmsXm8l9
         EyBi1MEkSLrj78qgDxp2Pr0XtwNNAp+3e42ifuVkeovL5ezoI4QWEmfqdTTRKFaSoDQq
         Rs+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782028535; x=1782633335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMvYItPyzRe1gzBuo0wIhzY+wWucW3fQKtqTXdUcD40=;
        b=GWEeaYI4Aj8KgcCRXTTzwq52W1u6Pqo7eXhek1TWd9OFtwcLeoVDQayNGJqN1PTZ5o
         LmbGGOnxQFPOyKSL0A2kQWfrYRbx65JLmx0GZVLkPR3NLR9t4XmNcLXA2OeiU987zTlq
         L6Uwgxp/Q6g+Ob/bTBC6w+efIZok3c8gFKvzCFCbHeRX66C9Sz0CVDuDSi8lHDyHf1rt
         xS9z08vI8/ga+FEruWmiR0byDj3mrKFyTJU+SeHGI8/snB3x+Exsvcbh1HIsraw+a+5W
         OhGpQoCTIwCq/Jcfx0vVQwRerIdMdapgWPId1O2cmI6ffshz/etILyYmZcbUGobNkvfW
         6ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782028535; x=1782633335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMvYItPyzRe1gzBuo0wIhzY+wWucW3fQKtqTXdUcD40=;
        b=CLDr7FPafj0JsnxmfwMSHMVmZa0lNFbFWnpLcWIC5d28HAvXxjz/jhRSvRQkeKaf6m
         o5Ooubf0XUQaxpo6G3WW6pUsWM2SC4KhzS1g/I4hVJOBQEEV6CD87qbZzr4ww+VAB2ZR
         aqDTPtt3+wrBAPNSzAOiJWb4sYzp4puss6dIjCnInl5oumq8PgRimfHNrP9Q5T+mCWBm
         5sUk7N/WWWHRlz4gqnoKLScZRahKdIYn+YTO9Jviq32OyjDoHohUeh7H1Z0eHlaXDXwY
         KWHssEQJVTlYT/Wh2wqoSBM36AWtwKmrSrjosHh6NR1vKlpoo2W1cB/2sssxCFaeTlCV
         HH5w==
X-Forwarded-Encrypted: i=1; AFNElJ9XjzK8nKhQiq4LCUfX6pV4ukfLKhpN8AGVul4Wj/BCTMvIPdN2SoiAFUaX1UFC49ipCWq5l65MVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgrGZHOMamhy3RehQ/yeHFOAk8bEypD2/WagrQ4D5X9jorH9M
	kHlpvf/mDhHZHxV9TvgSMBto/TgX8veJm/ST/dLKfWGPJxF7j3R1AjoMNnCiEFsFYaN+ajxvDK0
	3wUyUnr/VEd3O+dIGKxckcy64TRZQ/1M=
X-Gm-Gg: AfdE7ckXtBc6rz68JirYy+cCm70d/n2Uu+eiT9xbd8Hu1oWZpcrkTHBfo/5Djdfe6a3
	8R/URdisk77g+I6NVIw8/J1PyqKO3iLT/QCW1g/7tv7z47yBCkLm9uC4Uej2azYpxaWfR+pwL77
	7t6uHVgpjm29++thDAfJhndAPwd1zzwVlcjcdo5orUAg+IgVmK0anhKys2b3ViXYNikyXX1Ihai
	yplc+Yfv3nKhTcw+Ogxqkt9Oc/JGCA1aFqxxl1NkJ9sPrAJdr6zYrtGUPGGK2TlA8gPr7vi0QDN
	w8sphsSRkSgnYbsboK2FoNDZP235
X-Received: by 2002:a17:907:6d27:b0:bdf:8e2a:1092 with SMTP id
 a640c23a62f3a-c097adb13f9mr573581866b.3.1782028534767; Sun, 21 Jun 2026
 00:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620200032.334192-1-l.scorcia@gmail.com>
In-Reply-To: <20260620200032.334192-1-l.scorcia@gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Sun, 21 Jun 2026 09:55:23 +0200
X-Gm-Features: AVVi8CfSZq6Enj-XJKx5vjhFc4xd-jMn2ZAzgLd4cUoBxN01IhUJaqR7lto47H4
Message-ID: <CAORyz2KB3jaRc5EFhDSuPox794UUeDgT5kRFe=jFg_rXuR9eSQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Add support for MT6392 PMIC
To: linux-mediatek@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Val Packett <val@packett.cool>, Julien Massot <julien.massot@collabora.com>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko review of v8 pointed out some easy-to-fix but real issues.
Please ignore this series as I have fixed them and I will send out v9.
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
