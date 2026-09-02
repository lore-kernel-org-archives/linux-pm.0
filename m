Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11813BBFBA
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378059; cv=pass; b=RX0nFAYeHB625cOhjX57/pMoBx2UPE+6G1pFcb6Bc+b9t3v32MQicWQNK+6lIuJXqkRrivXg20AmnNeUugtyI5nKDpdJ6wP+qp9cFC0txt0vYTJPU+yAUBkwGzbARMBAhnfTYSFH5o+lWJfyKOK0SAEdDF90RpNDCQhRIfZpuUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378059; c=relaxed/simple;
	bh=eLHTLx0sDJsJ3UdAPIBmpFXK0Itit+qS5fZpvv0jeas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmxagrUY1DKL115yMVvPeQq35lBbQrIsGtZ4zvc8bw0eJGxWjqePY7JH5OjyrsG9O4n1SyJBcfV3pvZMc6b0M3dKklEq5nUz4nnmM+183qzgAAkQ5Fj4MSbXC3n39HOP6VQxtzwZ0egL3RBQfbEE/kuzMfKmDrnjh/rJOfb0hNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUWb/IbW; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUWb/IbW"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1712a04ddaso243625366b.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 12:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788378028; cv=none;
        d=google.com; s=arc-20260327;
        b=PsLA8//ILN4XeppvvTZWSLwPofxZhp9PtyVJyzJcggOsuqcZPFZipb/TIcwrnriObA
         Wbl82lfCrE+OrIIBIFRLcCMCyLEsIoTeVcfWKUfLNntAFflTU6bU+cfgJIJhkpALO7PA
         6aZpmIO7R+piMqqCIUqKsPQxV+xuXrjAvKnmfMT8LA/Tyeu178AdyTtp7fWIdKo4Uhy5
         PzQVNa4YjTzXcQ8ww1hnsSL322ttibJOUznzKrzHkHUzGmyksLov/PiqfqUGLw6LXFRm
         i4Pf1Q5xcwq8/ZxYbqXlhpfIRSGFSAZCvkFnTgn5huKj2wuU0a546nas4MKjHRIldR96
         IS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MqbOVEuyYxeSD2DntBhPNO5j8MUT5Vkh/1ohb7qF7PQ=;
        fh=A4pIwWZtGTo6OmichFzYdmpJ/1fBXO8HaPiQOb0kwVI=;
        b=BoKTWrIyaPdSkz88V6dcrxZbCJv3RINdJbxViv0sjoHT3AIaZ+LJ9ck6pyIYrQO0rV
         6wv3uTkfJF6P+nxuCffQpab2s42ntn35j3KTahgL5M9IBFIOCtBKtZzZ5wBvunWtC5fg
         mgCvRJXMplYZ+GFkJX0X1RO7dhJpJ14weX5795WpYpsg7u+j4d6h3mz/t3vHN8bIFipy
         ymzwzjeDD0cxIp2TQKSb1lfshrMxUjBpB81ybdbbdRjD3WMeJ50L07ajlat4BHVzvOTA
         LmX7ppPjP2+yIGQLmXt0hMFziEPauOeLKRDdPAbxc6sGA2YE1zXhbzzqCprJi7ib4YJj
         8HNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788378028; x=1788982828; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqbOVEuyYxeSD2DntBhPNO5j8MUT5Vkh/1ohb7qF7PQ=;
        b=RUWb/IbWnwRrHbpmkQ/geuHNzbmDZM3cbIFwkfhuVSlkzDe9K+TllRV9sa1zWSFFNs
         P3UEISuLLof4pQVZAJksf7DH0AF2dwvAhkVTxtsCHL69q9dGK1yGxrjV89XvNvcLbc8m
         BqOrHpBBJttj8/slVhrpqfoXgq3JnYrl9wRfF1IvH93PMsBNKVxTqg9Lw/MoDl4YjSST
         WpmBUs8pxfEhgA1UaWwT/3P7AXVuaTtrPumsRcCwNtWxsv1UH5u5Ez+omICA2H14FPdm
         aU8Ee3Gi7M3UfMH3RZa+aoQQrTL0LbBcJBfLlPI1DdLYXaw/ofFUs/TXgvK/a5X6VzOl
         QgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378028; x=1788982828;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MqbOVEuyYxeSD2DntBhPNO5j8MUT5Vkh/1ohb7qF7PQ=;
        b=rrpgf/JLVaA9Uef5ud/7iXJcgPhgh+lnu29xhFlfpX2RSG5nXDCGzRtQLe2AXDP8kn
         XqTbFsRsW3nIJlQXwpZ2fQGu8tcj9X8EZ3bTblv/WF5/v/Pe4484X1iJ+7Velv3zx0L4
         2Bqr+wEU3qvL/qizdhXLRVjCfugKmXwEAe/Vbp/CoHf50boXL1e5i887ESeVKgiAbIr9
         uIAExHrGpTCv7ZDRIq7QPEKaRlUGxZG5g7E60tyfyEHuKUSo3HpIKo3a/4LQZDYIkx77
         70TgTqNLfbPszSZmHCSKd1v/T4/U1/LdItGCP6Y2ik13Slat/Yr24YMW0ZpiZ91w3YXF
         1JyA==
