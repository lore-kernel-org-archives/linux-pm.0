Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663473E2752
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946175; cv=pass; b=NJcIg5yYKeUCm9Vg7+W20kHLpSUz+crAEdBB47AVHIN/XP1tD5LYnbSiQGyjs5YWcGJhkx1PFnnUE5dLU0u2m0pm35W3D+KDJaVBNh2PZTO75xDSn85bJY5z3KWpQ1y9/jHeiuX3yNcb6Xq4AEUol02g2vSuq9iigZ+XmBlFgjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946175; c=relaxed/simple;
	bh=XVn2QcmjcQjFkVK1YggfjpxaDDncirg+Y3RdNmPE/+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qf3HvpMYl4L2In4klygXINCbygTaHtzUynJYPQ+ntzWjDV8OqjiyrasqBmIT6rjXvbep6D6+Hk1xKo9cqvkAO1Ginj10Mi1Qmy1U++jQBiDkDE+o4oIwHXSakRqYoGUXFkHlcBdptkGEvoIXlLOJgvlBtFzN1rARBqw8XMX3NSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+mjZTkM; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+mjZTkM"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9c04152730so20113766b.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 01:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774946172; cv=none;
        d=google.com; s=arc-20240605;
        b=BKm8soWpwL9sTxgmSMp5Eg+FQWF1YXy1vCq3aVg4UTf99Z3ReL1GVaGBCYxdKqfOcx
         CsHSSOul8Fm7Cb3hAQAioYKbuvjk9mRnRD/uIM4XIu/xemgzZYCy3mukPxNLBzoyeG7o
         n0L9mIPokEHUW0MelLCrYS8S4cUUUUXWKOhoymuZlO39n7/QWcFNczLXq2m0ja0TvxYK
         vg2kGvF7ucl2s5h0TfZZaQERM+9ftRFLqmGJ/eBtzTgGrdOrRNNO7qBsicGAXyLv1Bcp
         OFQAIBG2XtTMqlrn3tm8YU8h8//z/v977hB5RfoTnPeKfihiarHrhYkt45zqqV3FNasW
         Y6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L3TSuB1FbI7lqYJC1uY7y+dtfsWxR+6ey/FSJ/giDGM=;
        fh=IOufYlig+UJ2Jm24l79acyLSFWrCboyUOPWioSfyBcw=;
        b=ElFgU6JR1nHeiIJuSHnmc3dQzol07+gVsshcEdVhUgs6xvrpMTjnJyrSiYj+kyRJp5
         IDAmdOirxPpc1dU8K4prHiExwJlWyIeJOwv8L5uMKeDzFpGRDxmScbciy5OYgU+hZScM
         NJMC5d/+bBkykXGhSuhTsn26oQjPMr+nNw9grymzrn5A+p73mMm0YUF8WnrBRxULcQD6
         yp2U10Zo4ZoTBdBXtcEs8eiGW/umHVRgecKH9bFQEq0TPfqLJlYccCHeOjyaOP0ziGxO
         pflxI2I3AjeYR3jUmCnG7Lr5dcNJahU0LF3uT7e2YRlu/EXNWx/qfecvwagktNDhzMOk
         S4kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774946172; x=1775550972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3TSuB1FbI7lqYJC1uY7y+dtfsWxR+6ey/FSJ/giDGM=;
        b=L+mjZTkMhikoveXVS1doON1iA1D3e19kfJZdouvzvYjjCPs/Ox04vxuqTbHSBKdSmV
         ijzCACmhOB8z87E+xJGzEsmDKjEmXyZpcjBDQu20B+9pmLPVkF3yGnXCMv2iT4yM0+rl
         UisC10rV3oTOuBJjPJkEKe8C2wrlXqN5ZWuoeaeag8EleBfREB/CfMh9tbMsQEQzV9Oq
         2Zmm3ciexDl+gwr6RCPdgTmPgLplOkSvhRb1pYOpi7ylQOEmqHPU9cpxeutJkskX3aVw
         we7CjQ6vN46t+XJp/YOMcWWwMk5ZCF6RUK7UUq8UhLrCQ7yk+AFwH/kQCnElpUKajMdW
         JLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946172; x=1775550972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3TSuB1FbI7lqYJC1uY7y+dtfsWxR+6ey/FSJ/giDGM=;
        b=BZeBKmq3teshfFUZREQC+oAad4ngPaVrrmyaKRlSimYNtl1cXH7W3/GGlafMqOcHmv
         gkJqjfbIowqNZblXbMv1TOJVkqmwB5611vpX+Moq0faBrDTulLJto745nkC3J7VfQy/p
         CiiEf0MPjSDKoZAaXW6t0QxQR7II0IQeXkJhVkvAng6OJUEefCkE7ZXlyoBx4GWo84pH
         xWRJ9Kfu7q8ZvcR2TZ0eKn0ONKTqorooP8Zp6U18tbmHoMwvM0O00gNgTTk3esoVufuv
         ekXCFeCX+BOulT3yAsfu/nNKrZs64qm0wD5lc0VQKFcJtY9eNb7JXsBaUD+dc+F7HxUD
         ungw==
