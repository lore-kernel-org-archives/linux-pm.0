Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D31F4631
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339940; cv=none; b=bouG2dxaDNVVa7gdUO9aZUlgPkIn4nIpM6zRfibRXBwwfmDeXSdNDQ2LA/kzgHwdhScJ6G1t+I71hu3gRKrIR6tnTe7b79NlEW5Vs0rg2L9CSX8+9gLl1uDFJ8Lb+zeHesF28qPEvkllsL3yiOixkL0MmJcy62oP+RV2ZLH2Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339940; c=relaxed/simple;
	bh=2PMSr9SUypRFje2+As/Y2378jivS1IQ2hBaeRfXknxc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=EDdc5qlfzopFzb5hQa1l/0XZQrHkZD3QKYwcRxDXaOfGDRsYiGUHCLb5HO4hMPO6gYaLlDH/8IyLuwPfO6aD+6kshOpfYu4AyRi5D5pAP7rfBA/T6I6cTzRvSWOnwEPMe83WwyhuutSMaWMqWwnDJm9tNLDSbbzOBUpzkfRMKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b=FF/jNC7H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b="FF/jNC7H"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad9f316d68so47989245ad.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 18:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20251104.gappssmtp.com; s=20251104; t=1777339939; x=1777944739; darn=vger.kernel.org;
        h=references:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PMSr9SUypRFje2+As/Y2378jivS1IQ2hBaeRfXknxc=;
        b=FF/jNC7HKJcFsC+mHOa2+KcqeR0deuyACKbrnq9c5d1jYKQHBj9qFTXrfkmUm/aqEu
         m8BRebvgbe3ea7R6elGit7N1/EP2cFfPD1I5VjBBA+CQY42UH/sdDz20jItQksA5l/S3
         MkxHc/g36E39/bKEKwYwlMXx0Shc+sJ2YQbHawxqcf0ksFB3ST0aWXaPPn7WLqsb3nXt
         4eGEHBIrTQ6UjN+qbEzhTeJc0IoWSTmq0aYAa0N7vR2E3f45hiSvakGND+cBZAWBonU4
         3I2U6xSs7EdOfmf1iEblufbtq26HLMdreKyonvAfyz0UZZFbfLbxRqXfB1Vb934BHPyo
         e0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339939; x=1777944739;
        h=references:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PMSr9SUypRFje2+As/Y2378jivS1IQ2hBaeRfXknxc=;
        b=VK6ppoxJByLp8PWEXS4PpYWMMUoO4+xBxoRZZkK3CpDA1KFj4lVyBVKbPQFNgCIgrd
         w1lMfPEcagX5dnnZxaKF6CqbWiunBUzGkc7B4sAZxeiyZEIXqRbNfNY2ffEuv/9OMYn4
         06QbZt8PxONlDZuZla6y8rtT4XNusunm4Qi38zcxzdysbpM0EpzsqSVBnncBAYNKqBu3
         auND5k336T532JQx/mXGX4XPEInqKqa6JydFeJHweWO6dmX06J0HLEwKs5ZKG54EvdKL
         C5vrkUyu/Whml9LgJErC/TlQj/dHNpPZHrPVFnPtfL1qY+BJXFnAEth2RqJeCuSHm1kU
         W2zg==
X-Forwarded-Encrypted: i=1; AFNElJ9gn5X2knKCHLsAdrQVxaFcRv7CUhRQgCi9NSoTaDjtWV/bOSsiJWKJFBl6wlzyYgDU51Vrv0YcpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyueNgEHfwhT1wU+b4+0kbIwQx4TlbvW1xDAquUNNd/xzHjNDbD
	MISPCmbevyBY6iewIweDpHaWu+6CRqNFZhe+g9u8iUqIZ77PkFijca572k7RwMLXA64=
X-Gm-Gg: AeBDietg4EFLcP+WW2TdexnP2qZIGMpsLA4W+d9wUX2t/xxvvKpoL523wDO9Tyh8kOV
	HXFs5DUuDfOvFgc6rSlwOTiwo1eM2N6T3Xx3XzTsArDlAPG1MaPsDLgNsOlwGZqla2QVk1rXEDr
	Vk8cbxK4rTXK6EhpjwiNgXdqyG32IJ1pmtWGG801zNNWCDPoU9nq58YjwzfjZ1i2SRUq33wvZtM
	cySrJ2cDtyQ+qiXDUCtZVt7VAbwLRU2TweL8EZbSqntve4gvW7XxFHC4NUpCqp9bWU7kBRVMOrW
	CzYGgTGydCxvEZYWG0nf3BSWXY7BN0v7OV0wbZ0d4rwWvGayzq27a2HFXZLADp1LCowLnaWZZeq
	P31RjdyqVgPT5DuOkCNtP0+USc4e0v1wScWWt2EnygbTFAuQQgU6HtZpto6fUSESfUrmSGd3Tl3
	si2vHl9HanolS4VuwefBJYaCERAT1v/Wbs5kQYqInKSpYlMIMP3RzIOhxremSaCFn7s/eJTsIht
	X4zQ7zHfFU=
X-Received: by 2002:a17:903:1cd:b0:2b7:a89d:6135 with SMTP id d9443c01a7336-2b97c3fab8amr9326525ad.13.1777339938955;
        Mon, 27 Apr 2026 18:32:18 -0700 (PDT)
Received: from claude-dev ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac78880sm7441665ad.40.2026.04.27.18.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:32:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 01:32:17 +0000
From: Daniel Bozeman <daniel@orb.net>
To: shawn.lin@rock-chips.com, finley.xiao@rock-chips.com, jonas@kwiboo.se,
	ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
Message-ID: <afAOIfNcy73GC7lU@claude-dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adRH235mv00OdOsb@claude-dev>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>
 <f1b9a97a-f1f9-0757-5dc7-33960318be61@rock-chips.com>
 <693c6c27-6ff2-4ab0-994f-3821e5ffcec8@kwiboo.se>
 <adRH235mv00OdOsb@claude-dev>

Hi Jonas,

Just following up — I have the NanoPi Zero2 on my bench and am
happy to run any tests if that would be helpful.

I can confirm the EPROBE_DEFER teardown crash is still
reproducible on your next-20260403-rk3528 branch (7.0-rc6)
with your conditional NO_STAY_ON fix applied. If you'd like
me to test a different approach or gather additional debug
output, just let me know.

Thanks,
Daniel
