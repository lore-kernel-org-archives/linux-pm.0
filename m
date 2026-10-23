Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741983;
	b=orDaiFS4rKFRoDt1jzRCiajS53pg8aft6PLFOZSp5S0eJjj1X3UUv02TOPI2bWxDW/2F
	 /6wtkvymMhJxkMFc9ZtlNxpdVGoBVP0lbiQ+BvZLkK6KmtqmD/6L0qHD7cDrqDxrxngHa
	 rHKJcagNp0/cRnDQqJECD6nzXYLLZRLphrMr0YvwXqSlQMByb//kzBblPa5sgMgnjmDBv
	 aEvGpRrqF5847rJjTKB/WyfN/88vwTCowOP9sjJQ6xSL1gYnpDMZnRjRbetppzd00cyCY
	 0f3ro7ehi4t4EZveJQqvsQbnJsHq2fiB6Wx0MdZzm58YQooXfghHd0+o3+1DtRVv6tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741983;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8LgOUeTMMRF3Y947VZR22krx9mydMz81qMhIU08ogsE=;
	b=2R9bHUKbHB+6HTCCK8ETFLHN7BsGtd2Yt0w3QEhG1kfdVRyPjO8g4I+C+48SdxoMjcNc
	 /kiXmSUndDWIZzpJPHqEl6ckKGGZuVGTeQsPTjKRA2moSNMiO02u5F/yF2O6w48fib5i6
	 s1Hjrq1IVOhp0G9DWQDZAm7U8iUVRTck3Crb+Er/b9XI8eqZIuj+XO4QKHB4H+iAjPkfg
	 bLioaKaMYur2iGKEmcgNCjqhGX0u0mqY+i0mvohAT/twDjyXckMdf079VzPEUCPuprpNj
	 qZd4dJx9Dvq3TFpEb6o3hFod6oBwJ16o0XYbp5Qj0/I1vT6r1I/IdWknFKEqOIY/DTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=OZMBfFn8;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8D606A336;
	Fri, 23 Oct 2026 07:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C8D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=OZMBfFn8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=8LgOUeTMMRF3Y947VZR22
	krx9mydMz81qMhIU08ogsE=; b=OZMBfFn8oOZmEyX/1v2k/krXTq8Yx02eSo8CK
	Bi3AwK+z6+RW6wvaDKDap5Ihsqc+rJFY0JB/Or6oQs8noLMRkulnsTXbERdVNXLo
	sNScF7LiPZm3dK5d378/Ol4roBwkmv1NaF9kujGpXwIDdnCibhE50YUsPHkHPIO9
	Oc8NLk=
Received: from [127.0.1.1] (unknown [114.214.178.200])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCXFjtTEttqfVwzAA--.576S2;
	Fri, 23 Oct 2026 15:52:51 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Fri, 23 Oct 2026 15:52:51 +0800
Message-ID: <179274197125.1374502.18211548118625978753@mail.ustc.edu.cn>
In-Reply-To: <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
 <179259054168.209323.8102186130128474174@mail.ustc.edu.cn>
 <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:3pYKCgCXFjtTEttqfVwzAA--.576S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr18XrWkGF4DtFy3Zw4xZwb_yoW5Gw1Dpa
	9Yg3yqk3WDKrWrA34fZF429a4kZws3Jay5tFyDCwnIva15KwnIqryxtryYqryxCFn2qw1Y
	yrWYqr98Ca1UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5kxhtUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREJB2raZFU0sAAis5

Hi Konrad,

Answering the three questions directly, then what I can offer instead.

(i) Downstream kernel sources

No. I have no downstream kernel source for this device. What I have is
the prebuilt Android boot image from the vendor plus its extracted
config, so I cannot statically check how their QBG/PMIC GLINK client
populates the battery property buffer. Anything I said about the
downstream side would be a guess, so I am not going to make one.

(ii) Are the properties remapped?

I cannot prove it either way from the kernel side. There is indirect
evidence that we are not the only ones seeing something odd with that
slot on this SoC: the elden port that another group maintains carries a
battmgr patch for SM8750 that also stops advertising POWER_NOW, adapted
from h0cheung/tb322fc-linux-kernel (see
reference/upstream-armadaos-freedom/patches/0149-power-supply-qcom-battmgr-sm8750-reporting.patch,
derived from that tree at 6f97250ead15). Their comment says SM8750
reports a maximum-load value instead of live power, which is the same
observation I made. That is two independent ports of the same board
family, not two independent SoCs, so it argues against "my unit only"
and says nothing about SM8750 in general.

(iii) Does the downstream read return garbage?

Unknown. I have no observability channel into the stock Android kernel on
this unit -- no serial console, no bootloader-level kernel log handoff I
can rely on. The only comparison I can produce is kernel side: what the
driver reports versus what current_now * voltage_now says in the same
sample.

What I can do instead

A concrete, cheap criterion: print the raw 32-bit value the driver reads
for BATT_POWER_NOW together with current_now and voltage_now in the same
read, either from debugfs or one printk in
qcom_battmgr_bat_get_property(). If the raw slot is stable across load
changes while current_now * voltage_now tracks the load, the slot is not
a present-power measurement regardless of what it is. I am happy to
collect that and post it as a reply with the numbers.

A question for you

Would you accept the conservative version for now: add the SM8750
variant but do not register POWER_NOW at all, without claiming anything
about what the slot means? That removes the wrong values from userspace
without guessing at register semantics, and it is what my patch already
does. If you would rather see the property kept and only the commit
message fixed, say so and I will do that instead.

Depending on your answer I will either send v4 along those lines or drop
the property change and withdraw that part of the series.

Thanks,
Qianhui Xu

