Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794575467;
	b=kapFyez92m8Fq3RbaeBQ1YHs4bsTn8OigjTi2DQEUFJec4zF9fnt0EIRymX3vv2gY/22
	 UT+KWD7YX26elB2Cn/7yD+9cXpTrSP5uPzRDsgADNq5uGRF3DVIiUvKFI/HwMnJ9E7mNA
	 lUhdh+mb5B7llm+HlSc4W8pImMnhhbU2F75rwNDDovoQ2Kykj3agkYWlGR8vn4OhEr3Zc
	 3zrKhdysEwIESTtobmt1vGI3krmOM+co0yNMP8GY2s9oFRbrexTc/ab6vZlF++eDlU/eX
	 MidXlmlBrfuzB8hIujJxSE2ixicqXxvzmxR4CuM5q4K6yzQbSowb/JE3aQEq4svomaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=5EDfhwWxpQ0St5vx2S2w041m36SjyznpiiNP0pqBT+Q=;
	b=tBKJc1KAEy32k4R2yv6mL+LnxWuwZ5lLLkMYtjZmgIAD9JJ4AI8KlK8SrgwdYsUGY9/t
	 Z4s8voxL6oLjJ3KamOXycoyn3IuHZwbX7Pc/bA22yDLsXKPVLYCGX7mkX6e/VGKjCU0+W
	 YH4cBFqUWPCp4HigKBE5MRVNg6qQcCPwW7VpyUEuqVsuCzBUdBc8E/Uo8ehacuAOE8j0+
	 K4yaGZjPAG9u1MOneP2qmcxf1IN91nH2rlifq9xt1PWWq3imV2o2GaT4Hql6e6u669ThQ
	 TtSUVoxSYdCFPh6Jw4xAur6Z+QSUaqdXsSDaz93zcqr07YWzmmcGv2ul5+oeij8wjlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AfU/hl7w";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96B606A88F
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC96B606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfU/hl7w
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7987517aso10589245ad.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 05:11:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794575466; cv=none;
        d=google.com; s=arc-20260327;
        b=HH4HNdRyQEr15oNUAzfWVjgJ+ZvDVM3O2fhxZ30LpPGpJPKA8/tCYao50ujZOI8Es0
         jIYUJIaOD8dTpR8tcdz+zi4+xPJ3iP5E0X4VZS4tJk+sWqmXE0erXZPIQrIzzzpTrSxH
         sy1tHhlfRGT9iNmjcw3adFpxDoPTvSodq/g0BKfFNQ3uO+sTzFKwpy80Puxws4+wj8t4
         3wc4ffi3K5K3Yha90ElVpAwAPWRgMk//baQCQ3xRjf5d/fpYD5S8MFuWa59dcYc4jwAz
         cZVVR3ZRqmvnbXDb9TNBlpq3cSjEdMuu046uNJDxQ2SyAFPKLkHdWskrwEbPkae99HUU
         /eWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5EDfhwWxpQ0St5vx2S2w041m36SjyznpiiNP0pqBT+Q=;
        fh=AHPSOQ5STmWjzWiU3pjH47TinlVEPsO4JU/uz6aWNfo=;
        b=b4VpLU5XsFxbJasjeiHmIwWq8DJ9knXENrzP/CJYqLJJPTt2KJq81A7cjd+qYRDrjr
         WBDL8EW8qxZLhDZCR6Cd8vsbYhRhM3VroYxOl1vs/DqOdiO7ZXz3Tjvx5+u8W5Y4IKoI
         Tquxi/D38duV6ud4OXkCQ0Za6scsFceCYNwXpK/jkxXNL79AQFqU8XZqaExMv+tS5mw6
         q+P3V+SHiWaHZE+5HXOYrEwTnIZ8s6JBKBAoFOlRjel94UyMWDGA89jEUAvbHTDR83gU
         zRP4Px0NlYej8OY+IH93j+/dm9HQrFYXt+RZmVe2OJH7o/+5iOXOLoSnGcrIm+9G3Q0m
         IVZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794575466; x=1795180266; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EDfhwWxpQ0St5vx2S2w041m36SjyznpiiNP0pqBT+Q=;
        b=AfU/hl7w5UnA6r6MFc4vCpTbJ8iXugoSKtKGfvL9TlPJUbJVAZoDpuE6Q7tzICMYTp
         y3K01h+7zlBnGuN4np/gTkAM8FycVZnIJ+p1hiDpvdz1R9zQ20WViOqkOl8mZfqWtrJI
         XuGyrfZLDgmoOiVQ7U2YV39vDQNjKJZHIZuHoVSK3aEnZbItNejJnGXgCVcFf115hEGo
         NgfItMzTb4UzIpLQ0NebOxnQYWLE8iFOTKRruC4HbxGeFiS0qXMsg1VZKvzxh687iEs6
         EnFFdZ1SNaVjdV/LXGqixxvcgFxjlwltMmcuKSydj3gjjyyvyuJd1WwemfJgaYVAZKXA
         ir2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575466; x=1795180266;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5EDfhwWxpQ0St5vx2S2w041m36SjyznpiiNP0pqBT+Q=;
        b=Z2dxIbnz4SGm/MFPMmvNoQbm9MJugojBmMoCl2AXEtA56nXMIMhYP/vzb0rAuh8Eza
         w2dR5eqhbwAsAViGNSKk9FzPFczTHx6iP0Ys42Iw9a0iCQBS/Lp6bgyLfUS/jSzy9BUC
         4FOxGHKxZp570C3H2kIdOpOs0sgxfbXDZv0fGfsqypADuAhBrpuWfTZqT3Ya19vHB6Vk
         oWorZlyspu4c61bF+KByMSQ3qiYWGkmMVDwPuuk0Wz5nedTLCKJiI9va1nZozuPUT5ob
         8M9uiZpQYDUoWrFw4dbW7TV7OaapuYaLx39Bay6fYnwyLk2WiIbJkV9yZvkWU0wGZWEu
         +8ag==
