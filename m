Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685701;
	b=5YOswFFBjiLPUswgQqN+/HK2Rg+QOWs6W5eoFWZOCDb3msu5lp4HExNsZEv3wkUItlJ/
	 MSWmuJc9RarARAWt8Dk38LmE3eAjnM3CUJ79E6yP/COa4E7XDJb3thdKDK9Asv7t4JAZE
	 TByagQXRMXXhIliaNa0injdZPt1sitFzJkO2tm/62nwnqN4KL/MmVWpDJ8h3d+Ff/jrHU
	 HDhCKlynx1tMG/OT5V9JXqG+T9QkZsXRoL2foUQNKHT4LgwFESmLisNGwlm4zGfJBaiuA
	 anQgflblIbIHIscZW/g+LsAflGVLpobpiDKCEJV6jm+lQxRGCLP8Sw9OFLtvgEe4Cbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jbC3rUGQWeTwHayyjYJnJpd8X4fWTqcce/6NLkXV61U=;
	b=yyXEbHR2FJGmaenbobNFwCkeYQ2h1JuJk57bv8W4mFAG3pXoqDkehVBxplSKHbeXqvz8
	 zBdzTijjj8nCwOJ5hJenNbDK7ZUz91S0vB34Bes0yRgSizJAk8IQueZyK+Dm4oHbFi5Gc
	 O+UO52KNkQJjS0AXHYUMrnUlYCwibC2Lu3KilmmEMHE3yUzc9qJoW0B1D4PRwXU7v5v8V
	 XF3A+p6Ny3aEkJO21H086qVbCZvVxk6dW3x7YTgKcmewTrxO6eCQANS9998EoJXKCpSg/
	 3YG1BoYX4Jg8ujLJ6ovg+PuxGwBhMe2d+Pvl4XFBBm0MtWr+JwkEVedCtq9EQIHoS2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qm4LG9my;
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622CD606A323
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 19:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 622CD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qm4LG9my
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ae25dcbd81so23994191fa.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794685699; x=1795290499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jbC3rUGQWeTwHayyjYJnJpd8X4fWTqcce/6NLkXV61U=;
        b=qm4LG9myJ4GdeE6hPirnsY83dnXwNP/Mfy/YXKt/8CVfD/ivz7SvQoEzH3HbAkWYR0
         Y5cTfvVR7k8xE5T37tAlMk/2TFrOaTo8LbZwTQOhx3W7/2zvWIOgJMWMeg1eEy9kyFdv
         sr5i0Rj4RdMA8+w+d3SIB4WgmgUYHlCCJl+PbrhUjbXZMp6NshVuXMCnjAUuhTnEJmjZ
         DinWMJGcVzSFUoKJDANdahFPdOiLjujdo70V9B5RorIY4yotbfoF4YCp4l9AaMnW3s2X
         iZKQiREYGcdB/gdGWTtHz0XpOFmFxpt9sNr+YyTf0vL82YbZeZrF+bAbuk/ek7MYio0O
         NVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794685699; x=1795290499;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbC3rUGQWeTwHayyjYJnJpd8X4fWTqcce/6NLkXV61U=;
        b=rOi1P/inUv5y55PCpAK5b83dLedFvoRW1W5L7XpJMgcJREWUPXNYeyEZEQJZ/Gg23P
         VTK+h4pYiTUc+Bg1G9T+SKAlWzCnbTvVCBLrjP3wmdYkcfO08IENpFHbOTzgiUenb26W
         dUXJAcZpkTpoRGvyQ2mVWe+NMpMCtD3yeaZQJTTscDYNFiLIcQTXxQ4Ky/Am+uKlgsPf
         Mz/d4gT8wmKZpyYtYHTm0i1Mq9ds+5+vr/UzDgI6iAK/efPdbCv7nkYOjL0dE2UjX7h1
         fC4bZbmDaE1OY5T6IhIeVldilVCNCPKIhMU+KUVq8Y0MwhwTxv0+BhILrRfvPra/Vjze
         e/cg==
