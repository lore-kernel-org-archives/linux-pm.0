Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321358;
	b=PNY61jk73cqUToG+U75jaFc3XKc3PNCzLCmLxdXtntyku9yQH5SsDeGvjtVBag5oBmiJ
	 VoNV/+YEprKcoR0A2hoBfGSdKECbqBqcZ8lLvKED7s0AfVkZZC9fWlRWg5g8bOX9RS9Ls
	 SqNLHqG7QD6ef826PzMv3h3yZFTdbdPar94D4PbYRuj/nOI0v1WF0fAeSS/MrTZ11drba
	 Us9mtFcpy9SV+o1bzJRZDX3kJaqbWUxUccaAbf798uuHSNwpoPvJ5zfQ9J30olXoaDSl3
	 SETlarLzIp55aEyJ7pkan2OD9Tic/D28KPPU6cc2hgeyVwh6+fa8WrHB5FoTwVLP8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NR3OLn3RRpm9Cqw7PJJDQ7C1uwyBOEL9xRH2ABlyeNw=;
	b=S97CSxtFS880xs1KV6VEkGjVMH1KlSdCeYjjcw1+LdZF787Ef3L/4hXgX79sB6HjeJGm
	 uOF0Em2vejO8VlAaUlPsDfwTunZ5YbpRzYL6ECd5PIyLumAjjfEgmQ8mOf8XAPbnOMnTh
	 vioWDCEwIcTMwuNrdX5PPH+ciwdysScHS+TYImR+cVbm1cDraY8Sz08++RHxd+Gbgn3SW
	 9hkYKV4UUnCQP9NlWvpOqglovaTWkb80QWtrDHquVaIB7chSa9pHiU0e5DUlNTsjRRNAK
	 7i5Hw80H/RXGkJO81qMReIpvBdA79CN41WpIYxS0otIKwzm/ah8nSTOomhaqhDoXKLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mZWFBSCH;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328B3606A31E
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 00:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 328B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mZWFBSCH
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c45111bebso68674f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793321357; x=1793926157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NR3OLn3RRpm9Cqw7PJJDQ7C1uwyBOEL9xRH2ABlyeNw=;
        b=mZWFBSCHWfNScv+mYtJo4pPqB5UN/B45yA4fAL4Qu4/Uhye7VATQ3ZO+6aA/fgyzEd
         bHlf0ptiaf7BEgVmFtcro+i4T/7est30ZQTXO2jYCQsylI+GvF3viByEYy7czkDzpc1K
         S3f0AwtY2+KYflq4p4rqEVFYdy7ruIgQM1IShG/+6RJiJ5BL6BG+Q/wUbpGGuNhhq+cY
         b8lMrRNbFUeQxz9txyvJn1UlKW+0rVWC1Q3VvzlpgPqjlVAscmbPCGZCQJL4wDE7HpA5
         BXusZMeV18Td2mVZFuKBXg9HrPyTEMLPYr1cF7x0B3mBF+ZybfWpsFyP6yH3y0ldIcCR
         YWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321357; x=1793926157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NR3OLn3RRpm9Cqw7PJJDQ7C1uwyBOEL9xRH2ABlyeNw=;
        b=MztQOrbTagA/J/tdI0JJDWkdYEiY0/EA/xJMV0S2wOZLbs7VWUQl3AhztqeUvUcA/M
         XzsWEFHoOFIWzf2oPiTOsPCusTUqECkaaHWqWbw773+IDJ26rBOjrO98bzT8Mkyo5CHm
         ZofoccyJ58HvQsE6uHzVaTAI6zuEWDNBciDX2zYV5+DwlZpazOMv2lmuj9Y4T6+PobGp
         1Sdplm3KztxPVCVm5iXiVFHAUaEU6saBFhdjEH609weXQsp48acESmNAhL4ODbjERp8H
         lkXYcxZFuGoP+X9vh6yoZGgQ1B+IdXl8aeKkeGUt4FEo1FeUrMtcLc3td1fklYbJ09Cw
         mnKA==
X-Forwarded-Encrypted: i=1; AKwUvByZghFQgyUP7fuJUwU5A6JcXbjlgy4RBBEnd2c9QVjECXBDP+6hSG02FfJ/T/hxaFaFP863Rg7NIw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL2HVQqKrKvZ7iU4kbrmFTo1TSxF68vhWi5561jxjUId08TQO1W
	VtVKZRzZwOlRBYvPyU+5JJEzAToatKoo3xq1G1eNtXI7dIBVNfZHzDYh