X-Forwarded-Encrypted: i=1; AL+hErFQLPq5PKXeJchX8pUV93u6IA/SsjUV2njxH/8ty02/A0w4Sq85aotRBpBy4OAaN7VB0wgt7Ysu1A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+smifQoFASrjkiezM6ze70rpyDxTuYKU0f81VH5OzSBvpOnozJ
	S0+Ey9lQKS1iHFn8vtYJQdoW6n1udLGWLES13o9ZpaBVNJoPoU4TLKhN2izrXNB+1ZVPlZPHYNT
	MmiTUvVi0g/eitozL9RNe9C0Zfa0D2Q==
X-Gm-Gg: AYBFou1hpvPUIqV58BP0B0mp7ePkn1FwO5mUce0Nx2JnkIDOEmMolTnXvXiXDn8DVLz
	1onIfKsP1eL7Qp7feT2GE7A/yQXwSuNLaHuzRddLlPHWRptGmwgM2SLd8PxCA8xYoXwVr3xvpcT
	icAIONVtwknNzAOoErZ5oi6qisioLWfW3q5Cr5TakGpD2wLWj0KCaXVAwklEkGojAuizXK0e529
	+Zw4Zp5isZdSp8Q172zcKHQoAyp5kiyhveAFOnPof2TKTiOelSVvz+ZZB6frDjks+cLajyo8fqn
	sCEU8oeOAKiyQggHkB7DciN7MdDiN1uGNFAEEmMYuvzby2VRliQL8m9p5zDjmhJFXzdimvOKplm
	ZSAG9gMiODaLWpFlMqVq2ogX7pjrMKYNJN7yZ
X-Received: by 2002:a17:902:f683:b0:2e9:776c:d52e with SMTP id
 d9443c01a7336-2ee0dcc305bmr25926855ad.52.1794575466293; Fri, 13 Nov 2026
 05:11:06 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
 <20261111-sm5714-fuel-gauge-v1-2-b9d163fff6ff@gmail.com> <20261113-fuzzy-awesome-shellfish-2d93c0@quoll>
In-Reply-To: <20261113-fuzzy-awesome-shellfish-2d93c0@quoll>
From: Asdlerto Korry <korryasdlerto@gmail.com>
Date: Fri, 13 Nov 2026 15:10:54 +0200
X-Gm-Features: AclHuK8kGqcZvYySC7U7ZlVIw1LS4Jh4WgXC2LRiX4VpQIIOmS6OUnujk91mNpY
Message-ID: <CAARotke5983-NFonNAnLbpzhEU2QZ=mt9CSNi=CdBxVshcpD_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: Add Silicon Mitus SM5714 fuel gauge driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for looking at it. As far as I can see, this series
(<20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>) was sent
only once, on Nov 11, and I could not find an earlier posting of the
SM5714 binding or driver on lore. Could you point me to the one you
mean? If I missed it, sorry for the noise.

Best regards,
Asdlerto
