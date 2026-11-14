Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690759;
	b=QRDOvBqZrN42nyrs0z7x+rcZLFydXsd0T9yXfgdx1YHAMSj279eVTH4DUYFAbkIx8G28
	 lSM8NTMY9P2Yc+odeaK8m/0BoIzFQcbkFk5ccuo8i8QpHmWh0NrQ0gVX0U6BffBJnnKGx
	 3zq7eU/ovsWrdaxloDiu2wPiPWeRGe4c8QZYlGV/nRMwBPweddV9XLHAYHWdAH+bXHt+I
	 sF8WWfqlj6bT3PHA1Cp5dngpXhzYd3bP5uebugNo0WdhrUorqBygsVBnyVoCE2rfynnzR
	 l3HlBbPr3fmToUIR748shO49an1qM9HxcHxxzYJYQzyCBSSfMku3c4jni5SrhkDjNDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fYKKHnF9THpqWFzZUjRJH65VqrOR/R487VmPofFOtpQ=;
	b=sVF4ig/81VkZ3JrsYkLDXikI3Qu++JCDWVHCMKHtuxttynJweQPCt/IKPJJB1HEZwi22
	 cxAyeIg5M5+rVvrqBMBLnsQ77BcssNE57BqjEDK4jvO/gd4UbNMLP/zNEjRDzdO0dAPJE
	 wQ9jF+qrtWvstW9rqxbLiOm5bcMunV1Fb69Au12doVTF1SKMVw209vc9AfUI2cSWUX2Kq
	 jyOEBebe8Z71jYWal9Xdx4O209kZa6VMWb2awMMOGCtI8afIafKB979x9y8ltEZs2NFni
	 E0bQmVQ5kgkYLD2sKle0ezGpTljNPyGSMzJTappmici04MNmL69E9Udfz1Yhy3WUYog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyFD5umR;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FE606A32E
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 21:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A8FE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyFD5umR
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so16553505e9.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794690758; x=1795295558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYKKHnF9THpqWFzZUjRJH65VqrOR/R487VmPofFOtpQ=;
        b=NyFD5umRBWuWzXRNHhhTax4Br1mnDerRXAyYQRqz/o8qiZj8KHC/Tp2JZg61hJWeZD
         c8EKK7CxhwCH3BkUdQk3CuYhPMeeGeuyy7RPLATQxOFOTuVmdu1Fzw4pCjVzM71OKepP
         dkY1LIW5hV4G8uVGdCJfLvwnvLZfk2ZpdzJHZsAbLsxgebNvdh9wBmpyQ7e+VRNgsDF2
         7fWJjnv/jyW209F2rSZ369d8XNIyGTqRbjesvAMJ7c3Uo2gt5kEyxUgVxVv+YH1NZNcG
         H5o41mmOUdkevFgYBvMPeo+M5b9Bu/MXZDvto0zw53ZYfHMvfiAS0DpeeYGPSu79zEfD
         4f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794690758; x=1795295558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYKKHnF9THpqWFzZUjRJH65VqrOR/R487VmPofFOtpQ=;
        b=yRW3/yXeZT4/u6X/hxjvy5LUKXY2Kn0kLbGLiSmHtxlUuHJWG8D4VztJ6oHWV/57WO
         Dd0rb4ZhsMxwtRAEU1TxWLIpZ8D/YF9lCk3cpK4jpxh+ZYCk52WxenLLfb1rrgPg7Ks7
         THA3TJqQ0hsi2gEtLhmaQ+rTQgQ8SknwDYqvV/gdNH0EEmeniqYyrAHFcZNLZHz0Kq1l
         PdR32l5L/cDjBkAoHQwmhzW8rwTn2a9biUzKznOwJdVaLRaxNxv2DQw1Xu2JKKaNe7QN
         EUbrhxDkGTXYdayvojFnQ1ZzKTkHnXQ/C/NjKY6/yJ7ePdCtEdGTnM2wvEC5FAEbwlPT
         4j/Q==
X-Forwarded-Encrypted: i=1; AL+hErHvXuFoa7QpOYRSj9rmSgNOtjn4pZitBEncbEZC6IIH63lr52hAiScO+Lbc3aKbBf+Ivvs8SFlc9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HfAqB9XqreOpri27IYt0ewGM5X9rd85mAPoMbrqlHY6isj2H3
	h8qIoaJaAnFCZcRtGWyQvmn9+BV02ULiTOKJ1mMTD+JKviFtFEi9EK+Z
X-Gm-Gg: AYBFou2pH32jHxmpV8J4Q1rL9OY/9dbXjQUN8Q4yDlSvmK1vkHPEWahu15Iljn/iO9e
	z6ssGYYs3ivsK+YgnyEDj9bUQluzryZlDn/3hxz5eNbaSOXq0cvnqENFf3ul8LUGwaMmTu/8lC+
	LDfxJ+CJALbscUzNazDsF8JEk5Mk7f0Lad0SlXvQ98H5W6JOAG/NkjAphPomk+soo7ZmPYtYC98
	OYzM81Fbe34A50okleDr44sTZXNgZUm38jU2W6Ykdyr6WYe314FZRn8x3LIrX3cqQNHZ4qH8o0f
	KpqE/A0irG3QOhVdg5xftGwn5mau4Nv9zFqnxrZAFm7ew2gAIYX6HsX9AN4LWkiwGitfylvxQfM
	i+Dp3goldR5W5JpgwwAeWCQPPakJiSYR/DG54pNA+arcX0/Tu21+H+JuL5RVfDe7sIZiyxROfR3
	I+tzj/SI5A2veR18T6Ep5aCN30/lih3GRihwW1dwt7joPYhdgPDXsNkCsD7FYeY5Z2JaRIGyGqx
	vFJ294t5zQYBJ9/AlgVpdSjCB4KKn+ojQMcJFCtmncW/4aOennRgSLyFkMMBSf2aOfbXKB8cNsD
	0TlpuV22TDJSymPi0iDJrqafn6M=
X-Received: by 2002:a05:600c:e557:20b0:4b2:61e5:b2f4 with SMTP id 5b1f17b1804b1-4bb55a583bbmr84669175e9.11.1794690757810;
        Sat, 14 Nov 2026 13:12:37 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm267895855e9.4.2026.11.14.13.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 13:12:37 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Halliday SoC
Date: Sat, 14 Nov 2026 21:12:14 +0000
Message-ID: <20261114211214.1928927-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113-doberman-of-unusual-beauty-ce6a57@quoll>
References: <20261109-halliday-icc-v1-0-def7cf786f75@gmail.com> <20261109-halliday-icc-v1-1-def7cf786f75@gmail.com> <20261113-doberman-of-unusual-beauty-ce6a57@quoll>
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

On 13/11/2026 11:31, Krzysztof Kozlowski wrote:
> Why isn't the rest of interconnect patches (bindings) in this patchset?
> You sent it the same time just split. Please organize your work
> properly, so subsystems receive all patches, not pieces.

Thanks for the review. I'll move the OSM L3 binding (14/17 of the DT
series) into this series in v2.

Best regards,
Stanislav
