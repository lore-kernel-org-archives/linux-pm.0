Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214238;
	b=uWh8cpRaUpss8cGhbmCLKNLr9eaV8v2y+8X+ia20ATdhW6WSr/vG+htMwjqkCHjJjSgO
	 h5/YMXDr97baxK7IgTP8DqeZ+8vh5XK6LW7G4SFVLvpCkIczAJhEzkKwFbNK1dnoYZ6da
	 opOc5iLXpR7XQifE0A3n5qllOYqfQckRFNW4wWP/+1R62s1HCz8nO094baKHVDKSnZifw
	 tliV4YaRwKLNKkZPwdgqMaEmlKNeYXkSosYttn9HfkYrSk3a9bntcbSMP9xN/VifSEcaK
	 YF1L1S7IxhMQb0DOx6VoQU9ceNHN2lukEB/mY6LwUSd3tHOziVG0cF+ifl1fhpPaYew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vjj4rdSbpcMkkjnNoByhSOYk/2BEXBPon42q9R20zeY=;
	b=Z+BtIQDg2lvzkd3/omrxCMqS1nLwJ+uWdukmh6oQJju3oCOw10okGpqTsGCeSfz3rASM
	 wZVELvPY9gJQYnyyjagGuFXWxKpIy2jRix034fqTSqR1r4BLgaLxLpptSNWZkLLsofUJV
	 dTZNX9GIa53BizSYlmJsnP1uWPsBM5RZDWE3Q67H8hBfu/cGRGLYfa5/Ic02KBlqXi/IX
	 PIRVs5iqDn9gBIiEQGTqkjwE9yjXAP/63IOhdl1BMRhE6jEldtZwgYROOIXsznqt0KZXf
	 9FlybjrcbVZ/YVvLYuOlKTEOwG+80uBeMyWORz9EInohLSrsBwZ48YNvkhv7WKCdgCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGqde3Ho;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715F606A33C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 08:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B715F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGqde3Ho
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so5478865e9.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794214236; x=1794819036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vjj4rdSbpcMkkjnNoByhSOYk/2BEXBPon42q9R20zeY=;
        b=TGqde3Hoeoi+P+P1MJHy6yFa7TDuVfP4g4ZGwX2ih4xjRGjRFWnypRzOP1Xa4L0IPm
         s/DPVbSTnEn6+vQabgyMvzXoPqHofh2/mImSCnYL5a12zXk5bVCjZsmkY8NnMPUi2SVc
         xAgwi/orvf9pFkFiAXO532yOUQEFgNvW8m3sxgUIowoBqxTIMXeJ2WTdj1dQHwKMPf0V
         cCNQoCDDyIF0nns6PDu+LZixogYHFd2CbQ0mtJSAP17FhsmRFJQnz4kJM2w5Emebd5cL
         Ug3ZqCYI9cMwu6iJ7WzAlyerv17zrvmPyC1IUPu31nRNXyg9pX/XYW5Pjf8n++ZvU2Ya
         pTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214236; x=1794819036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vjj4rdSbpcMkkjnNoByhSOYk/2BEXBPon42q9R20zeY=;
        b=gZZhGgDgcJi+7ntO5YroB32vR2vnwYMY2OC/uhH1ebZf4Riir8l5jWy3bxAr3JS5iC
         fQsMSj00nXcvqTXfVZYly76HM+DGPruvRjs6ECHdyUOjAlicm2GetAH1DXhzsV5gkx8u
         4n+0BegNtmwCGs5yzXGdgRj0MmPdpejKQPGLV6cymtajWrRQb7Yr+394oCJ/bDE944jR
         EHV0HWwG7YldFZVmETcvn44ZLjZe3wVOpqfPQfilXUnWBbSeONsE8DCGMatl4JZZ8XUn
         jVuSFtsTOla75qr7xyJrzDPEoZc2bJbrKPT5D7rwG98CCTM1dsI5/fOQybYKFnuuDzzV
         FaCg==
X-Forwarded-Encrypted: i=1; AL+hErE5r/Hu5dSK8KrrgwHRDaAVQfYVUwCFSXjQMx/QE+lqCVCHKEYUEL9sr06kDSG6wx2ji37E1eY1wA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xf5mI5I2du66ymfEnLZXNijA2jBb31i0zMIubtjE/3sBkP7fG
	A+qYlcSniQPoCMtOtNYBVTQvWxG9GKTltWS0C//Hlhw7Bf5CG5InEZo4
X-Gm-Gg: AYBFou00cnMBtWmeSJkI0pCAxXeXVqi5Ri6/z7f2umaGUA63hD3z10tgjTRoNJjaMms
	P0vtBQBHL6miK6l34SDzhxiJ3HH7aLk7c2emkUK0+k60p+WnMHbjeq+lUS6bwyJVb6RFOhBNtHu
	qq6ObwIa3daGUIrPOpK/bdy+uB2MtkXbcJU8iKCc/kcFKiUdOUzbjgGgNXlJqG161yFu48dmqgD
	qfoajicFFRClwUqAa3uPbERRF8rJvv09PQyOOz10gS7yABHvZVUqvd+4B2f4hnINSet+sWJrrua
	w50HQKqeQiMzgzMEUe1tmtfRt7J0nU6LszZZQtBRu+GczBtg6gRH3MAlZAGFzTIXe90KXzWI1+n
	MiMwkOtOVtC2uFo9yybFjre+H1Q1mqo7lJbCrOk8PlbxppcFpt/6vips911B8LrCSe3edG7ERYB
	eoYUXkdDEDIglQav7u/Hd8kLgKQ/+P9JxjXAJRuDM/eHShcrqxkbGftB6DEt+1GZANuPWMCgEcN
	hwgciy+OYPqp24zwtB8HX7kzewnybx1P9irzHKCka22/3spReMYOL4+hVfUCIF5S9hu1YNDbNBp
	IZ78pXpE4EidQcx58caQ+6XPSJo=
X-Received: by 2002:a05:600c:3b1a:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4b963c7e496mr65389125e9.29.1794214235848;
        Mon, 09 Nov 2026 00:50:35 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502d5b1sm147015055e9.5.2026.11.09.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:50:35 -0800 (PST)
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
Subject: Re: [PATCH 16/17] arm64: dts: qcom: Add initial Halliday dtsi
Date: Mon,  9 Nov 2026 08:50:19 +0000
Message-ID: <20261109085019.1751534-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9dbfc665-089c-45f7-bca2-74caee322885@kernel.org>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com> <20261109-halliday-dts-v1-16-289114ab8197@gmail.com> <9dbfc665-089c-45f7-bca2-74caee322885@kernel.org>
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

On 09/11/2026 09:29, Krzysztof Kozlowski wrote:
> Odd license, suggests you copied it.
>
> You should retain original copyrights as well.

The license is BSD-3-Clause because I used sm8550.dtsi as the template
for the node layout. The values come from Qualcomm's downstream
anorak.dtsi, which has no license or copyright header. v2 will add the
Linaro copyright from sm8550.dtsi. I'll fix the other comments in v2
too.

Stanislav
