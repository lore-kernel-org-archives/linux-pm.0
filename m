Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337090;
	b=2FO8DD67frIJkzuCqrP3k7ffNO9dbKrkz9zzosp5JCVQwMTfG6RBx9HFS0AwEFviNlw2
	 nDaMWrb/zbTk92RvXz9epvPBhaUZ3sJwvvehsdNKpJrR31UtT96zf8Yr02k4DPyHvNGcm
	 90PuKRBwlNbt7bhruGeUuwl5XU5DwrC54lsenv//Cn21nLCwfiPZPslw6gwi5/+Mc831q
	 ZCkQyoGIfwlnH02reixtVXCPLyY+kT5p+806Ixcizl6erpbqgfWJcG7y/nR+Xg7Z0gHe9
	 HGUL3ncb3mB1ysWjuVLQSEy1/nIlebA2SeLVgoE78F1xUzGWPWo9ddXXnIbjsA0SSKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
	b=APhtpWsboGoXBEb0wKznVDGbK5ptqV22y/jCn1OnEWMkMgU/AvL70JVkSHk5bPf3yAME
	 lB22m6RlF4v4T1MaIT47oi8xaihnuYBdap08Bzjmb9wqTldXg9KUKNs+wGlzoh2EWEVh2
	 0mBCXc4BTMZ/b50Vq5H8PpQUv8ZeRS0jnX5DSjxY7hTiI5rnF23sdnD7t9pFCpZTkOLUs
	 Pwsguy9zXWszWPM2TF3Y/pTfcwkNQ7z8WGddxa9zVpg0A2rswJrDpKMtKFKRyW6J7fm6d
	 /SZb1vL0NM4EWbPTcquhxgvFN8onDUyXDr8mA9YsgcuhHh+FK30HzYHyeWI9lF0+ocA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hC8j81W4;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA23606A334
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 18:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DA23606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hC8j81W4
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e64d52949so207652685a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337089; x=1794941889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
        b=hC8j81W4XVy6GM6NSCd0k/bnKZL9dDfHbCnjIHZEMV4YCCxJo+rbG8Q2gJ1ziBpLGq
         b/WGl7uM+GbW0ScCbcGRV81gVeRTeNgz0MizF5kMHCM5ZPPdbitL1rbaLNattI6y9fcm
         0DpQSnY4WXKFOr6Wn7dT2dmcAELqKsJEKzR++vApSbK2g+bqtAQ3mQs5BCzW7QtRSntj
         GWWCQkNu74fERR+RfULkWg5huVt0eR7NbF0yCDO4S9QOY3TsdNE17R5IVmsDeMYlMoLP
         36wy31vJ31vDKQ9MKJyqWq+R6e/unEw5WoidBXKtWmZIODw2TxbkPGzvtWf17iNMm5uC
         b7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337089; x=1794941889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uax/a+Cf5PnYF3LAag3fOWDgi1ERLoTCpA7WArwoVB4=;
        b=lLvdXG231yYgbZLaZh49SprTN6lDX3n6OcpBvBk3ktqJzj3IAIt++woYLS5tY71IMu
         12IrsAjrthFp/1Daxif382cY9RS1O0sowbfaBZRU+O5JlhehaVAC3D/r/GrXXqKDYDtv
         XC3nhIdjuLUI2j2hk1CQ0Nd6kqp3zue68rjlCSPWRstnSu1OywdWLtp/RV0JbcRL1rYI
         9SNe9MSBgsJNPNoEJYdTvBm7LL86+/W+UBlLdXDIaF7ZXpW9fFDANxZX5wFXkVmvDnEK
         osmeGWqCTmq59KaFFyVBtSkzUMZjAPIup1cawQIZvQVETIRK/Vbh9VNLr5kGgkfwtYSd
         hjsg==
X-Forwarded-Encrypted: i=1; AL+hErFZAz0JHTGHIwQ/5gGmCtnd6wdVdJUe33bCP88RoHV38aA9ZtEfPPcCJM/I75av79abomzbANK2TA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fTNSZKKk1pNDwv2vT+qtOtTjvkdbJGspTJiIN+BAGzZvnyaQN
	vug1+7bWcZpUPoTl6KmQ/c63IZSanzXwBCbiHgJ5ayLD4SeUi4uBz8O+
X-Gm-Gg: AYBFou2Z8aeTk8SvMAWO+9KoEtVTN47AjNoPSNNJwluM+ZBH4L+tzAxNvDDeT6bNP8d
	mv1cV31DtbBEtokoMyxScpyvMSNwTzlnXjpQc6EmZdvGYqFxIWkpPQQUO2nNiWjf0mXc1YI8tIr
	UXRMjLN6SSlNbYyqWhHhSfqiKQ6xUzQHQ2I10J9lK9yf8NAy2yyBwqF6sT4cMi3fejJAqP5XHXh
	RZBvP0+fK5+7OTmWqmLwMvGYnLutgZaWgrgGw5MlDzvPDcFoYyBMU8//fdnUAhePtbnYbQXl8Sg
	72tz4mXjGMT6gFWoY7aH+Gdb0o4kivCunSq6WTedP9yOnLXC/nBtMGUPyDuT+7J8gQWVwaetv5C
	YibiJhhs/w7V2XFriUA1Vr8W4Ac5gEeUBfta81/+0Nwzkeb8wyXLsN42NcoVdKpCzdLDvvGBjpT
	Urq99MNMFotrgpj+LBR2BP6cpVS/7nn4OM5KlvOOOhOJZTEg/mJBS5OWpljFP4P4NQH/UbAbo5M
	n+5hzg3NRNeV+QU5SnCzTzom/plkHcSJsQKQJX+9teGlFw3+mqQVWcev3EVv39tbpE5sECuVa6y
	9sePZzJ7plQTrYTybL5WHuEds/RRgpNE8EotIioPxguCqr+dG4QB9SwM1KFyNW4sdZhVYdFSJa4
	CtgPjKQ4DhLRgHPEFbJyTQItQVse53rLFP3r9Li1sQitDWBBXz3zX1l2LPJx2+AfMPBCXl4jSrl
	0KuE7yzlDo+MiMXRgPgm9TsNdFzoKAscN3oq125cabF29ne7v8hk3Spiyb38PVtTYY/PkdGrac3
	Z6UV3Xmtlte00epkzs2brB7yeR5XrZagea078xNY5GAPQ==
X-Received: by 2002:a05:620a:4041:b0:93e:c12c:f127 with SMTP id af79cd13be357-9479f38d707mr575616785a.83.1794337089011;
        Tue, 10 Nov 2026 10:58:09 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5024:4b00:940a:c6ea:f292:3644])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e619affsm290954085a.4.2026.11.10.10.58.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 10:58:08 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
Date: Tue, 10 Nov 2026 13:58:04 -0500
Message-ID: <20261110185804.56861-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
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

Tested on an ASUS Zenbook A16 (UX3607OA, X2 Elite), whose mainline DT
connects Bluetooth through the M.2 E connector (W_DISABLE2# on GPIO
116), with the QCC2072 support from [1] on top. Without this patch
hci_qca asks for a "bluetooth" pwrseq target the connector doesn't
provide, W_DISABLE2# stays asserted and reading the version times out
(-110). With it, W_DISABLE2# is released, setup completes and a phone
connects.

[1] https://lore.kernel.org/r/20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com

Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
