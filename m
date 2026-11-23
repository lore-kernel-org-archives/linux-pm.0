Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468663;
	b=VDFl05PEH4QS/pTPzKljAI+9BEKd4m/jOxhiryVrgGyR62ip0vlyXWsJhqkh1gc6zxAG
	 5D3DuZxqaT05Vy8oPN/cb4oGEmMLmTufCgqFqU2cc4io3Hmic5WQpUoU+mYOb9SSyoh48
	 seiE04N5Y3lpz5Wn4ZZ2JKP6qxboiVTw02Sw9KL/Dj3nMIl0S9w85scZIIv8VBekw70cI
	 z756rUVvVKf6JYo2hfhNNNE+xzB03EImIbDiUIqHyIvSHvCHZWGRUtTo/C/iOYXx2nQFp
	 6XerNY3RJb69wrBtWwf2TVwHZ/KiKSqT4f599BJ0+R3HbWXHMm4kO88Cn9FC7zR2NCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mEI2MWJHKjiB6vj3bpQygFD6VsBJJyxeJ4zAlBvCIuE=;
	b=QIoUme0VGawaysJFFTNjblQ5t1hJpoaFlCxNAQNgWUYKD4fHiLcTuirhdDxkBj+2mP21
	 4ZZ3LyPyiC9RAOe56wXn/fvq/1KyF8vCHFL7URvuBdlLRZeUAIzbbwgKal+wUVIKqA8mK
	 OTlVaH+eM/V5KKPcIygxqdc6aprbowSiuitpBmRmU9DONkIWhMhU+zzE6LtkLwxeVgfyk
	 q1YqzEi2eoKMBqXgS0mmN5KXdo8nJoVgLD1V0Tha6Z+F5EEBhU3CaFy9vhWUZnYJ+ungn
	 q2RwwQ4NmEgbjlk8hXas2FhlDJzaqS8TE34BHTTGyYE+kFhhiazN0u3kNO3ai2Vb7Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fedjRZx;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512B606A33A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 21:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4512B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fedjRZx
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a357b1c649so2251187f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468662; x=1796073462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEI2MWJHKjiB6vj3bpQygFD6VsBJJyxeJ4zAlBvCIuE=;
        b=0fedjRZx2RaPeNewDfT6kMMnjXVPl/B3fA1gPsEqLujR7kcW0NYtdJYVaByQandrUq
         QJzBJ4uC9eS8a+ayksMogNxSExWs0eNFKItvTDKAx6NHc5x9hqv9RQlhAAzaAg7s5gs1
         9sbtbyps4kPCKude8iZa2iiFH+utWXTUN8TCJqFX8mRmvPPMu6I8nAQcyMZ4i4mpzyX5
         Cp154EF42lPno5OVkcDwnkP37Yni0BUszr0xLEoRsNB5R9GRF4fxmXOCy5ua5f8Nqhrg
         4AybiECJ+X7fZBXujwbzZQ4s2TiblfJ29wOS+plEAwzRWxdPuG712xtYts3o3CIOU5fN
         1RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468662; x=1796073462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mEI2MWJHKjiB6vj3bpQygFD6VsBJJyxeJ4zAlBvCIuE=;
        b=DVVpNVDyQtJfi8jR1iU6u7kB+RsvmGm45N7MBf6Yc8+8iysz+mvmrKv5MYiUKnkZGo
         Mi7jZKkvg9zf5EEaAh549xi2o6M/UumrayHwxfRgqRjSbGrjGm1kzDP1FRd+RMfT8bCO
         0lOzUMY/FXQbSFZZ5/wxu1v/Cb1dKorm8DQ1kZkSZbPi/Y2WD5y246ZcW0AeTxKO6y87
         egSrtjtcId6iPUvhaTz7wf5NlPon9qz8KYb+/eYieEbvqxjjErM7uTJrc44CWvxi0F/x
         +FQmFtlFp8Ic5a9tP2KKs0ZT+LT4L515YRi1esqAEtY3xz+3JGXVwNsDgkHojnDgGtko
         SOoA==
X-Forwarded-Encrypted: i=1; AL+hErEkQ6YB0+u2N7SvAipNEJMdpRfce+lSQn8xuxgcYBBzDOHuGSomxM2CPhGjIMRplVF4tSaJrrwjcw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2X8/GopbEAQ4pb4EM/j9MoIR+J5o5+0B3iRe3XE7vqNaZVBlV
	7TqkJ2kY+qlA2qJ0H1rNyUpKKvcw8pe7d/kSkeecTozrXa8YjzQA4Ndt
X-Gm-Gg: AZFdTZfXpMJRT02mZicMVwoQLfUAAoCBdz2/tdCsJBeo1wq6ZWaHYeso4Jm8wCpZMRa
	kumsux8mVlWeLUoeNqekjZcYV1ZP2B4TH2J1Mi5yM+/GhsqKQ56+8LOrFitIyDWLbLQDVLqDI8y
	Sacr7S5DrcnXEHQbOeIwHDanziWfIeBRVu1zYpBGujRzhQJQpyhaqmnaWjn5LUQ+2+BfieO9Ig/
	dd7imCll71mgu98OHJsW8o36GTcxFzIWt4V8YZql1/Q315XcsRfdXPf67eY4KkT7cwogf3ztnWo
	ZNsruGGI1rjwbk68IIVatBkhlmILQYUaaja8Xr+m1QcZ+7trsbFWI7HWUKraKvHdgVnRY68DxDf
	IA+RBlcMmM56VPo03lwXNZK+O6K6b7oSLb6lzJ/b7DKfsrCuMy6vNeYGXC5XCiGDARQFIxAAmVb
	eRxjN8gIwJxFChunuy8rglitHYem+6UnmcKnG8BRxIVhLnYhQAih5oWIOYX/wRAEO4GZua2yR+2
	XqMdobDnXMRcaThSn6bRJGAc7IIX6eDxNpL9kg6PLblrMLS1JSWodC6yZl64CwXNVI4vf6QXMj+
	ts/GmX0EdasVT2v1zhMI7chxJdLZrhd1Lp3cvrIZAwCL2OHF
X-Received: by 2002:a5d:4605:0:b0:4a4:14db:2348 with SMTP id ffacd0b85a97d-4abb29105d1mr18698069f8f.35.1795468661504;
        Mon, 23 Nov 2026 13:17:41 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm24513121f8f.6.2026.11.23.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:17:40 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lee Jones <lee@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Stanley Jhu <stanleyjhu@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Georgi Djakov <djakov@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 13/16] dt-bindings: arm: qcom,ids: Add SoC ID for SXR2250P
Date: Mon, 23 Nov 2026 21:17:23 +0000
Message-ID: <20261123211723.1065310-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123-pastel-barracuda-of-rain-bce8ac@quoll>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com> <20261116-halliday-dts-v2-13-2c92438c6c46@gmail.com> <20261123-pastel-barracuda-of-rain-bce8ac@quoll>
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

On Mon, Nov 23, 2026 at 01:09:26PM +0100, Krzysztof Kozlowski wrote:
> This should be rebased on my patch removing the IDs.

Thanks for review. I will rebase it, but I am not sure about
the order, could you please clarify?

1. Should I wait for sending v3 until your patch is applied?
or
2. Should I apply your patch locally and then send v3 based on it?
(but if something changes in your patch a v4 might be needed)

Best regards,
Stanislav