X-Forwarded-Encrypted: i=1; AL+hErGXg0crNCRbUhbE7CwHNLb6LTZI3ZAZdoziWE407tFra/JJKpeG600FwkI7isLb/sv5llmmLD6paA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/RQXiODBmO2xlvlKtM0JWOSnAFTOGFvmR1p8iRXl07g3CRv+1k
	vICkUKi3pRNVARS/3ehFUvoHeDtxa6fjGmpHOuKeTFSDgzkTqyo2QK2QAC9sHzo=
X-Gm-Gg: AYBFou3wab12suZKLYNJsAd+da7cLOw2vDTaXraOpgX/MPGv9flHBMEI6Av1lI9Itpy
	DV5Q5gzJhoY9JjTy6vHMtl9iUTO0bTzJfUISkzSYPjOVDqWBpMXZu7/cDOlcp2jOsQFX/vIjwtE
	NdpKQSXR9yQDUTu51BJVdQw3nuoy0ZJ9yCXFQHgOzkP5KvrsuD3jyaPkj03mlE+cG8JEfHf22DL
	5WszqO3Hxnct6XS2+69HAEMfWHRh3pGn7SCZz7mcXP3J9QWilwNMo20eQF5QW5YYCjkyhkXNQZX
	peRVDS4z3+eGha7cOphLG9+C4x/TONLCDGh3UB4VPKdRBLg4/1UGd+ie2VwnniAMSE12C/Ypxs8
	yJwbHg5UWy8vtirveSYtF5irQia+vf1Kb3zTmloldy/SLLKrn6tnB9mezlhP15nUcsuQhmq9f2F
	FKwvvXBQ1pedkgc91KBi2VD3cdzYoBD/FUHMdvG7LxPOQO9ItiEtqqy5i5LqYWix0RZPq5QbZDS
	D2dUlRFMveDiksbIyKNpLRCrqgTqVIxDbjYBPBSojU0WPYUM6aDLsGtNVpstaj8ivNEuEBF/AWe
	+XWVXvLu8ddktiwGOMiaEGCBz6+LlXETmwc=
X-Received: by 2002:a05:651c:1589:b0:3ac:f258:6199 with SMTP id 38308e7fff4ca-3ae2b676808mr18455371fa.22.1794685699382;
        Sat, 14 Nov 2026 11:48:19 -0800 (PST)
Received: from sasha-User.lan ([185.159.163.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133c9ebsm1845666e87.31.2026.11.14.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:48:18 -0800 (PST)
From: Asdlerto Korry <korryasdlerto@gmail.com>
To: Nizat Mikayilli <nacht@dxdmail.cc>
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
Date: Sat, 14 Nov 2026 21:48:00 +0200
Message-Id: <20261114194800.503418-1-korryasdlerto@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
References: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Nizat,

I tested this series on a Samsung Galaxy M52 5G (SM-M526B, sm7325),
where the SM5714 fuel gauge sits at 0x71 on a QUP I2C bus.

The driver binds and the readings match what I get with the vendor
setup: on USB it reports Charging with a positive current, unplugged
it reports Discharging (around -400 mA, 3.80 V), and upower picks up
the battery and percentage correctly.

Tested-by: Asdlerto Korry <korryasdlerto@gmail.com> # Samsung Galaxy M52 5G

A few notes, none of them blocking:

- The capacity truncates (SOC >> 8). With the raw SOC at about 44.6 %
  it reports 44, while rounding would give 45. Rounding might match
  the vendor UI better, but either is fine.

- The M52 has a battery NTC on an ADC channel. If you're interested,
  I could send a follow-up on top of your series that adds TEMP through
  io-channels, and VOLTAGE_OCV from the gauge, once this is merged.

Thanks for working on this!

Asdlerto
