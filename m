Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430593;
	b=DCQGCV6Xz+4w3MTvX05fSfx7MbHNwj4CnZqkA9LjvBbxdsgkSZyLiOGiFOaM9UuCEljr
	 bohhr4G7UKBEZGIlJzEaGyX5VpU2HxW3C+rRTdzE10HHxdDEsJsqiz12rvsjOcT2/knbE
	 6IGMV6SDG13Ze7keT2uoJPew3yz5q8fzO3KAoO6lzjS8VrT9ZRRRgb/CPXozeHBK8Cm2G
	 DxzRGxGxDpS3onr7TXim9Q0OrVRYgBnKK+zSsfShynzvJ2nzs9POjrP5bK+CMlENBpafR
	 w3eZdGWHBssKTeH7OddsEinKpmJLU6nG891GShy5ItEJeJ0okvTW4GdrN5ijwPpbgZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T17Fr+e+17o1j7Dkt/Qb3JOQLQzRIyBH08kPjcz8Hbo=;
	b=Z+Dh3pe1hA968XswXthzB+eaVLkhAmvDZvBimZXKsRPos7P8A2CnD/pBgEht4/HG/RPi
	 mXN7YpvQFZi45UUIY/exaSwLagjdWY2ijBZhGAGk/e2ZtFaN5W/VbeSs/ot9PE7TFlTrX
	 +EjvhQuLUhUqLMx/jDJnF2+wCjky6TOC6ThgbvpiPLSLq8yiAp5BVVrQqRyWMAWvBI/rU
	 1rgwVoVhX0jAlU5F5Jiefr7G299j4uPimP171V42Cy8dekRGeXMmmwZ4EemREF5KWi5Em
	 0AVfy0ib6bNUCC6FIkEIm1cseWie3PnhsBQLHdxSMQR/9c1PNQ+FNF1OymGiRKLKceA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgB2K2vy;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF4606A32E
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EF4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgB2K2vy
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-486f013db83so1274383fac.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794430591; x=1795035391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T17Fr+e+17o1j7Dkt/Qb3JOQLQzRIyBH08kPjcz8Hbo=;
        b=zgB2K2vyWYaSIbpunRQtHxamS2nSRPs2BCY1DE+b/7Y7masYfZGyPjTxu2rjoMnrQU
         y1GrRysRprhznQQwVoNpaYwbNX7JYYqhb4Qqdi5DWVSB4iCyXNIUNC4HBiuzaGPRuXcQ
         qCF3GAttzoU4Ocx2BFOeReV8cGMKMwDjRQYZshVuEi9MAOYcUqjnD3kdHYy52XeMfi7i
         gOD6xTXfaNyPvcHZIEi+xdbPiG6rbh0XFQujiJwz18gsZ39qQuLMOsxks3uGmqewqBFY
         cQyDmUVJE1zIsOuIGBNJyx7ZCk6HR23Yi+RinITX6J1VSny9vxzAPmSv8wYwbPKkvspC
         A8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430592; x=1795035392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T17Fr+e+17o1j7Dkt/Qb3JOQLQzRIyBH08kPjcz8Hbo=;
        b=JRUoWr1f8RI8Xe/JIDSOoFc8W877qa0dfljegIFoxCT2gdOEVDLmOcEHf0mxG5g6eb
         yJV2b7g8r/a69mLbI7Se1aWEdRNYQOYlN1aeVCEAZbZgnanDHic4QBiVzzN51+cBCMfU
         pMAHWmdn8A+GJ3J1EKPEQiU6YXmXPV0XQrwR9Y/odScWn7ZaaDK0FIduOLY3IBy338Zk
         Oau/mw8ejrjlW3Sq8U7jmOkXlUw2vDFprfY/kD/ZDJZ8N+Z11JsTN2+PWelefYPziLaY
         wgIXoGTM7Gu8Hi6P1wiipbDy/murkuBzayCYdHa/x+lN3djdW2qoOkS+6mukcbFJ9YHG
         +90Q==
X-Forwarded-Encrypted: i=1; AL+hErEt3rvDQHL0s+HvsGNhY8Q1dp8jJ8xhL/ZimiL9atJ/SyoEoT/YrYGhy32MvbF2TW+QaABsQdQUNg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/BkM2dD7YRrSJrLd+LzjzTAvyjXGd824U72/NEPEFVGrTHcOEM
	hW8WF+u0yq/uLsmsJKP+H7iiYwU+60tA8qzOzC73OaPzknLl717Rq+qy
X-Gm-Gg: AYBFou05KG426MMQXCG7ZeLw8narsXW3qeZMfWmJb2fv9boInyQQMZXitBb1bZ7J+We
	/v7LR2Lm3Ndtxke8HOXRxz4jyIFW5MAPNLgVyBDwJ3WQCnruZz9joLnxRZQOMJcpPqw7Vx1huUa
	dxR7oosUlHzcBBX1MWl6JEHR54JK57cZqlL/0LAVP4eHBWwkVNZEQzbF6kbsQb+VAQGL7Uei4iZ
	j7o0MBP+WQj1DKmh/Xsf+PTTBg1Yl2Yn2xJY7WQmH/jmh8oiUmTyo6PcKwCuThp9GrkQRZH9rxF
	6NCXejIW5zBGHOxvzpi51grEEGyvXgRXryg9NKl/NWBDou6IrX8//M71p0gTL0Y0YkJPSG1LR6a
	gqiK7nf2nWkleUBw+SwGb7UrhdYppIxFY5MugnjKbmvwD9TdTm26SdWmsoLWokW7Gwa07mXgnQD
	Mq4WI+Cfd0C946LMZMr0VidG+G1K+m4a3uOOCYBj+kI28st6zu/3CgdiNzAHe5xD8YutcJ0qd31
	JBvgwoLsWvTHSaCLm4TJwOTJCWw3VZ+sr68sw2WSFJbqDO963mO/D8JyHTgwla9tcAMfTo6Jtjj
	1DjOKPWU+vGxzvW22w4uPL19pQ7LrMpW8XRkfinZvmIwyRHUWbUD
