Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794814585;
	b=KBE0cSJ7Y7vprtGB+/uW2zRh5LjMh2gVSxkSzXG8jeNQcoQm7tSah1yOi7Aa7XW0PIhZ
	 uGopNsTf5yaOhs6XlyyNg8429qTuuFdDx4mHBB2GGy8KYN899RiExrOXYcKFt2kSHrp2z
	 oap31JYPrYcd6ZW4k78dJOj/CLGsRx9yIQRhExVuX5PjiF7keTc/TqpHT+el9FCj5MfdM
	 tdWGPzcAiDtfhvUADtdqArH2azdQ0bLVUYwbaN1VC7GjhTTsBMIotHxBRRt2mVPM4Q0eh
	 zYd2C6wAPb76L2FnkSbuyJeYOVw5gXuBZD3TwTuuUt/3SiMHeFdAySWVSQ2Lu202CcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
	b=U9XhMXRCk7/5gPJUguN1Sa94pk91wGAniG8LICGc38qHEMpoiHzuHHzJdE8IsUFxQokk
	 ZBRKJXI9Bz0irzYfCD1vgaEm//sv6L9OkNfJsto40/ATq4Avk2Bz7+8FYFk+mrL5HiIUL
	 KYMZIkwIMkNXQIfOmU+4vboUkd4DsOZgZiVdNwD9HqvgKeitcYoUPJ9yeL1k2awHd1Zch
	 aH2DOmbl2jyZSgSTbLiDkJO6LormqmjGRtEoM8zafCPkdgbYoDYfMzFmc/KFO7lqoqI2G
	 Rt20bOBXR/VzeHNSnUFdpnuHFzWT2Nb8ZlzJogTTCa+Ez4P/K71IsqGkpwUjX/aTuZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnQnW5MM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD106606A8A9
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 07:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD106606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnQnW5MM
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso3927625a12.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 23:36:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794814583; cv=none;
        d=google.com; s=arc-20260327;
        b=PAmqXYmqescm4kkQ2qCleEOKVDkm6xKivAuXuNf4Y/SXw+g75fppTXHixa010ZI68P
         VgdlSWYrrNkM8N8AC8j8HFXg3S66YgyB38Xn/jDUs4u2naIa8UvyAqmC+dPg67j46RnM
         z+TAB1mfQVRvq7fgS4NCkpOuWQViI8zFlW2hZCbannsX9cP6oc8+fnbMA3usW+TPBCdt
         0BWbXjcpstlMcxy19CI+ZiU3GiHcZq422lnxbONLpaJzkaK4gtuWxe9whLrkE0d2CZX7
         Betj3KxHOOseZaLjbcf091GnktkTYG/LGF5xViTfJUVNoYpyu2zWLTjOdptMBqhMwLT/
         0GWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
        fh=i8SjSfxD/FeMIvnujTpmRKuVqDlJPdmbpkVR7/6JAac=;
        b=AW/nLaWEw1FL26fZjD+hz2ep8f/OW6l6Dnp+IBG+ShsWZLx0NJOCXzaE+E0/7PuxTe
         OupVDLMOjiR9ETR3eYCQwLUzCWAeSwqcL7MI621P/YD+6TcUUVaxdaGTBWDZDNgYUCol
         GgYAeaqllVjLMbwq8fZqDR7E7xzbWUdHpdijANtbgeNrHaZxNjn591d8mBkl8n5Pu/yi
         dGw0X6cokmuvkxP/xFeW9+LTyykIYJRBldpRhr5Jmuy3UT34mIPp/zktMYUjnQgiPUwh
         Kdjy4tlL+vBwemcv/8KkWM0+nBz01BIKV85riVFzByF8R7SZM9UoaAo3hGWxe2DI8XYb
         1wRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814583; x=1795419383; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
        b=ZnQnW5MMlw8g4UDJend73b2EqQM0QB6Z8uyJYgtQ4aWw+rMVJoWthx1owv+BmRqFOb
         BaV9WEsevPIZPRXbf67ehZ2/dHGqWOZumsHCVrHC+7bSpy1pqBprWCWjAd/qANlycO9k
         mkdoQkVuTYaLPCk8+WXG7XLf0drxrF4UZLTQaG3NK1fY/WNM4/vsqkg32Ngp9X8HHziM
         6hmqdHWBTZh85dtGyW43TYABPZ+oayr3KHt4yRA/5c3HIdT1CHuTrvD6uEWQshbPdDGX
         S65NCW40Wgb6igu9RrFlVaKXoNFE+80lUaqUlStIfZQTiODQiRQkUhOPtunUJCYWnmJ/
         HZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814583; x=1795419383;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
        b=hHXRlgk1SlHSpofS3tATPMy0JU+7Pb7Xf911FH8rSRIETX7RlIjgFx12xDfO6wZ92w
         VMV6gnfCAun6Rirn4gUi9dnmHH0NKx/0eu6xOqdCveMSGhDwgnBM/GHVRvMWePFdiC4U
         tygun+wGnchzC61iDFcNAb0magi/cta4EkTMQnTVodzTzlDoYxehkrZA9mFI5B6L6+AG
         Abx4DNQtU8B5mNj+En4aSGDrfCmyTyZbWpLXBkJe2kJG3EtDBb38fGBPvtAfVqHTDkTI
         8UVEo9tXow6VHNkWEQvgud9S8ywH2sgWo0RDzu5jn0PpPcqoNJg4nrtFm/xiQwf6pNFj
         Bbjw==