X-Forwarded-Encrypted: i=1; AJvYcCUswdLfeQ0+Gyndloxyda7PuIwv1HVSJZ8b/A8DzzxlMrS0yD+nbOi0yckBOxZ4Auv0nrpG3B7OLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0eSWyW6gX4UVfdLnKHnASthK9Svf4lS3EarVmDM2+NHhNnOI
	99LdZfKyE2z1qZE7aRplc6o6QnXgrWHhsOfKkga+sauYo2ekxBtOpl/IpaHd5dRtSxN05NkQL/7
	Wr68r1S5d+fjvLbeuI5es43Gh53hOwKM=
X-Gm-Gg: ATEYQzydghmj/mpB+6OYyHG/ygpMkW24pcTRvZm0pPyRGeQ9ctejXaFLA+WtA78Yirk
	D1jukRmzs4xLPiyf7pOcdx2D2iuk2Q18HEGlpvDFsIrsCu15xIcSx5rfIOz3+BGw0x4Gywwdx9l
	3MuyPhcyJRIgi8x1ZgTU2PN6jfQdAtfktFUGsgfHR9sh5BZe0Ad7pe3B9tzSTFY0mi85dlYIlrt
	vZ9GbCjFKpZEeaL6AqYtd2IJDktFdva8Bp2Ckd3VGq5G/nQ6dj/ZMwY3h71+K48lTKkl1xwnqYk
	GrH8dQ==
X-Received: by 2002:a17:907:da7:b0:b9b:fa57:d5b2 with SMTP id
 a640c23a62f3a-b9bfa57d98amr71812766b.42.1774946171488; Tue, 31 Mar 2026
 01:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330083429.359819-1-l.scorcia@gmail.com> <20260330083429.359819-2-l.scorcia@gmail.com>
 <20260331-flawless-bronze-lorikeet-59a6ff@quoll>
In-Reply-To: <20260331-flawless-bronze-lorikeet-59a6ff@quoll>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Tue, 31 Mar 2026 10:36:00 +0200
X-Gm-Features: AQROBzCHGHvki3QPtgYv0FgcoeVoJGVuIm0WEFEat61ZeqaJ2itNlZb_JB2hAws
Message-ID: <CAORyz2+1bc9Z-opoNqyUU_WFzyXZKGQmR_Ur=4UonOC=AWtQ8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -    required:
> > -      - compatible
>
> Not really, this affects existing ABI and might make the child schema
> being applied. Basically regulators node can be anything now.
>
> This is definitely not a binding we want. The syntax for parent schema
> when listing only compatibles is requiring this compatible. You cannot
> have here whatever empty node.

Hi, it felt quite strange to me too, but that's what I thought you
meant with your previous suggestion [1].
To keep the required attribute I would be happy to reintroduce the
compatible here, in the regulator schema and the pmic dtsi.

Before I do that and resubmit, could you please help me understand
what you meant before?

Thank you!

[1] https://lists.infradead.org/pipermail/linux-mediatek/2026-March/105060.html
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
