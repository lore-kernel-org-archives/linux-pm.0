Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763366;
	b=l1oIr+zdkZsg2NdQSjuu4myl+vVhk5Vdx1qxNsNQRydzmTHEUgLpDN0BeLt/rt1ckTIP
	 kVnhY/2Ukbv2kvyxbxGCzxpI8ud7POO9TjUbeDsQp3Icz2WqZEvLOR18kbuFHwjo6Sk/S
	 2pwGHx4B02fJbgexhg3oxoUh2nlQ/MP13FqQTm3m/mL6dKw4grByRZeUKURTNUldAeRIf
	 QUYUl9gWzObrTOjkEh9wOF3JzSGketkR2sLo14hNV1ZnxEBaDtERbdT7yV/mI/uvbFQgV
	 b0Em1p0DSW1zzg4RQeph25l5+76FGfP2BBJ1mbPdRejwBeFu+GrJYTHRdchpak0hmSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763366;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=69lzW9Dx4vrrBBMrnrpkZy8dCqM22sxjci32eKehHVE=;
	b=Q+dO8FFYluKbqU8j9xGG5IJYZaPnc7raAMPsnNW4PUqKaosO8kWHJPD7mHaf7ojTspiG
	 NarVQgvcLKwLQtGXW2873DSiyG6VJp2x/XdlAvAtcLDKioBuxSdF6rOzyDXHjy7uUZdTM
	 k31qQhW0FHVcA6/8GUQw71B2JrY1/xU6B+i+3+YCG3xU7NVKgosy/qvvkZN0Zori/pko0
	 MMrkm+zPx6yX2SeqFBx49VwhYGGY806UFMmJlYXAs7ieVoDbWDYOBjo750uhvq7Ap/9CO
	 pt/dEMMJqABYz+lPib59Ba2QZXK27EOhGeMukE8FFnxQHM1s1vHZU4QihpO97qje4gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ai3Zn2Ua;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4F606A31A;
	Fri, 23 Oct 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB4F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ai3Zn2Ua
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=69lzW9Dx4vrrBBMrnrpkZ
	y8dCqM22sxjci32eKehHVE=; b=ai3Zn2UaGW9tCJckz07+NgGTTSF/trsdy2gyB
	O9qPjS4Ykkp4WiiL9126iFgRfEW0QEUXfR/GbKYX/CK4wuUokREW2UyWCBDpL8VG
	TP1o5tDRE4CShEm97rcaVLYlZIZ8RKOunwnXo7IgXivOAEDVjrikFsVUtHNzUzGs
	gSKAYQ=
Received: from [127.0.1.1] (unknown [114.214.178.200])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn4jbgZdtqHlQ1AA--.1033S2;
	Fri, 23 Oct 2026 21:49:20 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: konrad.dybcio@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Fri, 23 Oct 2026 21:49:20 +0800
Message-ID: <179276336012.97124.9436748752781883311@mail.ustc.edu.cn>
In-Reply-To: <63cf18bc-5c89-4a55-aa15-2550dc47c155@oss.qualcomm.com>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
 <179259054168.209323.8102186130128474174@mail.ustc.edu.cn>
 <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
 <179274197125.1374502.18211548118625978753@mail.ustc.edu.cn>
 <63cf18bc-5c89-4a55-aa15-2550dc47c155@oss.qualcomm.com>
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
X-CM-TRANSID:3pYKCgBn4jbgZdtqHlQ1AA--.1033S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1DKrW7Ww1kXF13tw43ZFb_yoW5Xry8pr
	Z7KrWYgw4kAFWkCasxKw1jqFWfCws5Xay5JrnYgr4Iya909r10vFy3Aa45WFyUCr1vgw1U
	tFZ5K34qkFWUu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgtr4UUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREJB2raZFVZigBgss

Hi Konrad,

> Did you try reaching out to the vendor?

No, and I want to be precise about why rather than hand-wave it:

  - This tablet (Lenovo Legion Y700 Gen4, TB322FC) has no vendor channel for
    kernel sources. The public support surface is consumer warranty, not
    engineering. We are an independent bring-up, not a customer of theirs.
  - I also asked the person who is upstreaming the mainline DT for this same
    board (separate thread, private) whether a downstream tree exists publicly.
    There are partial downstream trees for sibling Lenovo tablets, but none that
    covers this unit's QBG/battery path.

So "ask the vendor" is not available to us. What I could do instead, I did:
boot the unit's own stock Android and compare it against mainline on the same
battery.

STOCK ANDROID SIDE (slot a, same unit)

  build:  Lenovo/TB322FC_PRC/TB322FC:16/BQ2A.250610.001-BP2A.250605.031.A3/\
          ZUXOS_1.5.10.259_260611_PRC:user/release-keys
  dumpsys battery:  level 94%, voltage 4309 mV, charge_counter 6439000 uAh,
                    temperature 32.3 C, status 2 (charging), health 2

Limits I hit, stated plainly: this is a user/release-keys build, so no adb
root, and SELinux denies the shell domain access to
/sys/class/power_supply/battery. I could not read the downstream kernel's own
power_now attribute. Two things I could check from userspace:

  - the Android battery stack never surfaces power_now at all: it is not in
    dumpsys battery, and a full logcat scan for power_now / BATT_POWER returns
    zero hits.
  - therefore "is power_now disabled downstream too" has no answer from a user
    build - the platform has no validated consumer of that property.

MAINLINE SIDE (same unit, same battery, same QBG firmware, minutes later)

  charge_counter 6489760 uAh, voltage_now 4285000 uV, current_now -1003000 uA,
  temp 32.1 C, capacity 94%

The shared QBG values agree with the stock numbers (charge counter within 0.8%,
voltage 24 mV, temperature 0.2 C). So the property plumbing is not the problem:
the only quantity that disagrees is POWER_NOW, and the stock stack does not use
it.

WHAT WE DO IN OUR TREE

Our SM8750 battmgr description simply does not advertise the property (the
sm8550 property list minus the trailing POWER_NOW), so on our dailies
/sys/class/power_supply/qcom-battmgr-bat has no power_now file at all - that is
what the patch you already have does.

If a readback of the raw downstream slot would settle it for you, I can unlock
and root this unit and read the value directly - it costs us a slot switch and
an unlock, so tell me if it is actually load-bearing for the patch, otherwise I
would rather keep the unit usable.

Thanks,
Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

