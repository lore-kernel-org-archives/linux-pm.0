Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089352;
	b=xDq9bDKPXkS8hdGtkJ6IbYXQTXA+ZZtP8wwgvvisJrJZVSX18RyAm1rigux6YTmTENMZ
	 T06bZbGHgbQfPbDK6Lw4w/UcsOiEdZh2h/gQ7BrOOc9RxmvcUc8LxufPR1yxdJjrDCAAU
	 Z2m87ebMaXXwFLxBXRvHiXkH1fhTH3gLQsfoBCgIJ1qqyG/hKo5UbQhe0KIeh7Mh9JH5I
	 eQcVnY7INkQUnrqv1JtsiO/Apmed1T0NY9VhkIw0zXke1c8ySpXC0WmB/RorCeR4rhlb7
	 wSocioeKiDrDLEpYUB9VRxF0rmwpkp0GaiKUYjuZ4EOygPnKCgtHGPoVHqt4pxxxL0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+q+RfQ5Kwv1XNt4YuEC2Y4+X+a7USu5opNal/bTFsOw=;
	b=4oMkR4n/bqcZG2CJZEXtIJSv5eTq9EOndILvoiJ+uUbMSZ5sxJSnitvrdx9tTjNFTO3v
	 nRWByAYr5uGGj1FWUdqJsYxYahy16lY2wN5oZfxe1phFyn2A+IVYvsPPXkC4o6khvcUQO
	 EW0lM2VXdXtTaAG8E0ge7XxLehjGjPdAekvKRNDlTvTicEVlbR/m+qCnIyJocdi/Nskfm
	 XzoNzzwHOy67EStbd7HsS9yER7KRmfc7xoLukcVCWjFB/zAcQM0IBRkZzos5ql5MxRjvb
	 tVawkvWWtVBNi43ge8PFVdKx+oIyNvlr+WYdf7YzqxMmzdfoYGDkK+qxCslsXPK9dng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZurG5xut;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB6606A328
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 08:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18DB6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZurG5xut
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35829219da8so940778eec.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089351; x=1793694151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+q+RfQ5Kwv1XNt4YuEC2Y4+X+a7USu5opNal/bTFsOw=;
        b=ZurG5xutDCh1J7m4GPD1L2fxDLreUhtXfCdJ/Qc0XSYIV3caH9ozgfgRsilfd9MiwM
         WqfYgBCJvBtKJGTxAl+ukXEnDIM+oLtaQcxAsC3+fO720QsZGx8qlGNHlPALrypI92GJ
         LtRZdAaL2NHqNNLZRIM4TJESul12xrc0r1TIg5UH/gfHCaqnsimeF1+ZeIaQZscH/hl9
         0bZr2dpbaagVpp2X2K5xAjUFcHdgy1jIaXKXDDvk/xUQyKR/N/yB2GpO2IxGfpypJz8E
         RB5Jsf1R2fhyL25ZB+LyOMYJn2pUClZkIcopdr9zlORMqMXbPvV8h+V+1lVYpFSV72Gj
         Eerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089351; x=1793694151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+q+RfQ5Kwv1XNt4YuEC2Y4+X+a7USu5opNal/bTFsOw=;
        b=ogxdAQOLYmnKzk6Ywlu8FzjHbqOCd8mI4QnH7AiZm2L8Q30rsT9oGpf53X86pwtUHs
         D2Az5F/MxU5rQfAnyb9QM/oaR6FgAFXdmsXQGdHz7aVGcQi+Sj7Bs7uHj3D3JpUeZgKV
         g48DxsZb0SxjzTR6BVZ4++2WSFNKALMbsivT49gwMMgz/3L25HXJ5cyjlqtdnqCVu+gL
         GtY0PB0VSfkhshRSJimznVyKd9Eg49PJlC2ZstV+StHpuLrkorS3GpbKKs4pFTWPzlz9
         hCFEBmThO7MlvZjI12VqGAu0H6RYm3R9Ldz95IEU/BM4AmIbcX2Fx++dVWAzXoFsTxwL
         qh7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzTLLH3xap0m5ZTaxmas68r47wCsC+9HbY+Z2XbGn4XcgDYhUIc4bckhHPhI5wiM6UlPNeKakBSnw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKd8Iv3slQ18qahY5hvH1zEtN8vgg4/kFKFT9wOCkCMGqGebtgU
	fpXYyzAWenfml4KxGKLmGLAM3P+XR+PXxck8QJ+UVpjjNkLdIMovKzp1
X-Gm-Gg: AYBFou0LmUqzPUbvbVTtfuEE4oK9YrRMRd8hiJ/eQdWKawSIwzo0w50ctgzVh08FGb8
	chYf6qaTEfH3UkAJgHK9dZuuHEJ7CxDm/a2A4Iuap2htFBvVewBG2ssnYUpY/iDKk0TrP1A2XpK
	pD/U4DizzDASSWxRcOq7xfyLhZjE0uMskDuoMup4jyNjxtmIox7tsAmXGJl5IRCOa12DY/9V3gS
	ajtuKoPc6D5TEUALNj/qwiBnpW8b1KcgWDyGgg+N9gvEHHvHpIaJr+5cMQOLt+3BiHfso/vCSeY
	W20vcK9JAim0bbSLXNC072h2Gwgd8aMQSc7CbW6Nkotq46zEWffE2KxZVqZVVW9P8a6XawtwuRU
	MoaIawX+cXyYnzSEGswthUb9o7tXk+2G7Y9KvHNHlMKdMe27A9gjGra3ul3tMPLg11wQHHxKyrR
	Tq6WDGoD3gPLNfz3j15UEsR2UKXvbHZq4zTPUya9h5WwR8POglPksXmAlRB5h7ipiWXFpnwPNMg
	nKcRzZtw5t2heEGfYmw90JmXw0/4a8rAn4oHTT5cQ7N012tW370PndrO5sV1FCc3B7QX3LlFVEr
	Xv3+HdNIM/7QO5dKbzdea8RvigU2H2wchshmWSR6WOtpJg==
X-Received: by 2002:a05:7022:1703:b0:144:f0c6:ddac with SMTP id a92af1059eb24-1a3c53db509mr2547824c88.17.1793089350969;
        Tue, 27 Oct 2026 01:22:30 -0700 (PDT)
Received: from localhost.localdomain ([113.161.48.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm37314409c88.11.2026.10.27.01.22.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 01:22:30 -0700 (PDT)
From: Adrian Nguyen <thenguyen1024@gmail.com>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Robin Snyders <robin@snyders.xyz>,
	David Heidelberg <david@ixit.cz>,
	Richard Acayan <mailingradian@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] power: supply: qcom_smbx: report charger state changes
Date: Tue, 27 Oct 2026 15:22:15 +0700
Message-ID: <20261027082215.70983-1-thenguyen1024@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 03 Oct 2026 16:45:20 -0300, Fabricio Akio wrote:
> qcom_smbx does not handle the charger's chg-state-change interrupt, so
> a charge completing is not notified and consumers can keep a stale
> status.

Tested on a Vsmart Active 1 (SDM660/PM660). Switching charge_behaviour
between inhibit-charge and auto now fires chg-state-change once per
switch, with a uevent carrying the new status. A charge_behaviour write
alone doesn't send one, so this is what lets userspace notice.

Tested-by: Adrian Nguyen <thenguyen1024@gmail.com> # Vsmart Active 1 (PM660)

(Test script and mail drafted with an LLM assistant.)
