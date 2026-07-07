Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3E3A75B8
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453398; cv=pass; b=cyDEx/eyDtn9I/xSjtwvWtKDP1CjQ7a+jscpv5sXUzMaQhWJG+d1b/B+DuoD37kOp/UcQJkAk5ZHMKy3eyby1t8Ke3I9UANN4yYs8YWPAQ+q5AG3W7tVSJpMiiqj1x3lfS4cbdO32JVLZxLk6oPD5g6PC/rgrlP+ATi070Ief1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453398; c=relaxed/simple;
	bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6PZqK9uIa8DFbLawe6iB/WjXVJbtlAj7exM9692+E+RwT89bmZ/RvU4/KqwUv6wk+YWElYmV5kMQyZNBrh+b9NObfexI6IWfjIrgfSWtyTP78eN9h32fZKHYAK+BGJ+mxWm7W7zYhtax7Hs0i7Js8FwefxHei4k1t7uKka+cKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=oJ0B5Zbr; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oJ0B5Zbr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso6192321a91.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 12:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783453395; cv=none;
        d=google.com; s=arc-20260327;
        b=Hi/4no83MtnQfTmRWLLlvuU+D09ObXHe3TUizJg30/XBt6qxg0Gu26mnjQbCYBRzpC
         h7bTGQqaaogRmakAnkpl+1TCPEqyDtMe4bNCw6SxZUzvXU2lI9WG9s/0eZnmtEf6XFGG
         EidmRhsOgDh5hQI7vpCc8afMua8oLoyVMjWFk8N1hZj5H60RrF39uZmiIzocQE4VQ7m5
         uM+ZtioTFzNgJVECMmEVxhv3sHpwx1hIeCk64rXYgxweSiEGST6ydeAZ+5TmL3ECIHwy
         iOshyCjJwNMRAOmW+xortNZzoQJtE/9k5Oo/qkd2T0at4YIjI7osa130Uk/8zT2OFF+4
         O98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
        fh=CuiEWonSK5sZpZOsoOVyJ59SEv1wgROspzJRkGllHuU=;
        b=bXdJjKtPtq6ar0Yr7Z90/2sQRlTZs7eIgZf5s2/MWabzvNXyiJl0TngtB86YlGpVET
         626z/BMYNqhij81tlBunjqO3IGWPsDt3M1feeVjrvt9jbf8WlTktXFK+v4hMbzCxR4XD
         mc1OeJQhDglPP4YQ3MKFi8o1K/7K9/7N+DT7jgG49Vth9hpqjj2aTM9tcOPk7GXqKXt3
         mIgQfbn5Gj+bUQH8mVeMeIFRdsLagYEzfffdvXb40Zbad40AwnYPTBztTXlXQRpzKHwb
         D5Imupd2Gfw0B6MqRj1RJnIjDHfMXB7f9IRYcauQcYKiMwZzNMu2/nxKlfI2FAlcWkTQ
         919Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783453395; x=1784058195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
        b=oJ0B5Zbre6HTT3jrkz0hMxuvszMlU63D2dvVJ2nCJQdJ3SVYK6M/ulhU2/cVj+q7Lq
         ytwtfaPsV/tvSD3kW9iH/kNmENeLEr9e7wBa1/D02dArtChwOQbbcnX9DpZlipM3JSg+
         ihsI9nUyb9X5AXsVSX9zCQQwLMBvT5hnUp19dtng5omY4FeF3/+xYRW2Qat8/XTIeYkb
         ab7F7pyqLSMTyPbfE+8Qicxys/NRw/OpM42t1zwrLZWxu9hJ/+6bgDoEXQcZDd9f6EiE
         SetiSVfHtAsl0wPRXdzYtX0kYE+P3FbCpseZ4p153m+bHYvESuVkwWSciyBh78/OSwOO
         9j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453395; x=1784058195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
        b=p8k9kM9V97ojwtp9YtzwdGQN44l+Ay9Fjsh08hdDmBYYNIdOdb16iYWh9T42GCvAod
         TvOGT7Mm4sBDT/H3IDNojq2MBJJmpQihbFr0ENVSAhXD1v6R8uPe+jJbfCGSxscPfInQ
         1pHVEeggHAAvZ4JNj/Ohh15FYJWwt58G6twSo55SjxX/uSkEN8u9Bx92WKmd03Ybv3oq
         bi4hjEI0mrMtB3J3pfA/YMP3AR53UQsZxO73lYdJ4RZYqaoW1QgMe+LkVxiKCz0UWsUZ
         0euVe2bzm3z9laMhP+7+KOmfJ7/Q/yiL29pC79jaRQLz/vBvj/QKHhR4eK5H3pAltCil
         hofg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4BuQ6UTu9Z0crmdDYYwl9PWpN0KRLcfg2pTcpyfbmexC5nDb18E516CuDmH01LmUEGG5uDDuWkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysmop/MiZeB4HfQVfprZYecrnZ6W1jeC/ZDCK/VsIIMlmRKcei
	TCxL+GF9k3G5JbZPRDGJ+ix1b0GZlxEFzFxDId0ZQrpNt8XsqCbr+fKK8eFHhe38IfXAUY1gH09
	E5lEcBeHhPQ35oYAGXrAS4ZAKE+mNnSU=
X-Gm-Gg: AfdE7cnvBiKo/g+k+F6pyB8117NFPtgkyOXdgyeF5Z83IaZjAOqAp4aGf+w1LXZrj77
	tO3eWgyPL03lsFmDVXot17j1IVCfUyOhu0ul4+SBbj7zdbm1zXYo/sRpGiFFAt2y9EwXMcFGWzW
	qp5LyoefcmGV61uByXkgSkZzXHO8ti75AlEska4bI/wpUL9f8cvPldNWyaF4t6yJrTJleyahSWu
	26kzgHIIITifv5bLlOUlqiMthNHlZuF4TNG/zUDebaE8eRWgPsdTns6yOmzM0o7otWOLPRIjxN5
	kZvJEjK9JDDA6YhD7o14OgduCQ==
X-Received: by 2002:a17:90b:538e:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-387581641f9mr6285677a91.17.1783453395185; Tue, 07 Jul 2026
 12:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr> <20260702-add-mcu-fan-khadas-vim4-v8-7-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-7-244feee91a36@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 7 Jul 2026 21:43:03 +0200
X-Gm-Features: AVVi8Cedwny1fGm0XunQLag-buYK9YXt9UTwEp4HfqUu3ncRpwQYM0HDkqsD-q4
Message-ID: <CAFBinCAejsnBhUy6TZwjgNzuVp8Pa-vTB88NBgzNVcDSAyyenw@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] arm64: dts: amlogic: t7: Add i2c controller node
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
> Add the T7 i2c controller node used by the Khadas VIM4
> for MCU communication.
>
> Use amlogic,meson-axg-i2c as fallback compatible.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
