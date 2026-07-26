Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95382EEE84
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785033211; cv=none; b=JKoiMLTksrG0Yz1aAOCcWuuPily1phXsyIvM4ODS8otZ2pDzoJy3uQ2OFbv4mGORjyMm2GCXYoIxiSGeVs9k/uAYnHpKR1KKGxuwuZFdmdxqFk3JabKKeXqIQ1yvS3eL9qZeX/tyXoVgTfalKopIOCfeRAtfW7EeaEfUbXCwO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785033211; c=relaxed/simple;
	bh=Z8o+7L5AcN0mc5L4ZBXWEkwZ88tRim+Z49ttFoGnBwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsZ8K2dtbdArGFzDQyFWx0+D4wDbikZfE6THdVRhNhF0I0QKxjVOeaMdY8Ty1UEpKGCtJYuByGeElp5npZj65WaauOb22jX41ubjkB0vsm9YVdVL8R8Ts6cvYURZQH6/kgop6uJPFknkgRKx20b6Jiz+0flTMvyC+RzgWeKtHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf0116UP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf0116UP"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1211760a12.3
        for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 19:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785033209; x=1785638009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjXzoSujIP+9dDYXqm3Aab2DrXJeEn6UY/TChtANBQI=;
        b=Pf0116UPcFARZ5UI+z00eqkzao7AiZ4Fi5S8Zh50yL13JqalyzfoxqBU2PaJdzWnqO
         J5c4hq9CPKJuFeuanxV2/MK3ijJ/3SCckcyCtdyWTvzeoHz4J45ONp27jXuMIv4T1Yv2
         7xdNLC5r0dvXpKhsegaKrU3DF1oQvS2naECqY4QiLDvag2Ed50AIPnfe6aBZFU1ldrlN
         hA6e58iqZnwyxoUn7Anx9Mh/sDCXivUUv0P/JoRltBsz34+XwvcMx8oQi1gVIYB7h15T
         JTen9AsTO0FCWmfpoWyvAyDn8my8kZJuhoNgp7kLCrO1FDggo9ZSutwDB3o22zrDD4KP
         iDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785033209; x=1785638009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjXzoSujIP+9dDYXqm3Aab2DrXJeEn6UY/TChtANBQI=;
        b=oTLSsPJbqZVNyvM4RLSLKbUcMPi6cgUuEglgdkglbarTr5GMhpabtPdWAzzIWSQCc/
         6pVsEyDvxb+1daZjFQct8vKlgdT3HyLpoGnSzZVfcepDoASpYWplK4Vercukq8j6bEQB
         o4/P0rOPbJA9kEUEx3+gDX8/NJXpLIMowkDL6pVBMGbPMFlpmgoKEyLy2eMOuMRn1qjb
         WYjNBdR5j5yNCTz+Tnsz14MB585mK48P31/YIfYBNCEwd4TBXICCHZXv/WoxZw6cGs3Q
         l9lxrN9RjHnc6g+XXAB4uyK0h9gxOzaKIgclph4ksieWB1uNq/sXRZ99ek2M0zrT7fkZ
         P0IA==
X-Forwarded-Encrypted: i=1; AHgh+RpDYggESyBJL7v3cjMm5MMu0jJOoTSBLtO3abdZZWKf+zgwU9xhCRZDEUxeDLWMjSvRSBaEml0GvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbH8GY9HzqRxCRXMu11kj4sDix74xmAJ794r9Ve13GVvxfBth
	AcsITgCaHArH0DStqHKfyh1swmrVbjr6q4jAMrs0H4SIPkQLWK0gEogj
X-Gm-Gg: AR+sD10MqEsr1dqS/6rQoEYTmGhDcKevYKBsFV6zwHTyfQGQTqBEaVAz8K0Wh8brYga
	4O8BJk6/luA+Cjg8BPO9LyCYZyEkCSwKIXycC9/DN82v17Po0v06ylkday/tDESarOa9TG0NX9Z
	sGKFjUA1rCdCSXrJYRDO+tgPc6FJMGX9tRbMsE4W30S2EbqT13Os6Ff4pVpqWCsaFXqCD6nm3CD
	QxoBgTMsZSWRlHx00n/fjv3JbagrcZbAbXFmA/rCaq7oK+ylx17nao+h1EKa59QKMY0ByW0WLhM
	SH6jTKZ9AAfz+SsR3N11/WjvYmPUhqs2L9+ZQemY8JdsnlvFx1wCSJHKY/kKq/f4G36j2uCz6O4
	FIPPAD3HkuYsZUZXG8Dj+UqsqUq/zod2UqwZjV32nQ2TQH+H0eyrdRzRzonFfLANb6/kEGpBoor
	ftLy3nalJ6vqiD6A8mTh5oqOp0uJu54PNrCASRGrp8ihBGAUngfpyPAiXZnQPAemrufabhvlJXB
	rvqBocHsbocj8R0tjO8AfJTO8uh/Dlzw9HYDJ5ke2g+RXMmHA==
X-Received: by 2002:a05:6a21:a09:b0:3c0:9c19:6586 with SMTP id adf61e73a8af0-3c67e159021mr3525765637.64.1785033208757;
        Sat, 25 Jul 2026 19:33:28 -0700 (PDT)
