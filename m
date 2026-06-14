Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC293175A9A
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424556; cv=none; b=TzFEO7/u5R34XbkvVcYduz0jSTrU1RUz7wxG8Hj1iaiq12kBXf0gvT63j66ZucbGPnXjJ60dUOk1MEnNHGTojzsfpfW7mVsNUtkkFC2+7cDeMQ/XlaFJe0PQiMu0TFRSqfKySOM6lBEC1q3n5jBC1gmHxNdbxou8EUfbhBmJIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424556; c=relaxed/simple;
	bh=aA3VIuX6BOzmmpiRVrc3KrcxVmbodMVV6bDPEZ71N+M=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References; b=M6LatKzc5Q2RWe4yHWRP/dXmMYs5rQ+Igc+sI4ff73shCDnKfkb41rdLnlwHLfkhTJrXAPHOt3P55OQA5pFSba+O76/DbbREGmSA0580BuXvFppVJM6Hw/GvKIvFZp121EzgufNa7PyyQAUkRZcwxabrhCoL6X9ReiBgi+8v8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV5yAOFw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV5yAOFw"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so1857054a91.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781424555; x=1782029355; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jotXFPC9WjIw7ToHYuo4aMTV4jRchVzBk3P9AAxsxM=;
        b=mV5yAOFw9f0IJP7kwyWHJkeTzKGMYSKIjk77DD7fwNuqimmNmV3sTKtO8Rzy6uxB0s
         xkjXkA7/ELHK0m+jA8vxA7b6lPxyAaLSWVwqdUzk10B70Fbmby2XgO8iowNnZfNLcrak
         QiUdYrsVacBgvL+7IcRMHyLf3io4Z6iF/1fttq4OgWoV0h73bzVNZC6YlGnty4lyKQej
         O0SbfRLQVS2V/P5GRoWE2aF5VKwi9LV2Hi649AxOdcvxUoc4yZwVqUArHsXc/WU+n0Gv
         1JMPgb/4PEu39vZoyI2RDbnaKn7YzlZxVnnKErkhhPBn17imsjhMDy7SMqOV1XmaTN8B
         NANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424555; x=1782029355;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jotXFPC9WjIw7ToHYuo4aMTV4jRchVzBk3P9AAxsxM=;
        b=R+1px51y22BYOY2ea4fWLH2B7DrMBqwitBpqV57iS7I5Nc5Jqu4UsMFeNA+a2Ok4n/
         uxJyV1fQPqtnWidegNNDQGxoGQpHKGj+6N5NeqA5GNFdKH/APKo9thyW3VyBLFsL9CRF
         1uLECa6WKLgR+d3JHQjt8RvthS8MSzLyK+jhwXgC2J7Wo2OZ7lHp/AuLzqd6Vhkrm2Hh
         H+XdhaTKbOZZ4TdlX9GKBAArU3Urf7/aVqZnnHpHcQSd2PxcAl+iWnxslE1It7YYBg1D
         0GP7AB61BX1d5eSc5Cg8AFAEXRIC9mmokNDXCv0jsagj8h7HxlO62Rfr7Km2yM2hGaKI
         9uAw==
X-Gm-Message-State: AOJu0YwlLnzOVDEFLaeSpNm+FGgrPRADtQg6dGnr8KRxoiB8HkrijPNr
	95faeeuotLhGRNjDoSHqthFC9JWp/o6i2X9u7fJ7jfPbFDwk7BgsJ2A3h7dVL2BIGp0=
X-Gm-Gg: Acq92OFno616nD1jbKbOAQwm8azVRLIJe9IBS/W26DA+BvqP1kizKTHhWN7jMeGJWZN
	mXFDQI+rVAEQ31VoTIZU8swEfV/YquXDExG7/+wQEboPRTjoSpFNYWPc5yh0qUtuc1a2vl3eyYH
	tKJwwnfgxe7og7pBE0Ap14fIbVN9o9maOSkWP7H1IUhKgH/zY4ZMHNTX6AcOl/BjmArlBYTuj3g
	ve0CdM5o8EOQguph2K+PPfRCvgtDZANFf+De2XTpBT4pPm+6Mn2eYCCYpzSA3Vyp2KBpMAS754o
	91M/0thNtgxYe3Vjpp52ZQOJw104wDFejbQBGRvySEJLR+xuCf8/+UhOpZS4I/fB5vg3BGROOmc
	X/K/OljCVII/9/Vi+Vpmf1BfTlw+bcRw/A406aYLxSx+GUOmDjqTUGfvZPQVmoX8GKGrRFefpFK
	6rpP/463PqoWwTueSv
X-Received: by 2002:a17:90b:514f:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-37a0184a3bemr10413484a91.4.1781424555095;
        Sun, 14 Jun 2026 01:09:15 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a262adbe3sm8290563a91.13.2026.06.14.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:09:14 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: thermal/drivers/airoha: Fix low trip clamp using wrong variable
From: win847@gmail.com
To: linux-pm@vger.kernel.org
Cc: ansuelsmth@gmail.com
Date: Sun, 14 Jun 2026 16:09:10 +0800
Message-ID: <178142455049.1922887.4576043833341163833@gmail.com>
In-Reply-To: <6a2df296.6b2684af.263065.8200@mx.google.com>
References: <6a2df296.6b2684af.263065.8200@mx.google.com>

Christian Marangi has submitted the same fix in his AN7583 thermal
series v5 [1/7] and [2/7]:

  https://lore.kernel.org/linux-pm/20260520155525.22239-2-ansuelsmth@gmail.com/
  https://lore.kernel.org/linux-pm/20260520155525.22239-3-ansuelsmth@gmail.com/

I have reviewed his patches and provided Reviewed-by tags. Since his
series includes these fixes along with additional AN7583 support,
please merge his series instead. This patch can be marked as
superseded.

Reviewed-by: Wayen Yan <win847@gmail.com> (for the matching fix in the AN7583 series)