X-Forwarded-Encrypted: i=1; AKwUvBwu8pKBKnZCCrXFJ6ALOFJIphYo0jpBCkotF12+rzQ52G6d+6ZTAohd985H1jOBnutHBRbynAOm0A==@vger.kernel.org
X-Gm-Message-State: AFuF++lRDpji40fhQ8xDTea92+Pzjuv2C8g4Iy/HAh129qwMNyiebS9F
	Za3BKZ7RHRIyc10VxNsNkhaeoD141xMsG+vTNTMyWus05wrjNn+FapCo8EpngM6Is/RZNSINnfc
	lzXAMzR6ijVglNWiELKDxRoI9mi/JCvQ=
X-Gm-Gg: AYBFou396fr4zAMPiMArNsiyVfRLxbL7U2cuJ4KNG5h6YnQ8/sBAeA1rl9LYoxsULNq
	4PeIjAeEjkr1NppP+Kd04ffTPVy6xJAoXGwTNWgoA/3iF6Qd7czOnQ10nyoQM4urswNXNEFKwnd
	11Xh4MuDgD6HKo98L6vp/NPG2eHMbN8SmdAo4sULrBgrNjNVUlyuGimLf3Rpl85skhdpL8btpM5
	bIDghSd60kU1ULUT07UQ1qTbPukC09X4R+Ykc8iIn/J7OxE7Y8wB+gojWY5VCGc+MKy3Lt10lyn
	UpLAZpQ382RroTEapg1iFHTa6/5In3FtBeepFzI8Ij4=
X-Received: by 2002:a17:906:6a06:b0:c25:88e2:fe25 with SMTP id
 a640c23a62f3a-c25d53cd18bmr358830066b.7.1788378027879; Wed, 02 Sep 2026
 12:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820122242.120039-1-l.scorcia@gmail.com> <20260902154616.GA2133376@google.com>
In-Reply-To: <20260902154616.GA2133376@google.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 2 Sep 2026 21:40:16 +0200
X-Gm-Features: AcwNN1Ue5U8Nrt8IK2CbOEno4dpAA-gcYG8T0qYRXxkQ6nYlNe8G_uXeI7qiNIw
Message-ID: <CAORyz2Kt=rKSJW0Q9pFJiBsa6nPGhHdNrsTsHcE4Qxpq5RsSaA@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/9] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What Acks are you waiting on?

Hi, I did not get any Ack for the regulator driver and for the mt6392
dtsi yet (patch #8 and #9).
I just submitted a slightly revised v10 [1] with an improvement to the
main mfd binding, so I think it would be better to "renew" the Ack for
that too.

Thank you!

[1] https://lore.kernel.org/linux-mediatek/20260902193351.185771-1-l.scorcia@gmail.com/T/#t
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
