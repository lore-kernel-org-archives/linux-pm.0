Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334374;
	b=rwuouE+019c5RDCHXmUzo7BrvcB6MxLmZPWR7Ks2uqJgFmD8ABC6XuCt/cLy0tm+XzgL
	 YncpoUuJ5dA3D77SszGTCY2oTe0m7YOO63eUGNE6b5u3sD4JEh8GzYtKDa7Quqmi+Q50j
	 C34iI6R44PAivhvdMZ3NfoP7WQfD2L6SmJKnFrsA42Qa2D5Sg2zzLQGEY6dh7kmXD0xvv
	 Q+6KdofdFBKBA3aQlnqWYAuNO22DBoCuxTmTwc496crAVjD/8Fj+PAloHr2I1FarUbhk2
	 LS2/G7Fb4BMpLMW6ZrokTRsc/TSXy/CacfR2+Ch1b453t5fl9qemDYDj8SOyaCvDGTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
	b=N5rdgo31EAlAuJky5ZKs1aYLzf+Nrm8JI2vLUr0wVcAskneVDcpZtd/yIHwS74Ufu0Dm
	 IIWhjVOUT4ZjAy1FYGR7rwoVOrMRrIc3h1FCivhPE6jR7rg6gODSEcamq3F564s9wrNN4
	 GVy7UoWMmL2dmGoBRTZ0akJK90fO+W6RvVno6NOJYHxziFp8JCj2nVjwb+ODsBnO2ApOw
	 VQ4lObw4CrQo9nNUk77nslsHNkBRtEpv5xD/EYpgNM1HscrqJXhFrun3Tg1niT9GSsINL
	 dE7hqH2xKifqI3bggQ1DzKnKdSnTVwoz7EUr/7n9xOUZ+QNzXT6yRdRtxiezOK4LVRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tS5pn8Yi;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05E606A326
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 18:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD05E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tS5pn8Yi
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ebec7d5dcso17988756d6.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794334373; x=1794939173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
        b=tS5pn8YiT64Zd9lexBBZTQYgUn0ddUenE2ATM8vMaZ1MPspNzyROAIXQHAXOUwIrac
         5FpzRX+iTDtkR0zhccjnG59AFXZKzj5UpgnP1iJEC7nuuC0xu4MQ+0Bd9LfClbfc7uzf
         IMovpPts3lyTygm2Ue1nDT7LhW2xyvsJBoT9t1XlD7OD9gf8XGs245NMk6TLlfaA5Cmu
         xwKxenpVK3Xr4KOyt6vXpwBuiKn6psxaZ0Y+AZf8RVc611D6x4COmbVGw6l62uSOxQp/
         i9Vg/iUhtOmE+rJlBiF/9c4q7ZO9RzeqsPBF0emRYoDIN83Wcx0wOJAbsg56/bI0AvQ0
         j5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334373; x=1794939173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
        b=Xky8HOArVHrEyB+OqmLIEL3hjA9AsRRK+1W/YlScQ5L1CFuxRyLratEMgk7hfBtTA1
         8sZuHqj1ijBYxKQUOkPAAozzAdJzP9dRpAeRnlRMO1VdenIvLkSU0C+sES9hDH9uMdmc
         ssb8Q/jyH63I5iC9viHxZLUQ26hg4p+xkpYlFdcJvhAVEDZXBncHQ7Sc/aSUA8yLNyqO
         e52EavtE47uq5gBqbg8HmxpwYHRk85JAg1diSY5BQUyB7iiG8otJFYKvDdMCjXkCrDlM
         AaKqqeUmnDvZTOlzcI5/hLPR5DYXno6n6Xs4P3cA9SxCvOcthm24nlOP1sr1aqGc5Cfv
         wZMQ==
X-Forwarded-Encrypted: i=1; AL+hErE+PaiN1LGBWj4RW2pcXfyNboic6l+qCNo+YOA/RNUFnFFnUYjPy6RnEH11qCjmO17fDmlQpzGC/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+iUhrDeWWQH8k9mnOAEINaKhBb0wjq9hP9QPwt737Smt/KhdlF
	TRvxRfphV8QokRd5+dTv4ljBWPIaLaACmrmMgNn/YquOIsoiwdcF95ON
