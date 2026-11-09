Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243864;
	b=xOipoAIJ/EWpPjFTdBxIuZv4wQbYBlPPpoEF/c+dGRZOvFcL5uD18cesesyV9LC4ufMN
	 BZAhaOp4BWmS0XplP+yiv4plGBP10Y46IJYC8GhTNHzNeFS5iXmn+Lxa3+asWAqTnlQxs
	 4aQ7U8SRa4lPvvrapBGajhYxigi2viBKItboshDxrkNFjxCFq9hf/3ERx3O8JwdefhDXo
	 w2kMRQ3pM1/JQTi5yGPuPBeANfvdu3tH6/HE0uysZbesVkjNKdyyOqBx7uhgMprn7eAN+
	 RWJTT+BZD7dYMItIdoAmBOVr8z+EtWzi4guqwl4VaeTxJcmSqOyZ8JcB+Q2vRjiPCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VmhgsZdfI41q6bSk6Ws0aoyQukpnInOpVRPvZF0DgoY=;
	b=T9N4ntwKz2Hv0wRvnxxqtYuwm+ZyBb7m3HNwvscB4K+CGwJ5WgJptBmdXTaMP2QO6Jt6
	 yq+gTKo2m7wa/afciUCjlTUfDCp6+GHuE6fLE6ECYlXR5rhPboe68wIj6EGd4NDbsacyW
	 A+DyvuAygegOW5fqqNdxeV1bNV5jsitL9kD+c8AHjuJpFzHLGh5wAjxoxnIty50j7HDC5
	 ABkRWMSqHXC0OL9xpRdzizq6pIog3wK1G81pksYe1sfTMF133O4xZLyun05Az9zJW5gSK
	 hzf5+McHT+5Oi7Eheh+20dyM0vWbYJtWvtZVmCgwliKyipugn3HYYpBEd3nmKB+OR5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INMhwymN;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAC606A331
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 17:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEAC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INMhwymN
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1359054a12.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243863; x=1794848663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VmhgsZdfI41q6bSk6Ws0aoyQukpnInOpVRPvZF0DgoY=;
        b=INMhwymNUoXRa1HYjajYs2VDNOXoDzVIp/an3nVGMwTgqTKKIXcrYlToz3KguYeb2w
         0JSHPrAS4tp1u64diFxx98ot8r0Zd994Q5w09w9Wo7hRC/DtQLXBMMh5MnMbGm5sg/9+
         bfSbd1NNz976A12xlmIC5rBcyt2zgrNxYngASmeZZcCyhLh9b9uOIuPyOYnguxqTaeNR
         9hUslwRJlODcmrjO84K/MqZr6AW6G7obz3aQhSgpfQbvfDlBiGQqmaSqVNfiSLuoobIb
         SEhjw+R7G4bUMif5HGg+3AGlsX3R7zQQDPntqdP45khUAZLh8+Utt3l4+Gfo8W0GMqsn
         XheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243863; x=1794848663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VmhgsZdfI41q6bSk6Ws0aoyQukpnInOpVRPvZF0DgoY=;
        b=2Asfh5vdjTZ1/wEfvAnuL2myvavRHmQPFdnzjdFtvq9csb0zsvFEDhne0+cy54rH8r
         izc2KOm/WtJx3RYkqXUYqadhvH1abj//hdrwezUYmYKmVRXeyvc4eUl+YfZ1E6eOS2J+
         rbTDJxGR9q3ZgfymYQPeMz4iFgOj8xrEXUhXlcuyIf40yTGIDE0XdWXEZMHdBt+IB/0R
         sTB5AXav41tsNJjEW8gNSBeso+ZBXHNgd747LesLJxCFiijQzs+eIP2ld3zyyypINpbW
         hxirEZM5gKSWXFC7uyD5S4+jffY0GdBPSyGT+eWoFFJmP9T0ie0MpKjdjeasBSOqYdYq
         +cOw==
X-Forwarded-Encrypted: i=1; AL+hErHG7wOc40qV44GuYP1u4XFfD65eqnySz3vea/LyI4OxfvP/XpUxS8B3r7qPyCmVGtUO3RONvTSvJg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+6i2sn//s4wz+VJHpVEkIblGevs+bB70bwkGuoGw0e/6FBbT/I
	B8evkcVUWw1b9xz2OCBF2YtbgXFdzwc1COcnDCtDYEX6dBTc+EKOblpF
X-Gm-Gg: AYBFou0+N7gwlbxVwNpWw36LYP0dASJIDdZ2t2etabvRQiOzJulhzCTGTCsB0kLvfOu
	6PCay6Vsx6QwSOy5GKWgLE35b8VcN4UB6hAXDGmkjbdPwkQ9822VsTs5rlayOnEoGVQ2mJIHv2k
	y58NFMV4W8MM6wGlkPE7ZlD3HxOMbo7XZbs9BEN9lVyCd5wveCZHK7yB/eY+GHmSbjUx8b4Wo1x
	6gmUAjOZcyVSV14/cG72cfQjgvcvBXhCNQcE7Iik3efxY+7AcCAwHnpiOUGyWOd+ZuRkVes1g6i
	vaG0fE/uQHocStm7Y0PMeJRqHqlPaeeFErayZA9+rFns/EBaiHIzT7MRyEvJRJeqab06JVLMA2e
	gEScd7uZ7y4EtHCb0Ky1tGZ9M5SrgiLd97qTYhPzmPGvkkYMv5UdQI8RUNKBpL0e0TLlcm4dL22
	umcL8AVfw2lo4TojxMcKwookNyJxuGzTWmHnV3CNKFpK1SWQvRXFRr/CEO3NdjdXAYpKnWwnplA
	SEUtqliRrvhon2fiLotEuZXtrAfFI+fJG3pNJIYYFdiqt+J8wXagysbGdvj8touX10pWm07cgph
	HzinXUlk/fW61Q545j5DdJjLBTY=
X-Received: by 2002:a05:6402:2356:b0:6b5:7792:d82c with SMTP id 4fb4d7f45d1cf-6b756ad7482mr185305a12.16.1794243862514;
        Mon, 09 Nov 2026 09:04:22 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebe31csm1878937a12.16.2026.11.09.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:04:21 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 17/17] arm64: dts: qcom: Add Samsung Galaxy XR
Date: Mon,  9 Nov 2026 17:04:07 +0000
Message-ID: <20261109170407.2073295-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <3ddaacfd-59c0-4d87-9b8c-2caa85143393@oss.qualcomm.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com> <20261109-halliday-dts-v1-17-289114ab8197@gmail.com> <3ddaacfd-59c0-4d87-9b8c-2caa85143393@oss.qualcomm.com>
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

On 09/11/2026 16:12, Konrad Dybcio wrote:
> On 11/9/26 1:33 AM, Stanislav Aleksandrov wrote:
>> +&usb_1 {
>> +	dr_mode = "peripheral";
>> +	maximum-speed = "high-speed";
>> +	qcom,select-utmi-as-pipe-clk;
>
> Is there no superspeed / dp altmode in hardware?

The headset supports USB SuperSpeed and DisplayPort via its USB Type-C
port, I just haven't brought them up yet. It seems we need a new driver
for the Type-C controller.

Stanislav