Received: from localhost ([50.38.60.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b282asm1722846a12.18.2026.07.25.19.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 19:33:28 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	igor.korotin@linux.dev,
	gary@garyguo.net,
	tamird@kernel.org,
	aliceryhl@google.com,
	boqun@kernel.org
Subject: Re: [RFC PATCH 0/3] rust: power_supply class abstraction and SMB347 charger driver
Date: Sat, 25 Jul 2026 19:33:27 -0700
Message-ID: <20260726023327.51519-1-brucer42@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <amQPYhBkj9rIdSZ_@venus>
References: <amQPYhBkj9rIdSZ_@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Resent as plain text -- my first attempt was rejected by the vger
lists for containing HTML, so it reached only the people Cc'd
directly. Apologies to those of you getting this twice; please reply
to this copy, as the first one never made it to the archives.]

On Sat, Jul 25, 2026 at 01:41:35 +0000, Sebastian Reichel wrote:
> Having Rust bindings for new drivers sounds good to me.

Thanks -- good to hear. That was the part I most wanted confirmed
before putting more time into it.

One status note first: patch 1/3 (the SMBus helpers) is dropped. Igor
Korotin pointed out that I2cClient is meant to implement
kernel::io::Io rather than grow standalone SMBus methods, and there is
an in-flight series from Muchamad Coirul Anwar doing exactly that [1].
The SMB347 driver will consume those accessors once they land.
Patches 2/3 and 3/3 are unaffected -- more on that at the end.

> Any reason for Summit SMB347 specifically? I would prefer not to
> have two drivers for the same hardware.

I wrote the C one. drivers/power/supply/smb347-charger.c came in via
commit ed1a230f96eb ("Add I2C driver for Summit Microelectronics
SMB347 Battery Charger.") in v3.4, back in 2012, and the file header
still carries my name. So this is me porting my own driver rather than
a drive-by rewrite of someone else's -- which I think also speaks to:

> All are ARM32 based, so Rust is at least available by all users.
> So I suppose replacing this C driver would be an option, OTOH I
> don't want to motivate people to rewrite things either :)

Agreed on both counts, and I don't want two drivers either.
Replacement is the goal. But I should be straight that the RFC is
nowhere near it yet: the C driver is ~1640 lines, the Rust one is 180,
with three properties, no IRQ, no set_property, no OTG/regulator
support and no DT charge-parameter configuration.

Two things I can do in the meantime:

 - Make the two mutually exclusive in Kconfig so that no configuration
   ever builds both. For v2 I was planning the ax88796b arrangement --
   the Rust option as a bool modifier on CHARGER_SMB347 with the
   Makefile selecting the object -- rather than a second tristate.

 - Build-test ARM32. So far I have only built and run this on x86_64
   against i2c-stub; I don't have any of the three boards.

What would you want to see before the C driver could actually go away
-- parity against a specific feature list, a hardware test from one of
the espresso10 / nexus7 / p4note users, a deprecation cycle? I can aim
at whatever the bar is, but I can't self-certify a swap on hardware I
don't have.

> A new driver supporting CHARGE_TYPE should also support CHARGE_TYPES.

Happy to add it. One question on how it should map here.

Reading the ABI and the in-tree users, charge_types is read-write: the
supported set comes from the desc->charge_types bitmask, the active
one from get_property, and writing selects an algorithm. On the SMB347
the charge type isn't selectable -- the progression from trickle/
pre-charge through fast to taper is autonomous hardware state that the
driver only reports out of STAT_C. That is why the C driver has never
had a set_property or property_is_writeable at all.

So: would you want CHARGE_TYPES exposed read-only here, with a
Trickle|Fast|N/A bitmask and the active value from STAT_C? Or do you
consider a read-only CHARGE_TYPE to be exactly the mis-modelling that
CHARGE_TYPES is meant to replace? I'll follow whichever you prefer.

Either way it lands on the abstraction rather than just the driver:
desc->charge_types is a descriptor field, not a property callback, so
the Rust Driver trait needs a way to express it, and the writable case
needs set_property and property_is_writeable plumbed through. Those
were on the cover letter's future-work list; this moves them up.

> If the idea is to just have a user for the Rust binding and
> something to test/play around: Maybe convert test_power instead? It
> would also decouple the power-supply Rust bindings from I2C/SMBus.

The decoupling is already there, as it happens. Patch 2/3 touches only
MAINTAINERS, rust/kernel/lib.rs, rust/bindings/bindings_helper.h and
the new rust/kernel/power_supply.rs -- no I2C dependency at all. It is
only the driver in 3/3 that consumes both. And with 1/3 dropped, the
SMBus layer leaves this series entirely.

> The disadvantage is, that this driver is a special-case, since it
> has no parent device :)

That is the part that gives me pause about it as the *first* consumer.
The open question I flagged in the cover letter -- how the get_property
trampoline recovers the driver's private data -- is specifically about
the parent-device path, and it is what reviewers have pushed on most.
A consumer with no parent device wouldn't exercise it at all, so I'd
risk shaping the abstraction around the special case.

For v2 I'm moving the private data into power_supply_config::drv_data
at registration time instead of recovering it from parent drvdata,
which removes the ordering dependency Alice and I discussed [2] -- and
that is also what a parentless supply would need. test_power becomes
straightforward once that's in. I'd be glad to do it as a second
consumer on top; I'd just rather it not be the only one.

[1] https://lore.kernel.org/all/20260707151542.91997-1-muchamadcoirulanwar@gmail.com/
[2] https://lore.kernel.org/all/ak9kAP1SZF8AchQT@google.com/

Bruce