X-Gm-Gg: AYBFou1ySx82gB+KI2iiOJT5lia0sPQx6V7mFAmhPQ3onp4h6sqUvTcPcPoPtPKg2A9
	GsTAfe4xymPtflD5UvAOwtZdCKMhzPb5uY0hjwuYK1QNLtVlgZI24pHP+CW2FcEUh9XtOjTQGbh
	6Y2lrScUwhMdzZuQ5fx2JY4rvOG4ZDwpzg4qQy2rFH1VB2Wqvx1lt0fFWRTRSKHHPZJYlhFZ1wM
	vFeGXJburqQgGXdakSxvmeHWJ0APUVbF5huMF2VJwH9OZqug8yTBG+WwgVrbg867C53WsnGPTmM
	7v+sxDbPb5Va8wOLg8ZUIUmZw3/Rh6rENwZcf0gRwKT7C2KgXKq0EJJwIvtGfwlGdRNJ8ur3YG2
	Y5ZFB634+wnpzejPCXcMpaGd0vwv1z8wER78Mp4T48mgIgDbUSwf85BRZvQhQeBFHT31IrzKJRR
	RDn+RWSMVgeJsivmYp7GTGcT3qlH55WgnINPQiEx2WjsBLW8dWLbvQTZR/J+47JmJUVZxDo8USV
	ghIEij9HEJ543iWKrNmsa70oAGclJXryCCe2klTwgOFZs41dBH1kSjerkenonxJzCDT98vJ9u5M
	fqEIHq12DqApiD7zhDV5AnZwrvH49PtDR58nG+JQ6ucZ+n5XiTQFmxJwQQ+wYRLP2gYp2ITttlx
	C+9yTOJhCBYWgtvI=
X-Received: by 2002:a5d:5d06:0:b0:48e:2a04:4ea3 with SMTP id ffacd0b85a97d-48e6e2c05e3mr2211332f8f.8.1793321356382;
        Thu, 29 Oct 2026 17:49:16 -0700 (PDT)
Received: from iamyoubutArch (smal-20-b2-v4wan-173097-cust1152.vm20.cable.virginm.net. [77.97.36.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728ddsm158055f8f.9.2026.10.29.17.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:49:15 -0700 (PDT)
From: Filippo Falezza <effeffe99@gmail.com>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: Filippo Falezza <effeffe99@gmail.com>,
	andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Add initial support for Qualcomm SM7250 SoC
Date: Fri, 30 Oct 2026 00:48:43 +0000
Message-ID: <20261030004903.1068342-1-effeffe99@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016042432.824-1-sreeshankar0910@gmail.com>
References: <20261016042432.824-1-sreeshankar0910@gmail.com>
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

Hello Sreeshankar,

I'm bringing up mainline on a Motorola Moto G 5G Plus (XT2075-3,
"nairo", SM7250), and your series is the base of it: I carried v9 and
have now moved to v11, on top of next-20261021. On top of it I have the
rest of what the phone needs at SoC level: TLMM, the apps SMMU, USB 2.0,
UFS, SDHC, the GPU and display, interconnects, IPCC/AOSS, the modem,
Wi-Fi, IPA, TSENS and the ADSP with the LPASS codec macros.

With v11 in place of v9 (only the GCC driver differs), plus the two
sm7250.dtsi changes below, the phone boots with no stuck clocks or GDSC
errors, and the clock messages at boot are the same as with v9. UFS, the
SD card, the USB gadget, the GPU and display, Wi-Fi, the modem with SMS
and calls, and audio all work, and three s2idle cycles resume with USB,
UFS and Wi-Fi intact, as does a wakeup by SMS.

Tested-by: Filippo Falezza <effeffe99@gmail.com> # Motorola Moto G 5G Plus (SM7250)

Two changes to sm7250.dtsi that I carry for the phone:

The cpu-map puts core6 in cluster1 and core7 in cluster2. The kernel
then prints "/cpus/cpu-map/cluster1: empty cluster" and drops the whole
cpu-map, since it looks for core0, core1, ... in each cluster. SM7250
is a single DynamIQ cluster, so I put all eight cores in cluster0, as
sm8250.dtsi does. This is the same thing the review bot raised on 5/5.

The cluster idle states: the downstream lito devicetree uses the modes
0x224 and 0xc24 for the two cluster power-collapse states, which gives
arm,psci-suspend-param = <0x41002244> and <0x4100c244> rather than
<0x41001244> and <0x4100b244>. With those values the RPMh sleep stats
show the SoC reaching CX collapse and AOSS sleep in s2idle. I haven't
checked what the current values do.

I'm happy to send both as patches on top of your series, or you can
fold them into the next version, whichever you prefer.

On 2/5, the bot's point about ftbl_gcc_cpuss_ahb_clk_src looks right to
me: v11 changed its source from P_BI_TCXO to DT_BI_TCXO_AO, but the
table entry needs the parent map's source value, which is P_BI_TCXO.
Nothing sets that rate on the phone, so I can't confirm it at runtime.

Once your series is in, I'd like to send the remaining SoC support and
the board devicetree, so that sm7250.dtsi has a board using it. Are you
working on any of those parts yourself? I'd rather not duplicate your
work, and I can send them as a series that depends on yours in the
meantime.

I did the testing and wrote this note with the help of an AI coding
assistant (Claude Code); the results are from the phone.

Thanks,
Filippo