X-Forwarded-Encrypted: i=1; AL+hErFXjwkajiwnBlsoQikl40rGHZ/1jGAj8almY8AAGou26UWED2i0bkM8KPnRwwKMO/KB3oPLwwen2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+5Xr6/P4IFwA2e9x5kkhRcYVExwtmvnRlylAFI2AcFtetPgaTI
	KJYuEC8jOjNdr5YhqZsEvyG6QZ9WjbeTEYRZdBvPEcumvoXV6Dd82S7XgOKE9L6KGbbt4p9hsTu
	TbXENydUGHLERHrkVeHu+P3QHyh1oQhU=
X-Gm-Gg: AYBFou0IOKrB/fnhCv3JiMsfI0dQlR3BBewVzpjUwsWwLSI3eDkgyVJwBo1w2yodN66
	0jVg7Gpjwe8aSLZlUF8rCb0jtJyWnz1pjDwOUdPd7z5VwOopn0yKgBrlDRxt1iL6bsXFnMcMvqS
	nRXK6iuoxbfRsrkYvTI/WjRlVMHZnxhaicFR90J+cl7gsNLR8eSH0G+lo5qw15mODd+7rG3b0CX
	EbS9gYUHlBXiwp27OxOFUDmTGAttbdPRF0a4MAmN/VWJDZvfCtWh2JNhduWlyosf91om7ieXhpw
	BSLGdk5/sLBwdyycbe0N7QFXYx9W1L+piTBMEeP3MjJc1PGlZtMr5JRq1T2Xv+JGXvELbwA6kzE
	ujnlVgK9c+w7TONw0huwj+4isK1MKLNJnHin5l1LqNfAsqX/JU/knKhZ+
X-Received: by 2002:a05:6402:5d4:b0:6b5:5fc8:9ca2 with SMTP id
 4fb4d7f45d1cf-6b7c0c7dc86mr6801231a12.34.1794814582850; Sun, 15 Nov 2026
 23:36:22 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110061429.2036-1-linux.amoon@gmail.com> <20261110061429.2036-2-linux.amoon@gmail.com>
 <avpN-gFOvTBAMY6G@venus>
