Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426414FC8F3
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675747; cv=none; b=WmkPSBxWjjCCaZNuNo+nWsRTo46dSO2gH+5EyHdsZIcyqC+zF6cQrBH9MfCyjgvMI0ZiiuErq2GcsQYPMq7SuEdkGAgZQgwW68j3s3Cvk/rOxu0T2MzZckbYHzRtreK/9fMdb2h4bBSRd/w9Vyl9cXYqzri/HboEevwqSHg7uSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675747; c=relaxed/simple;
	bh=07se/JviETlMYDRCO0tPeNRK6E3kx+s1WEeNG38MRU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQOUXy+o4RlhdpFTCX7hsSELLdl/Obkrz4Cjw82f5BqssaXplaDz32nbMtS1iPIXtp39Q36wkySnJqjNFWAF4RaiX+Ane1HlFLo6HoBzpDaHZdhXOpkOIKK7w90I/jIT9Zhub93fMkfhv6JJA+XLvP6ybHB4OcZh/KkN9vmbCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouCN2Gqs; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouCN2Gqs"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaea1cb2e4so4866756a12.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675743; x=1791280543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07se/JviETlMYDRCO0tPeNRK6E3kx+s1WEeNG38MRU4=;
        b=ouCN2GqsTA7bAtO/V/w8geFI9GhJJ8LPSpsPkiKmWpCVYPSn0lHisUJrocuRTN2Ky4
         X+CD/k7qB7CZYVci82VyOomR8H9Xv5AESATOMuU0hq8x0HF28nBHPbnKFF7R2nzMFxUY
         j7oy3+wgvxPeKxNjJcniLjLT64Y8qy7d6KeuAKPwr5OvWh47Wmr+NSTooRvL5hGF2VFG
         qC7fuO6A2RnVZtX4/woJiOwF6wog3NRsPSA4cfCECDam6kPSFKux/LwIZMoKuqIbQoAI
         BB80lT541nYHE6eQKvWprNB6V0z27ONvGtwMrqtRMAK5HTG8FharwBpkkYjcQUlbZ5l7
         ZvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675743; x=1791280543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=07se/JviETlMYDRCO0tPeNRK6E3kx+s1WEeNG38MRU4=;
        b=sy9cPN75I0tqXiHmxNNMWThBwoi5AwYQiZHXEDOhQcPBtUEmBcesZmjoAiaJhkgyCE
         OGue7xIfRlELqnAkaWqHcJzVDQCnFIsFWSS5LSpaiEsDjYQprOCYAV2nSuqsHnBlo2Ur
         vcYd3eA9f14549OAnokKUboL0s1m72Z7JsVv3bSyMlIfOxOE32Fcnxu7psEueiFxjS5O
         N8tOVJs14AazLXx0m+b5fQIVjjCnCyLkI+w+94JmycxumpT8Z1Kt2UEKm3POyuKN37u8
         iUw58QjUNT+FNf7/u8IyiU3DPgpiChOs1tuTs1MX9OqdjPR/0LrFw4oXICNsQQTsbE8W
         SaYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3R692luQ1V2smXmTwY+MLjhxSJC0bUc5ifSBaFuRgFl13AwHW3LCBG5a1EGegNKFr4B8r/aQ83g==@vger.kernel.org
X-Gm-Message-State: AFuF++kVTrrmN/K1BEamxEV5oJom4JEJkyY2qYCw/xEY42IsdnIpm3QI
	KeoA04eouSri3f/lc1TbboHbl9y3xCw29mzU21PuxxZJRSEf9g6BwqOT
X-Gm-Gg: AYBFou1QAw76S4jgIGc4G37GP4gbXW4H4/niaLELpayR5S4zcsofqxaqcHH5YxO+IOc
	QmyDrXaHffnLUvItXDlZKo7oycWNec+PxdFQx7M3Ae+FuFBUSkVvcQQuDUzacAUg1uo3GgNhB0C
	kiM943PfxPprO8oi2FgJ7jwu5l81RY6O0V5keW7SrvleLEDnpl2ewAb5irE8e91Leo9fCQMB7Qr
	Pp1Be4xZwsjkfXciRPiBkbGrJA0ZfzFS2eLPxXVeMN6OH0CbnpSca95TgTfxPz4VbTSvCoF7eUw
	CjmROcytD0R5f8glOS+nUUAE9/NRMbBcWUDwctpxUTi7Jj+ab4IHIotwo89/KSgBYGRwLJ0TV6i
	vc5L5nO3cKT3bUzV1pBLDyp9gcRsnYfDnUZL7kXHor/tjqG3h2IJ0AH6+MINxC7ZpIFggeD9Cxd
	HpJ16L2px0y4kbQxibew1RzqX1xesw8fzYGh85NhmKWcFvcnDbiEwbyqQPwIk89i4ELm9P6nY4p
	1JqLIWumt02fWrgLcMgBiCyuc+R01CxeXYcVyjsk3lDA6hwUpM=
X-Received: by 2002:a17:907:1c89:b0:c29:65ef:b907 with SMTP id a640c23a62f3a-c2ac24bcbe6mr1252123466b.26.1790675743155;
        Tue, 29 Sep 2026 02:55:43 -0700 (PDT)
Received: from sp1der-OptiPlex-7080.epfl.ch (dhcp-122-dist-b-107.epfl.ch. [128.178.122.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dd1153f09sm323000566b.15.2026.09.29.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:55:41 -0700 (PDT)
From: spidermana <xuyiwen14@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lossin@kernel.org,
	mehmet.mkoseoglu@gmail.com,
	ojeda@kernel.org,
	rafael@kernel.org,
	rust-for-linux@vger.kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	viresh.kumar@linaro.org,
	work@onurozkan.dev,
	xuyiwen14@gmail.com
Subject: Re: [PATCH v3] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Date: Tue, 29 Sep 2026 11:55:39 +0200
Message-ID: <20260929095539.1398671-1-xuyiwen14@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANiq72ki8M1KmxhO4vSkMUfLcuqOMvZtuTNdDpS-UcJy8rqWpA@mail.gmail.com>
References: <CANiq72ki8M1KmxhO4vSkMUfLcuqOMvZtuTNdDpS-UcJy8rqWpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 19:17:08 +0200, Miguel Ojeda wrote:
> The From: doesn't seem to match the email of the tag, is that intended?

Oops, no, thanks for noticing! Please disregard the tag in my
previous reply. the correct one is:

Reviewed-by: spidermana <xuyiwen14@gmail.com>
