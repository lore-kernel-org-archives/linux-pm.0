Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630388;
	b=p5aCDhOtP5UDt76KRi4Rc+CyInvdeRwJWD1O/uZJUh4nJryBLKkuaYKhpdTuzY6w+Vww
	 zxgPbgL0uVpDd/QBNeie3/oPN/56G7tB5adkDIra5eUIidFm0kAMM2pbgNN1Re0iewRIH
	 KUgBUM2x8ucuu04ai1gdsr6s7RwJ1/9m3NoUbB561e0JYF5BZCgKHhouTBwf/zPmAMPx4
	 X8OvqtAMZ6RxlIf6QnrlxkogIB7lTTkV63lT/1CfdKjpfe4d76Fy/06QuL28bcJSfwCx5
	 8DGOFI6juoIxQqjl5HWgyKzRHkFRc/nDgiDoQZqOyshJxDUd5RaCcvgKbTcxOdXS9iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=myOSo9t6ieAaewgOL5tC6c8vmygWMsLZlyhCa3JKgpY=;
	b=bf4fPi9J6Q61pYsQbT/sASlUH5NxX47gKOAZ0Kotra35VPTN4ywS46j8OVSCKsFACFO0
	 FLyZyO1udgk4ARybWQkgvZVg2ruKgcyJ6DwOIOOCGXZKvbFAssvBAn7RuFB1iqykp5B5R
	 x8EUESgnLFJZgd1XUCpBp2iNYZS0kGNbzm6m1uoEri5YQ3fq+stFxCxn542fzSL3Dj7X/
	 06G0FXQl8tu91QDTEGjLyvTeuHKCLCQPks3smEM4AkAFQmK9mkBU22fbiCnIHFInfxfTn
	 /ZdA/t5KiZ8J5+VpuwE61jGYBN37I7k4eTJifJNIqoOpeG3Fd9iTLxf1/Pnuld1VOnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aM5hCan2;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54374606A58B
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 14:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54374606A58B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aM5hCan2
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-83bbcfba0ffso2336904a34.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 06:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630387; x=1794235187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=myOSo9t6ieAaewgOL5tC6c8vmygWMsLZlyhCa3JKgpY=;
        b=aM5hCan2hQgkfevC0BidFbll3kdgLfn6xWmr5GoupBtyBghPWw4FA18+YLUvHT3Wjp
         YAVYDhrF4feszz5JFZaJuTCTLMEGGkHIkLggV+2UCFqFwvOPvQCA4Obtjk9pL+q+KPzC
         nGSVVTdXgVpjvrWClhodKHQXkk8uKpdfkxvYmK5AwyQrRSxl3A675Mb30he00SHETx3F
         ZBs6zQstC7sraMFkKvrpRfPSzCJ54GLLqalSKyr1jsGNvCoGgEOYtr/tdpjnFY7F46M4
         15Iy94JHA+bZebYjhNPt6ES2AJ3YSFjWdPlXkId0ivZCyi4cMk82eGw/s+p7fExz5o0g
         Gtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630387; x=1794235187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myOSo9t6ieAaewgOL5tC6c8vmygWMsLZlyhCa3JKgpY=;
        b=vy5BF1MZ3tdwdRWP2dxH2AcUy3niIMt9OHOzTrvNE2ZvfxPmnC5WP/bdgxVnfTxcv/
         gRKDOu11gN+fJVUZmDiLewtEZwLxfvut+r7xhwBPwSYo2v1Rs8PulA3FkefwhwMdNZJS
         V1Br2GJi30hFVADIdfXwymzf/fqIzHDh3DP9Yhcj8Jh9VMvxWVaDYoMlSuhZ178HVJOX
         Ejf9X+04VtstybIjIM/PixK24evq9eHQ2waFoiMPmI5csiFsyhr3kqicJdiZbW5lcLfz
         F2nEwMtREmf0Dd9xWdJg0gNxAhLvlny1Nog8XTZ6veDYbUF55hxDpvkQQtend8w7LEmo
         rpEg==
X-Gm-Message-State: AFq9FYJkiMgBEW+dQCgroayG73TWrEsmyd7AxbphfjmA6/fYnPmH1ZVe
	xeDwB6r8OSwMfIc/m8+3R1jNMXnDE+3U0OeIRKKQqZItbIwJanpMVRBn
X-Gm-Gg: AYBFou3z8dFrYTvdLNzFHzu+1ZzdqB9xTfDxetPKR/CSwIzP1RUFIe6ADRmXtivXp5p
	8kSwlwfOeSOr+vYjwF7vaggWA4Miv1EtIxWmlHHObNYBpbLvVo1tueRm+7zsCh6yFwUxt65tFTN
	eDgprihL9ZXL0IHTKQdQ+yHUhbkw4wKd8U4bHDJt3+vtSoIOR0WEmcTA76oVyJ5ofE7j8JJ77SJ
	1S2q3jXZGVLjtADiVH/N6aUfeu44o9PAUx3mn9s5r0fwfFtGQzvoe7lwUb3agPCFJSXovU8WBBn
	9DMdp1jpNFUkprwI+F1rFSwAm9V9UzNR7y+Qgu4OpL/PvHNbJaaMfTY0/EFyQYNXRKV7Ze1BLtU
	bUXNgjO+SnQWsmn6O8c4Y5RgYEZlqGv5Oqyg3R98zY3K7iHtiE06qd7KwuBjUWIWISVesXCv39x
	uFkSV1CZZHOg43p4+werqZvtNkdAl4Qcp8KRVH7bZoQMQJj4a/aZguZlkcLbuiUbWtFxM6yt0CU
	vLQF41DWzaYlF8L1yDrz8jFCTHKCp5Xw1DL+GCs7U/VGm0RGTVi9bg/ssrkthn2XBkvp++jKLtm
	lvItDtmxcWkQuFwqWAZDZ5kLPoir5rLAAsn9oudsc1QW7jY8f/w=
X-Received: by 2002:a05:6830:25d1:b0:80c:d30f:97b with SMTP id 46e09a7af769-85d36633c0fmr7911631a34.28.1793630387011;
        Mon, 02 Nov 2026 06:39:47 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b875sm9516327a34.5.2026.11.02.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:39:46 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 0/4] Fix Incorrect State of Charge for RK817
Date: Mon,  2 Nov 2026 08:39:38 -0600
Message-ID: <20261102143942.305293-1-macroalpha82@gmail.com>
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

Chris Morgan (4):
  power: supply: rk817-charger: Fix NVRAM SoC Value
  power: supply: rk817-charger: Resolve boot state of charge from the
    coulomb counter
  power: supply: rk817-charger: Clear SYS_CAN_SD register by default
  power: supply: rk817-charger: Clear full charge cal on resume

 drivers/power/supply/rk817_charger.c | 313 ++++++++++++++++++++-------
 include/linux/mfd/rk808.h            |   3 +
 2 files changed, 239 insertions(+), 77 deletions(-)

-- 
2.53.0