X-Received: by 2002:a05:6808:4f06:b0:4e4:627a:e094 with SMTP id 5614622812f47-56b96194399mr3306216b6e.11.1794430591483;
        Wed, 11 Nov 2026 12:56:31 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm6564231b6e.11.2026.11.11.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:56:30 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 0/7] Fix Incorrect State of Charge for RK817
Date: Wed, 11 Nov 2026 14:56:20 -0600
Message-ID: <20261111205627.56652-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Chris Morgan <macromorgan@hotmail.com>

Users of the popular firmware RockNIX had identified a few bugs with
accurately displaying the correct state of charge for RK817 battery
devices. With the help of one user analyzing the code with Claude
they were able to identify a few potential bugs along with potential
solutions which I was then able to verify. These bugs are as follows:

1) Incorrectly clamping a value with a max of 10000 instead of 100000.
This bug caused the state of charge to sometimes read as 10% instead
of 100% as it should have.

2) Using the boot_voltage value to calibrate the battery in scenarios
where it could not be trusted. The boot_voltage register populates
immediately at power-on, and the driver would check if this value
was older than 30 minutes before using it. Unfortunately when combined
with the default behavior of the bootloader to turn the device off
when plugged in (requiring a user to explicitly power the device on)
the boot_voltage and boot_timer values were wrong. The boot voltage
would not account for any voltage added while the device was off,
and the boot_counter that tracks the time the device was off would
be reset. To fix this we changed the behavior to (outside of first-boot
scenarios) use a value saved to NVRAM, the value from the coulomb
counter directly, and an OCV lookup from the live battery voltage,
and then using those values provide an initial "guess" of the state
of charge and recalibrate with the OCV voltage once it is available.

Included in this series is another fix that would cause the battery
to drain while the system was shut down. This patch replicates the
Rockchip BSP driver to clear a shutdown register. Unlike the BSP there
is no behavior to bypass this since no boards have yet been observed
using the SYS_CAN_SD bypass on the BSP kernel.

Lastly, it has come to my attention that I misspelled "coulomb"
throughout the driver, I have included a patch to fix that.

Changes Since V3:
 - A few bugs pointed out by Sashiko bot were fixed.
 - Corrected spelling of coulomb in new function for resetting counter,
   after Sashiko pointed out I made the same mistake I just fixed in a
   prior series. Also corrected variable name to the right units.
 - Updated rk817_bat_voltage_uv() function to check for
   regmap_bulk_read success. If it fails, we return the error and then
   check later for voltage values less than 0 and treat them
   appropriately.
 - Change logic so an SoC of 0 is handled correctly when looking up
   values from the OCV table while selecting the boot SoC.

Changes Since V2:
 - Added a patch to correct the spelling of "coulomb".
 - Split off creating a new coulomb counter function into another
   patch.
 - Split off exposing the boot voltage and OCV values into another
   patch.
 - The code should be identical for series v3 as it was for series v2,
   all that changed was the spelling of coulomb and splitting one patch
   into 3. I'm keeping the ack from v2 since the code has not changed.

Changes Since V1:
 - Dropped the sleep fixes, as I would like to test them a bit more
   extensively first.
 - Dropped the devicetree parameter, as since no boards have *yet*
   needed to alter the default behavior there's no need for it.
 - Changed the behavior of how we select the initial SOC and made
   it its own function to ease in code readibility. This new method
   was tested with various boot scenarios. The average error was less
   than 5%, and in a worst case scenario where the device was
   discharged to 0%, then left to charge at the bootloader the device
   over-reported its state of charge by about 10%. When this occurred
   the device reported its SOC as 100% but that it was charging, which
   was corrected by the new OCV logic that kicked in once charging
   completed.
 - Scrapped the more complicated sleep fix in favor of simply telling
   the battery to recalibrate at full after suspend, in case of a
   counting anomaly.

Chris Morgan (7):
  power: supply: rk817-charger: correct spelling of coulomb
  power: supply: rk817-charger: Fix NVRAM SoC value
  power: supply: rk817-charger: simplify re-initializing coulomb counter
  power: supply: rk817-charger: Resolve boot state of charge from
    coulomb counter
  power: supply: rk817-charger: Expose boot voltage and OCV values
  power: supply: rk817-charger: Clear SYS_CAN_SD reg by default
  power: supply: rk817-charger: Clear full charge cal on resume

 drivers/power/supply/rk817_charger.c | 350 ++++++++++++++++++++-------
 include/linux/mfd/rk808.h            |   3 +
 2 files changed, 268 insertions(+), 85 deletions(-)

-- 
2.53.0

