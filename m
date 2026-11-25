Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596436;
	b=zFOqw9QrLP2fjMtGXnPRhVSCtbBOQ4WfK/b48565Y1vPRjCjukzlh3LVBW1nmQK10ql+
	 eSSuiqnhXfWeCiDqdzyFptDhec2Aa5Cubj/HetL+lBjGrRjsMFrwaNC00/H1C25Lv6tPE
	 mA89MD/Q4zSV/mod4pMEDI4Ao1MNYe+60k8+dhK6R0/Y3AAqrPK4xoWLesfgH7pLqa+hW
	 16VNkUo908TC3XOmPjHrmNxJq2PoqX8lsqqs9A0i4lUrVGo++h84n0WnoVGrgTCwmVuDs
	 +R6F4ZavXuGgyQp2OG+u9IvybbDvllS+GRCLiGC3IoofI5+opQ83Uo/oSCuVcnwSZUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9JczosLg+2tleGLZ5rgCSANI1AUwxWfmCJsgr8HB+Wc=;
	b=gqJXXDc/qkn/wIES3GJfOqzNOnFQ8yGrMkvzkNXcOVlQCfUI4u6ICX4VUkUutKPtiYr1
	 Rn5INXUeusYiqxTCQfDhN4ZFHWZwvR0KPtwlHtUumwfipZfTFHk9+UEoPLG3XD2heHlIW
	 HrHJEyaZNKzKLJKypayj6sAQCFW4mOn02wnurdKB6EQG5ioKBn+TTKouCtF64UjV+80aZ
	 7TZUB5w+K4//YeXV3dGa3CPI+TT0ZRsYelVzneWwfToyTpaTZSwb5j2l2lh6p9pv8rIF+
	 VeftF0VikyETM6HaoW/WDhU4cffGMXHLEtKWB8iMHppiGgX4+31SKofngfJUbbdl/hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K0NlGyfj;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F8606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479F8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K0NlGyfj
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so3603445e9.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795596435; x=1796201235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9JczosLg+2tleGLZ5rgCSANI1AUwxWfmCJsgr8HB+Wc=;
        b=K0NlGyfjGbdsgVftf6yhorm4vLUo1t9RKlAFZqCeGpWY95ifrSNlBMEvJt8g36o3zA
         mOSI+K5NZHGiZWPJI82G3yXKlGWnXFHUZsZO8KkXkOKPzsVAHH2KvvX/RKs+THnjzXIf
         xLj3aDZ88CsVZsaay+0xHYa64btplUhlmmnnjpcV8K4JfHlhCVgWlCbMIwLF7PDQB0N4
         FwGxsELcIVT0GAKexwXwroYw6u4NItk9jqDiAuKZvpFdMbsAezHIapq7KDvSJp4FCQYp
         mbkjkTtyVn41YtrPpToJR65tZUNW0Nfp18yN9rqjMq1NVZ5pjCg0ndrsaBmB4oH3hpAn
         AHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795596435; x=1796201235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9JczosLg+2tleGLZ5rgCSANI1AUwxWfmCJsgr8HB+Wc=;
        b=Fj2g9F2BUYBd2q5ZAC/nuHGuK5Ux3zK1U0+KGCQct5NF6ci3q2mieTowI6upFwmBww
         xqLsJeqMYEdpHdq7Rlqv5GBhvbsz4XIOkckX965i1Bl477seWgpBaSpVPlcMs6FcPgMG
         XJl2QUE6Z/jgWmJooI9YlKZVXBKzd4RHmtmQOZjc0aB5plL5LtQpYwz13hAm80xuP48D
         TEJOHMBdPwRaopN+IwyfXyuwlTi7Ziw0Kj+8WvHi6G9uF79vIRpWTfVN6uPTJekuAD67
         PB+yvdr60eLGAyPnXXahX+RHr3tCkHKWCPr6OAg62NytTUF1yPx3/iDIfK9lnpFYJona
         zHGw==
