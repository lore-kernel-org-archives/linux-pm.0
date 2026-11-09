Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236320;
	b=ml69M+dymiGIJdJ1AbSyttEzdWa2vSgQPfozWpc5/LcHr47v6E5A11BA2+rH3uz54100
	 m77FbfMKZUBN90wseCulFEoRVGre/H92vj8XKrnURoETq2woFcaqw7of8sUqecuMx9E0z
	 hDgP8iJdQbDYSIIrQMWXuf8E+WXOMxBI514pwu3R5Fd3CLE45XGpVUuF2JuWi9kaept/z
	 RMoeOEsbNbqiXHS2oGTgWjIpHCVu4IzUdTIOt3I8V1j0mAv3P/ju3S+0BOF/zOe1jPTa/
	 Db4fCJVtd2wHa6l7jgVouT0J+5T7PFN7H2eO6LK4r7LHEXNOK7kgA8yW2TXEGqeFy5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=seKl/U/n6NYOsgLq7EY8yxXTtms+ghjcRgX+g6eIMn4=;
	b=DeI5mGmZ1onga3mtck+UXu42TdUEVWyxUn7X0njjYz5CfRZnUsd+OVjLHt0DJUt1hAMA
	 AtbsROtuUtqCDC3nTaGJ2neZDh03GJCC0xtHXzcpa+NGC31yOBOmPALSReBDke5asbGWr
	 Pa3hdJpRrHEVOEQVYKsjsxauRjHYBqPTrQpctEtsMKNEJrtPbz4ds0n2yBdCQKpIrrZ6K
	 whxj34+MRPfWwI9blJPsYrZ/+JgffC9gvU5WqVruhxirnCwQVwoen3VacM9S+Q2BbJczS
	 890QxyhyHTFfU9bqbGOfQbKjM5SFlQU7Di8sY8DBTXN1zHOqWxrqrq+yMVqzvgiyftw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=atzlewJZ;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A37606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=atzlewJZ
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a85c656c58so656351fac.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236319; x=1794841119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=seKl/U/n6NYOsgLq7EY8yxXTtms+ghjcRgX+g6eIMn4=;
        b=atzlewJZMkWNjPDK37+fNNApgfXGcOi83qiZapiWAwYFzBt943MHDrlqvXI2+E8S3Q
         TJwk9qT3XgP1dDv4Hm4r9E3rT22MfHANiowVdrI7p//cd5FlpaStGdRQqZ9Qd5rNUb0t
         Us0k7kwrzWk/I0cCdrRIIictzfe/ooZz8EvRDgfFdHARq6j7eN+pK/yeoByBty6/SMpg
         fRZ3ztOUrHlqgmD+FJt56Vv1H9+FJDIxQgVk4XQeHcx7szGbE5pgdUFapSpfMNeb4wZE
         xa4D6NmknPJQRKwgClYejFpsraIQK3Une1kV7VkF2P55vweXx/ZdN728k0bTa9guoRK6
         2FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236319; x=1794841119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seKl/U/n6NYOsgLq7EY8yxXTtms+ghjcRgX+g6eIMn4=;
        b=KmqxknZUhPHoFEqAjs7coP3XAlSJzig4G5XyadOkC/TIk9YLi5Pczml9f66nMDKumh
         a9SOWXtMM/kqDg1iuU4N1R0Sd5/dzAnaqKxWADGfCcRaMhKcQ/Xp+zGabxvX2H4WL/nL
         36SXUGmxFy8JrHG3KOmlraWbIS8PX/7OfeDMyWd7OKrKA4yidPiu0mv5UUzdWntUG76F
         /OZVrs2L+soN7DouLaOXlfGrh64p1hwQIlsP7G09KkPo7OAOpIya5yB7R7YKZO8LgAUS
         pSvOnR5lAyr1NEA5N7YOg98az5jcBJsVaG6InTwC5WbAX/WyIL+E2ns4TC4WLhDFQjWZ
         6rTw==
X-Forwarded-Encrypted: i=1; AL+hErFz4EGSkA54b+Gp2MefBStSDqXeDEHJtnXZeK4pEZnw+gJ0rOwxA+YvXC6tphSQrEzWRtlCnbGVuw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WlIJFgDI75l6VmaSsVBl/x85hWaXvqDafh/2YKRE1LAoPgRDw
	P8OyfijaigoUA/QSPZonPsB44oh24+zDs8NsiRgtwU4/ScVpf5clRMLMpgiCLRBj
X-Gm-Gg: AYBFou3kPsvr+AgSgRj5BQAVUynzTGq3q0rRpMGaRYOV0IL7DAXPsNw25pwHdivNZgn
	UZUgseLMg+no1hfeDeOipuaZ6EeifegqCS0xtfHKrJcdcwXCRbN9ZAEh3hrarV9JlJ61Vj1nzwg
	hMAnlUXR78fPz/fnLYQji5dCXJ0TNjiEm2ZdeAIgSB7/xHufa9gA+8sA1Skt5BRLeQGFLAUic5v
	0yti+ErrXye7WazoXpHY9a7T/stTLoBKXADgKNF7y2jJTfegfyKhKT17rZvSUVte6fEywQ3EuWH
	ixSn5/XT8gTlkJiz2WBOD9E6tqvHYHs+0hgQu9QaT5kpfT0fvrwi+uMiixAiwun7uDawpF4vv5B
	xJKL2ZQZcF6pUCyGoitNepUw4gcRnR5iF7VbQrzcY3Cw0EBRjg2tKGaFxOfEL8Aj4jhMGTEket5
	/3K0b69TzVT4M3ofKvJoymIFJTtOQXcxpfQDXcqvtPzteRF4kikv/FX0yjMqSeLC0P2jTuAIAAB
	4oECWyHHjmM8nKKmKhLyjJFU6EVnLdpJh5Fthon9k7jlMEIr8WhS8rAigZVNgZk0qy31kPHejLQ
	MVZok9/3RV/RlDIgC07BT4MdgAsGig==
X-Received: by 2002:a05:6808:690b:b0:53c:7298:3598 with SMTP id 5614622812f47-568145b6024mr3083943b6e.31.1794236318918;
        Mon, 09 Nov 2026 06:58:38 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm4667618b6e.16.2026.11.09.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:58:38 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 0/7] Fix Incorrect State of Charge for RK817
Date: Mon,  9 Nov 2026 08:58:26 -0600
Message-ID: <20261109145833.1363319-1-macroalpha82@gmail.com>
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

 drivers/power/supply/rk817_charger.c | 329 ++++++++++++++++++++-------
 include/linux/mfd/rk808.h            |   3 +
 2 files changed, 247 insertions(+), 85 deletions(-)

-- 
2.53.0

