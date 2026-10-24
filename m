Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853200;
	b=f2pUUefrSFRH7ov7gxuY0p0iJA18ZBfFB/tyZCeIonUe6y5aZ4q7vzjWkgb0eopIk7vs
	 RGENFfiydNQWVJQmkPA1eE13beoGFtpJvna5I4ufLgB5RnQIkaP9WemdX+FcpadjIxgHO
	 8z/7LUpIOWES4o43SMFXN3iW8o+Txgeafm1jla+5n3icTVAoqjs16FvY+adBU6x63Gk5b
	 XyTJZFXR+f/nOtCkkyz1EnSeBX1DCjPLm88zJDzPbk497TQt4YOcy4S2ovZH7Ne7WOrWn
	 xC4tNIRpt/8nl2AKlVWEsvicIZdGpeXGb4Q3eM63IgymqJipNAjAWjY4U9zJAwmNN6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853200;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=UeniXD7iZg+6qwS0rvztEQ7XsvYpfeI6N8iAII8kY1o=;
	b=4t0vs/zRM/boMQUtrdRmbFg7A/kIPwnaHB4JLqmFxEvl9+hbrr4xSK7L2UNlk4y52dpK
	 qSiHVLsUtDAsHEnUs4SyBFDtT0V/RXYKkIVYXUKzH1HkWczmfWswMfVpBDbGL4+jlGKey
	 ciUdls09DJKLX2aPbXeFXrkfnnLU/CUw0lv4GYKZ49GGEJarAOjEOcr92kFVoad1PgFFP
	 2FQ1L8WGzjlvWfFU15eYHMM1HULHqwFjMcG+zcUC04OcFRkUId6Ws5X9bniDC9qdd/+Y6
	 A7/55i4sPx0n6G9MKJ7npSEALfpuMbhCBU76w3N0prhXsc0+bvtDeCiYTUlHecZ17nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A37606A31A;
	Sat, 24 Oct 2026 14:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAHD5_ExNxqNGtHBA--.56076S2;
	Sat, 24 Oct 2026 22:46:28 +0800 (CST)
Received: from WIN-B62RPRBL2BM.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwwXPDxNxqm+jwAA--.12400S3;
	Sat, 24 Oct 2026 22:46:27 +0800 (CST)
From: Zhu Ling <zhuling2709@phytium.com.cn>
To: tglx@kernel.org
Cc: Zhu Ling <zhuling2709@phytium.com.cn>,
	Marc Zyngier <maz@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/PM: Re-enable chained interrupts after hibernation
Date: Sat, 24 Oct 2026 22:46:21 +0800
Message-ID: <20261024144623.112667-1-zhuling2709@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87mrtr1p8i.ffs@fw13>
References: <87mrtr1p8i.ffs@fw13>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:AQAAf8DwwXPDxNxqm+jwAA--.12400S3
X-CM-SenderInfo: x2kxzxlqjsliuz6sx5pwlxzhxfrphubq/1tbiAQAPAWrXwUoEpgAms9
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhuling270
	9@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CF1rtF4kur18JF4xCryDKFg_yoW8ArWfpF
	ZrGrZYvrWkJw10gan7Gw4IvFyxGrs3Gw4UXwn3K34DZw4rCFyvyFnag3W3Za4UCrZ3Z3W2
	vw4Yg3WfCF4DCFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Hi Thomas,=0D
=0D
Thank you for the review. I am withdrawing the previous genirq/PM=0D
proposal. Please do not apply it: forcing chained IRQs through generic=0D
resume treats the symptom rather than restoring controller state.=0D
=0D
I have since reproduced the failure on the Phytium E2000Q platform=0D
using upstream base 17bb0e2f6c8043f70a693a5f3797471cbed354c8.=0D
GPIOLIB is disabled and no vendor GPIO driver is involved. An independent=0D
module registers either an ordinary or chained handler on an idle=0D
GICv3 SPI (INTID 189) and injects a real GIC pending event before and=0D
after hibernation. It has no PM callbacks or automatic recovery.=0D
=0D
On separate fresh boots, the ordinary IRQ delivers both injections.=0D
The chained IRQ delivers only the first. After real S4, its descriptor=0D
still reports started=3D1, disabled=3D0 and sw_masked=3D0, but the hardware=
=0D
enable bit is clear and the second event remains pending. An explicit=0D
unmask delivers that queued event without another injection or handler=0D
reinstallation.=0D
=0D
A GICv3-side SPI context save/restore revision passes the same test=0D
in both modes: hits=3D2, injected=3D2, unexpected=3D0 and rescued=3D0. Each=
=0D
mode was tested for one real S4 cycle on a fresh boot, with CPU0,=0D
disk=3Dshutdown and pm_test=3Dnone. No introducing commit is claimed.=0D
=0D
The test kernels contain a separate 8-line USB host enablement, but=0D
the unpatched test leaves the IRQ/GIC/PM paths unchanged. The test=0D
module sets the out-of-tree taint bit; both conditions are disclosed=0D
in the new cover letter.=0D
=0D
I will send v2 as a separate thread, linking this discussion. It=0D
preserves SPI distributor configuration in GICv3 and does not change=0D
genirq policy. It is not a claim of complete GICv3/ITS S4 support.=0D
=0D
Thanks,=0D
Zhu Ling=0D

