Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69F4DE73E
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473236; cv=none; b=lvRzfqfOu6GgewBejjnT7GKmuIval5DofF5ig8qx40ia2XF3tfgJPrZa0qe5AJfCIr9DKVmJY4WXMCdgFIQpuIihXDlVqWiTHod+3vesEXEUxa60NLxBStIYcahjmMQXl0av6wkYfHyGPw34EaS8MoM3n12AphN4Tl3Ahb4FUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473236; c=relaxed/simple;
	bh=HL1rjdghcJEZ+/+WqreDNVzxfGI/uhNxhr0qiYRzFhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vosug6TWe5LVe0NYfnzuLgHxxkG2Tjxu8fnk71vBSrqtV/V6R5VPHqdB3VDtOM2uAH3d7WANooA264iCLTzZWPi00Al0gh9TVu5r0ooIWY231MndD76DsUM04+guiR8MoaqoDc4DecbKCP1mU2M+jhLhy2YvOO4+OtFl7YPbi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrcCBiYP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrcCBiYP"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a87e23860cso8543501fa.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473227; x=1792078027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+tlpOQ0VMeCZZG1q8nFaiwSRzS471ciSAg2AQjcR0QI=;
        b=TrcCBiYPnUQEe2yw/XW3ck6ldJrY5zFUgbvvUz1pfltjli+k+7U/Gu0zkdvpo4lsJ5
         ytnOZNJnvkfDIquBcGAMRf9pAPPT89YshNLWuyQkeX0yKR6JSxUCmXIf9bGWPdpx7Rvn
         5wNrIREOrR6P+6uxsL3072DIb0ni//Qz5sukW5SOIDPIIwDOU7ZkGh4CDIfkhQdP1ycD
         vB/XyiDRcGkyrVzWW+U+3cBebd5+DRWIGn0nK1/OuOaWDCrPKQbjP/wQnAMrnAR9k5NH
         GY/wI8EMpdHTIUQQPO8YeHiKB6oZEQuwfNbIzcU/fNc4M8E+okha1RzvQAf7IU5KXc15
         1wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473227; x=1792078027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tlpOQ0VMeCZZG1q8nFaiwSRzS471ciSAg2AQjcR0QI=;
        b=g8QzeuM7eny+2y2ugw1qZ8iI7IxQ/L5omWXBJpZcG846c5j5uxLZS8T/px2P4YHZf2
         yaV5p8XSDB0XC+8N1VvT6rZNadBn198aL4l+2MP5QesXbp6EIPG00kmQijSFnuv+p75+
         DPbByxrorh9T3RnQIoU7lBqMNOGyP9ldcIlmTRGDVwkx4V8yY++bdhFgyF+5lATwf2P1
         CF2g8X5RPIZLbiUGfkzUSVwk3IfWo0NlnhG1CXcg3ETAepSYhQ2rb9OrfzwfJT5mOoPb
         pL40MAQ6zwzt31kZvYaPywKKSgczZ80HGoco1Y2QhxdGh25I3e84ZpiND1kD1c4fb44Q
         mf0w==
X-Forwarded-Encrypted: i=1; AKwUvBzI1R+tGEQdBiLhU3GjAQ2MTiGDx0fWxVqi1aauvp3vvYYrWNcFhQUC/IhlH0Af8W1zGcDqlOipSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLWub2Dig2xgZ9+Qq45dvVTXJ2V/pqpPHRr9wsLnX6v6zPRPopz
	jCkM8izBNSNCCmcSK2XjegyFo5iMPVGxm8ZCSwV3Sp61GRk3wbDeoET7