X-Gm-Gg: AYBFou3O1V/Pi3z4bJFk46RgO4Tb/YXG/CVBaB/i/2TsWPts6X/0D0mJbAueMHhPcA1
	InIL0ot6D6x9WdkJt7CXINFa+ARsZcHkbtqTk71LC0exSGd90iwhuroOEnUJuXdgvWu6xV84NrG
	ZtA2nTog9uDftR7IblOvMhzpFOk1kaLtHWC2rxyb4zaKtZoD4kGIIgEevBf3ZHP20iY/8i6oUoh
	2y4R+fsY1UrzcU4cP1D3sd2vyinPmXtC9nFSFi+m24efxXY2K/lWw8J6B8ZpqVMwBO62poa8Ava
	F6RY7XqbsNaQch8TI3lP/aPdnMdDde05yRyyYZ9VTIcMimtjP9nrstAUHo0K8WhPGYckeeEOiCn
	wJGQX9+PcVLCp/7Zl3mLqeNqjDu6gewwj9v3O/YG0R42RIpfNkuTRNJ0IT5DN4zehM97xpIveS9
	kTVSHcSU9610DctvknAUpAHTQ/q6nsnNh8GvmGaqJFeqQ863EwRz1MpVkJBj7evALt9nGX9RM20
	8J7HXGPM9n6P5H666L24Zp9RUSRV8BHenodco6dZvoPJccRg9dYP8dUuxLE2Yp1mPoRr5BPyvVQ
	hdAL5mOvcLoOOU0arK8ovbXYnsEf/wXsnLAunhYf27/yOc0C6zeEZjW8c6/6zPjnek/QkTocLVL
	EOoMx67bzJXbNegxikHRsHcPeTCATxc5H0Z6ywMr91iDAU4oi2zDIVZe/J9lARB+W/NWpO8uqPZ
	UGzr83WYV1cqI5AE8SVWMiC2l4YjkHoc4vgZ7EuLRgpnJ1UeoEzH/+T80J2Bfm7qaPIUMTXjiq2
	Zuhpssp5NKKJtQxhyltkutqUXLzuOza47xx5jR1B2cLuA==
X-Received: by 2002:a05:6214:238e:b0:91e:9db6:c324 with SMTP id 6a1803df08f44-91f041351bfmr1113006d6.40.1794334372476;
        Tue, 10 Nov 2026 10:12:52 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5024:4b00:940a:c6ea:f292:3644])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f017737a3sm4800156d6.8.2026.11.10.10.12.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 10:12:51 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com,
	quic_anubhavg@quicinc.com,
	Vivek Sahu <vivek.sahu@oss.qualcomm.com>,
	Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/6] Bluetooth: qca: add QCC2072 support
Date: Tue, 10 Nov 2026 13:12:50 -0500
Message-ID: <20261110181250.47751-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
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

Tested patches 1-3 on an ASUS Zenbook A16 (UX3607OA, X2 Elite), 7.4-rc1
based. The controller (product 0x20, ROM 0x0101, board ID 0x17) now
loads ornbtfw11.tlv, ornnv11.bin and ornbcscal11.bin instead of falling
back to ROM firmware, and a phone pairs and plays A2DP audio.

With the mainline A16 DT (M.2 E connector, no Bluetooth node), patch 3
creates the BT node, but the card only powers on with Manivannan's
"Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq" [1]
applied too. Without it, hci_qca asks for a "bluetooth" pwrseq target
the connector doesn't provide, W_DISABLE2# stays asserted and reading
the version times out (-110).

One of five boots failed: the rampatch download timed out
("command 0xfc00 tx timeout", "Failed to send TLV segment (-110)") and
the "Retry BT power ON" never completed, leaving BT down until
userspace powered it on. ath12k was bringing up WLAN on the same chip
during the download in every boot, so I suspect contention there.

[1] https://lore.kernel.org/r/20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com

Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