In-Reply-To: <avpN-gFOvTBAMY6G@venus>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 16 Nov 2026 13:06:08 +0530
X-Gm-Features: AclHuK_zi0cJ5esU4k_l4Yl1mv76j_qYKuptpaeB4AEIgcR7sleibDfPZTNW_HY
Message-ID: <CANAwSgT_k35_waHL-+iU93f=k3fjFAPXhk=exRz-XHMm2MqREA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Yixun Lan <dlan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Mon, 16 Nov 2026 at 11:33, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Tue, Nov 10, 2026 at 11:44:27AM +0530, Anand Moon wrote:
> > The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> > to access the PMIC. However, these handlers run in an atomic notifier
> > context (specifically within an rcu_read_lock() critical section), while
> > the I2C-backed regmap uses a sleepable mutex.
> >
> > This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> > context switch in the RCU read-side critical section during shutdown on the
> > Banana Pi BPI-F3:
> >
> > [  563.803475] WARNING: suspicious RCU usage
> > [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> > [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in RCU read-side critical section!
> > ...
> > [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> > [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0x230/0x29e
> > [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: atomic_notifier_call_chain+0x4a/0x1c2
> >
> > Replace the regmap operations with atomic I2C transfers to avoid sleeping
> > in an atomic context. Preserve unrelated register bits through
> > read-modify-write operations and check for atomic I2C support before
> > registering the handlers.
> >
> > Obtain the I2C client from the parent device and verify that the adapter
> > supports atomic transfers before registering the handlers.
> >
> > Tested on the Banana Pi BPI-F3 (SpacemiT K1).
> >
> > Assisted-by: LLM
> > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Fixes: 28124cc0fb8c ("driver: reset: spacemit-p1: add driver for poweroff/reboot")
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
>
> regmap runs i2c_transfer itself and thus also uses the atomic I2C
> transfers. The problem here is regmap itself. But instead of moving
> away from regmap, the atomic use case should be supported properly
> in regmap.
>

On  RISC-V platform, poweroff and reboot are already handled by OpenSBI
through the SBI System Reset (SRST) extension. Linux delegates these
operations to firmware using SBI_SRST_RESET_TYPE_SHUTDOWN for poweroff
and SBI_SRST_RESET_TYPE_COLD_REBOOT or SBI_SRST_RESET_TYPE_WARM_REBOOT
for reboot, depending on the supported reset type.

Therefore, there is no need for an additional Linux PMIC poweroff/reboot handler
on this platform, as it duplicates functionality already provided by firmware.

While supporting atomic operations in regmap may be useful more generally,
it is not necessary to address this platform's shutdown and reboot requirements.

I tested this on the SpacemiT K1 Banana Pi BPI-F3 after removing this PMIC
poweroff/reboot driver.

OpenSBI commit which handles this extension

d9637d00bf47 ("lib: utils/reset: add SpacemiT P1 PMIC support")
b10e18ec854a ("lib: utils/i2c: add minimal SpacemiT I2C driver")

Similarly, on the StarFive VisionFive 2, poweroff is handled by
OpenSBI through the
AXP15060 PMIC, so there is no need to register an additional poweroff
handler using
devm_register_power_off_handler().

OpenSBI commit which handles this extension

568ea49490d9 ("platform: starfive: add PMIC power ops in JH7110
visionfive2 board")

-----8<----------8<----------8<------
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 50df66de24e06..069259f7d7c15 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1458,8 +1458,14 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
                return ret;
        }

-       if (axp20x->variant != AXP288_ID)
-               devm_register_power_off_handler(axp20x->dev,
axp20x_power_off, axp20x);
+       /*
+        * The VisionFive 2 handles AXP15060 poweroff through OpenSBI.
+        * Avoid accessing the I2C PMIC from the atomic poweroff path.
+        */
+       if (axp20x->variant != AXP288_ID && !(axp20x->variant == AXP15060_ID &&
+                               of_machine_is_compatible("starfive,jh7110")))
+               devm_register_power_off_handler(axp20x->dev,
+                               axp20x_power_off, axp20x);

        dev_info(axp20x->dev, "AXP20X driver loaded\n");

Please let me know if this works on your board?
>
> -- Sebastian

Thanks
-Anand