X-Gm-Gg: AYBFou11KYQ3RSZDmLG4/rsrDCKaS9soEE+CXz1NPcwzZ4hD83LH2TZqkYJPGMhQvfE
	rZP8PpFYkIhDSkfcJzjgMXwzx1qQTPcdWfPnmnFDy/6EfAXoyEB7/0jUHmP00VoPlgnZ3lbEEQn
	6l8nZSLuGbwvF6MqYpLOOmGA7puZwT/VHZYTVyTy6FcaziAbNAxtkqpTSVPeuXqhALfgvQKC1HQ
	6jHLD3Nqz8YZbY0prSH0BwKAXkvTwGRPXYLw9MObWneqXNyazM/aFYRWhi63mW5fHalUcZmfGeN
	S2cwwDrD8fiam1thWBC98DSCYJDUABFeVipQm2WcIcvOxO4fjQKMh9S/M1qCU1UldyYSmvPh6CT
	cLVNlLw5SAUJqtyXhADtPDA5wydg1AjVTqRdr7FaSa6Ycxo1MC9xM3xAEJxRZCYZpIV1g+kDdDI
	5A9Lri78QINw+sJPhANazepaiS0mQI6/lbAHaDg/JwtTzvYeRDMpRqbB7M47oxpxRjr9bz9diy+
	dYS05c+XW5OZKyOhYhDP/0NmjltXs93/i2hwh8hkv9YSDdEwMC+RJycol4NUDNcnYPD
X-Received: by 2002:a2e:a907:0:b0:3a7:812b:d13 with SMTP id 38308e7fff4ca-3a9ae381c9cmr5375821fa.0.1791473226456;
        Thu, 08 Oct 2026 08:27:06 -0700 (PDT)
Received: from wildarch.lan ([109.72.228.33])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c12b57a5sm397941fa.0.2026.10.08.08.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:27:05 -0700 (PDT)
From: Anton Karasev <uselessfire@gmail.com>
To: qby140326@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sre@kernel.org,
	W_Armin@gmx.de,
	chris@miget.com,
	matias.civadda2342001@gmail.com,
	kento@kekto.ru,
	ilya.gladyshev@linux.dev,
	ericted8810@gmail.com,
	btx342@gmail.com,
	wleizc7319@gmail.com,
	wolf109909@outlook.com,
	vlku.milos.fun@gmail.com,
	i@rsplwe.com,
	bozhenpeng93@gmail.com,
	martiya.ar@gmail.com,
	aleksejirlik@gmail.com,
	zsanya322@gmail.com,
	nika@nikableh.moe,
	atomicus.xyz@gmail.com,
	1836949523@qq.com,
	jaojame6@gmail.com
Subject: bitland-mifs-wmi: battery charge limit (command 0x10) on Xiaomi models
Date: Thu,  8 Oct 2026 18:27:04 +0300
Message-ID: <20261008-xiaomi-charge-limit-0x10-uselessfire@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