X-Forwarded-Encrypted: i=1; AL+hErFR0m7nLX0cgCht0RV2j9zCon7oX9XF37sLCSsa4NQq574zFeIEeZGNFtcZZWTwZoEvUMBymT1hBQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Eu9GASjY82eCpuMkOhFr0agfWOeP/0p8Y4dos2Sq21LuMIRt5
	RtHI3wsVI5pHfD912Y6Dwxm2ueLmRici4Ga0prBq7Rv4LDrTkNqtzMg=
X-Gm-Gg: AZFdTZcEFkeyBMnX1yDtTOlWJvq9OobCOIwPEIl5KyUFIBbxx8HRLYSSTuYeHHYjQpd
	PduA4wdaTqWx09sQjlu8kzICh5VBYdztoDNpdS3DHtSNtrEUPjKCzVrQjjUxd+v3l40DczBhLgW
	/Q0vTR66y5A1bTmt3KTq4nARcMGYddI4zPxatKOt/ek743Gj3bPeRun8VpiQ8kXwXau3JZf+Mxe
	Xk34ue3T/yeMBAU9FD8XC8K2HIOb+caq0bv+/Pi3DE4z1x2M9Tzqls2cBUrvjmSF+cxU314Kq0m
	Q7Y4z8Vmbjn+GHiffw1dbGhEoix6H8ZNmY1Jx6QaIyBqB6MK1C/2/Hv5ggUPvzzAKvU9AjuxW3s
	Ey4BzqU+Cdzg45GBNZ9Ws9d3R6XxEOgtx/FqImjIgXT764OoHPF+BlP7uAr5KpyZwlNXivgxAYx
	JIPIlD8EID3YvE/0eIBE0cbQB7JjqQUpBzzWuG0jRRSjiey5BAcPWM1QQG0ZJmQgkv5txLUnGq1
	EBDqbKNB3S0st0P/52LMQJBWh4pMtuxdOKFTn12/ZErhA6CpAHv+WW/j+/SFWnrZfZn5uWhda2V
	Dupqkg4fos54Ijteoo6t3rH+f8KXC8OzZNDPCPhYdYAw9eI6/Ps9lAqJymwIzvGLpSr3
X-Received: by 2002:a05:600c:6092:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4bb8892bb67mr320913895e9.19.1795596434483;
        Wed, 25 Nov 2026 00:47:14 -0800 (PST)
Received: from book4-arch.fritz.box ([77.39.161.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm465183985e9.4.2026.11.25.00.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:47:14 -0800 (PST)
From: Nicola Nicodemo <nicola084@gmail.com>
To: opensource@grische.xyz,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] thermal/drivers/qcom/tsens: Drop __init from the ->init callbacks
Date: Wed, 25 Nov 2026 09:46:11 +0100
Message-ID: <20261125084611.11437-1-nicola084@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261104145740.2623473-1-opensource@grische.xyz>
References: <20261104145740.2623473-1-opensource@grische.xyz>
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

On this boot path, 7.3 with CONFIG_QCOM_TSENS=m and qcom_tsens in the
initramfs, Samsung Galaxy Book4 Edge 14" (X1E80100, NP940XMA):

Without the series, the probe is deferred and the retry from
deferred_probe_work_func jumps into the module's freed .init.text,
on every boot:

  Unable to handle kernel execute from non-executable memory at virtual address ffffc2f2779b4150
  pc : 0xffffc2f2779b4150
  lr : tsens_probe+0x170/0x670 [qcom_tsens]
  Workqueue: events_unbound deferred_probe_work_func

With the series applied (same kernel config, same initramfs), it boots;
all four controllers probe and every thermal zone reads normally. The
compatible is qcom,x1e80100-tsens / qcom,tsens-v2, so this exercises
init_common() via ops_generic_v2, i.e. patch 1; patch 2's callbacks are
not used on this SoC.

Tested-by: Nicola Nicodemo <nicola084@gmail.com> # X1E80100, CONFIG_QCOM_TSENS=m