(Sebastian, linux-pm: Cc'd for the charge_types choice below.)

On the Redmi Book Pro 16 2024 (DMI XIAOMI / TM2309, BIOS
RMAMT6B0P0B0B), command 0x10 (WMI_FN_RGB_KB_MODE in the driver) is the
battery interface of WMAA, and its subcommand 2 is the firmware's 80 %
charge limit, which is why writing "fixed" to kb_mode turns the limit
off [1]. Milos found the same handling in the tables of the TM2307 [2].
So please do not write to command 0x10 on Xiaomi machines for now,
kb_mode included; I have sent a patch that hides kb_mode where the
firmware does not answer its GET [3]. I would like to support the limit
in the driver, but the command seems to differ between Xiaomi models,
so the first step is to find out what other firmware does with it.

On this BIOS WMAA handles command 0x10 as follows ("Case (0x1000)";
subcommand in payload bytes 0-1, value in bytes 2-5; full acpidump in
[4]):

  GET 0x10/1   EC register SOH1, presumably battery health (96 here)
  GET 0x10/2   charge limit: 1 = on, 0 = off (bit 0 of EC LONL)
  GET 0x10/3   1 if EC register ADPW < 0x8C (ADPW reads 140 with the
               stock 140 W charger, 100 with a 100 W one, 0 on battery)
  SET 0x10/2   value 1 sets bit 0 of LONL, any other value clears it

Other subcommands are not handled (the reply is all zeros, return code
included), and nothing else in the ACPI tables touches LONL. As with
command 0x08, the SET reply carries only the return code, so with
23cc56f6dea6 ("platform/x86: bitland-mifs-wmi: Detect failed function
calls") in for-next a SET also needs Chris's GET-only change [5].

With AC connected, setting the bit makes the EC change register AFBC
from 100 to 80; nothing in the ACPI tables writes AFBC, so through the
firmware the limit is fixed at 80 %. Charging stopped at 80 % ("Not
charging"), switching the bit at 80 % toggled charging within about a
second, and turning it on at 81 % stopped charging without
discharging. The setting survived charger replugs, s2idle and about 17
hours on AC, but not the battery running flat: after it had run empty
in s2idle and the machine was started again on AC, the bit was clear
and the battery charged to 100 %, with nothing in Linux writing to it.
Whether the EC lost it with power or earlier, at a critically low
charge, I cannot tell. I have not tested a plain reboot, a power-off or
hibernation.

Because the limit is fixed, the power supply ABI as updated in the
power-supply tree (b3e6d01c33eb, "Documentation: sysfs-class-power:
Update Long_Life description") calls for charge_types "Standard" /
"Long Life" rather than charge_control_end_threshold: an ACPI battery
hook with a power supply extension, as in acer-wmi-battery. Since
command 0x10 is the RGB keyboard mode on the machines the driver was
written for, this needs a per-model flag, so I would base it on the
generalized profile handling Chris is preparing (see Ilpo's reply [6]),
together with the TM2309 entry. One detail for it: the EC notifies BAT0
itself (_Q0B) 0.6-1 s after the write, but an immediate
power_supply_changed() fills the one-second _BST cache, so that
notification reports the old status and the driver has to notify again
a couple of seconds later.

Other models: according to the notes of XiControl [7] (a Windows tool;
in Russian, not verified by me), the Xiaomi Book Pro 14 (TM2424) takes
a level code in 0x10/2, for limits from 40 % to 80 %;
xiaomi_pc_manager_lite [8] maps code 4 to 90 % instead, and the TM2424
WMAA as described in micontrol [9] (which takes these for brightness
levels) writes 0x50, 0x5A, 0x46 ... 0x28 (80, 90, 70 ... 40) to EC
offset 0xA7 for codes 1 and 4-8. CoreCharge [10], which writes the EC
directly, toggles the limit with bit 0 at EC offset 0xA4 (LONL here) on
the Redmibook Pro 14 2025 and the Xiaomi Book Pro 14 2026 and writes
the percentage to 0xA7 as well; on TM2309 that byte is unused by ACPI
and read 0 with the limit on and off. As any value other than 1 turns
the limit off on TM2309, level codes cannot be written blindly, and a
model with real levels would rather use charge_control_end_threshold.
XiControl also found that the Redmi Book Pro 15 2022 Ryzen (TM2113)
does not implement 0x10 at all (writes to 0x10/2 left the reply
unchanged), so support has to be known per model.

Chris, Kento, Yuming: if the SSDT of your Xiaomi Book Pro 14 is at
hand, does its WMAA "Case (0x1000)" agree with these notes, and in
particular, does code 4 write 0x50 or 0x5A to 0xA7? Ilya: which
board_name does your Redmi Book Pro 15 2022 have, and does its WMAA
handle 0x1000 at all? Aleksey (Pro 16 2025), Matias (TM2107), Ibragim
(TM2209), Eason (TM2426): does your WMAA handle 0x1000? From
anyone else, the part of WMAA that handles 0x10, or just the model and
BIOS version, would help, and so would the limits Xiaomi's Windows
software offers. Please send full acpidumps off-list (several MB).

[1] https://lore.kernel.org/all/20260930015058.3076905-1-uselessfire@gmail.com/
[2] https://lore.kernel.org/all/CAObHBTwnv+kEaFdCp+cr31HtdSo3CaRq84T8vr-Pm75yZMTHqQ@mail.gmail.com/
[3] https://lore.kernel.org/all/20261008-bitland-kb-mode-v1-uselessfire@gmail.com/
[4] https://bugzilla.kernel.org/attachment.cgi?id=310971
[5] https://lore.kernel.org/all/20260928154337.154969-1-chris@miget.com/
[6] https://lore.kernel.org/all/094577b3-7b96-72b6-4ef2-a5d1db457401@linux.intel.com/
[7] https://github.com/Oksion/XiControl/blob/main/docs/01-wmi-protocol.md
[8] https://github.com/CHHHHHHEN/xiaomi_pc_manager_lite
[9] https://github.com/arcane-D7/micontrol/blob/main/docs/HARDWARE_INVESTIGATION.md
[10] https://github.com/alex-bogatiuk/Xiaomi-CoreCharge

Thanks,
Anton Karasev
