Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036919;
	b=uS4ljT6Gpn8xUkz7L6EPSdMXggXVI+txtBAWzO5VdmrC6xEaJDb2fyTeIbuSW1acZo3E
	 U8KwO956QqbKUZbe8vk6kOSfoiUz0zUIaEQtZEb7hs3Z8LmBAJbX/ev6qCctCVsQtBA9D
	 VqLGXDQnviVz3E6EkJ76VzpUfP3dY/ra095BzSNgbz3bAyr2DP01TmxXgj9hk6JRfLzrC
	 7Y+wtIgGO31v+wvs4TTewrSRQiYbeyqY4JNiOY9KGCEZbCx061ylSR3PQaCWAVv8wBUfT
	 2RmCmAyvzQ62S4itn/+0IBLkiSkH5hna5IAtnYobGJxcBd+KL6bVeRuhS6HIfsNQ+zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hZ7yPLnsxhfMD/1GegWYSNSd6Og2H7HlUEBWqKkjyv0=;
	b=xct1w8adMrKPBovxh5DaYF0RQyuQywByK23GxHC9rbnT9gYSgR8QtdA13DnpyYx91qhK
	 he6yjajOzWVrQjQKPLWBUHxtew0a9Oy2MCtVWGWn2Owu+waV0ziaQKn1i7JPkgBu6uG17
	 2lCbfmVt1oEyxk+mqGXbrG71xWLzEfsRXlWLWNzEqVBCzkeQw2P40mmzGbIVNURbl+m6Z
	 Qn98AESYsUPrFS+elpHW01r8Kk43+NDxMeugjnvLrMc76CyMegAdnCsMTkwGZnzjSm41M
	 CXJmeQTZ6JxjFfM3kZllOXc3pGUF4dgfiVkeTUAazLP9SaNjdaRs0Ntr0qPk7TOt5LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=luj5OyBl;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DF606A31A
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 17:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 575DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=luj5OyBl
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b190cdc9feso1803381b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036917; x=1793641717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ7yPLnsxhfMD/1GegWYSNSd6Og2H7HlUEBWqKkjyv0=;
        b=luj5OyBlMjzI47kdwxhgM8mgrYKUhoBRUSg0hpxLNN6uQ9zCevu9POmM30b+XNOd6u
         JR/z4huFbN08fSZZhvslboiPFj4vTSup1htwNR1/1/cXm016iMFwVTBRMtE1fAyeBK8c
         iuNd5DaM75Nml1IR+ykUJtlAh7EkCBzhRr2yNdkjlDTPcoz9RLYuhPtpImB8j9dZcLL3
         o15opyBXotcESQ4kYYKqBY3d1wib0Zml8rWr1itSp/JhbEe03nmTU4AYQDRNEcvAetA+
         LCorGJ9RxcMH7WVCTQ+fRlKIjBU5ExdbHqY2MrgDsJo7XbwinyF8ahtZyDAUaZLZY477
         U4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036917; x=1793641717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ7yPLnsxhfMD/1GegWYSNSd6Og2H7HlUEBWqKkjyv0=;
        b=Ve0IhsSoqREMxmEkrw4tw/so0GS06pPAH0iz/OWNLrUy7ZauvTpWPAa0ZggTGHdLsL
         A/2uDcJhQWzl/D4F9yJPYe9z2tDCbdaqaIeixPXxgMH8IlJXz7M8dLSuyeAnRDOLHgpm
         Gids3W3wwwsxNBPoo57z+T8AWzhdIrX6i4p660AELyGEvOKkD61OIN8gyAEXbE2zVCVw
         ORURvBCG7JXZCbjFUd8v0Lcl+05PUr8PkdexFUlFyXtm5TW53vRSK41IPoveZUibQ+kR
         pawlHJIvPf+XfRPxFUueTT9mYXZbO2oi89FUdRs824zPbYH68BwNvbRRI5+X0inxHQqn
         5xgA==
X-Gm-Message-State: AFq9FYJ5RdG+MGB8H2fJTbZ8Fj5ZQ8wHm+0ZSd9oyTTThjYAB2l2Fl9l
	sa4zaJdcaUNVTsXz4AUT6b53lphuOi6EisqXK1Z1F4tQmlxXMJYN134nhvCH6GJ6
X-Gm-Gg: AYBFou01CMP+u8IDGSeuy0ebng68PIIPMqf2zU0Vu1M+apssj+74QewJN3/RYQwFCSH
	cLX5vDRR6s5o5Ethhj9JJVsZuTZMVaStDssvJDjub9rTxewaox15qu7tYMXs8fPn9ln+DoBDSnu
	zEh6EvrlPHiF1qm0GtXsORU7rd25G57yRZ9c51mGDN1xMbhGNkBBMHX/O69sG+IF8s4VOnHs4ac
	NOyIRjwEeA8tk/c5cLer0WkQA1X+YfzGeYBF0IZRjdj/QgROaAi6BgARHCHXFL5WUmUo261EjY1
	DsXofOTerJgGcOiuZXRiCAKx9B4PSSeJVyvZHa9Z92p2+ZE8ia/RgB5LIYE0XwxcZlMGlD7quPX
	iAmvWKOMv257iRdI5hOMajCcioFBpeRhqIp4HDRu7ENYfDMnuPTc8fUaG76dfyPEFyEV+um0k/W
	fKajjFt9X/otmNVNR9DlQEIP/Qi9HN0yqRnY315MHcj3SGXE6wryPTW63lUWZsjMakrps3voifo
	FMDsXwkeymcP0lARqJ1ZNZ7VJG1s4a/oe+JHVggtCTAGeJcbMl16WwgwiQvKYX/SsPd9d0fpXwh
	87qcQYUZbqwqszcYXBxV4hEZG4VpWQ==
X-Received: by 2002:a05:6808:4f2b:b0:4f6:5279:5c89 with SMTP id 5614622812f47-55c0026b905mr4577266b6e.47.1793036917104;
        Mon, 26 Oct 2026 10:48:37 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89e33sm5034753fac.1.2026.10.26.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:48:36 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	maccraft123mc@gmail.com,
	zhangqing@rock-chips.com,
	zyw@rock-chips.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/5] Fix Incorrect State of Charge for RK817
Date: Mon, 26 Oct 2026 12:48:29 -0500
Message-ID: <20261026174834.1652309-1-macroalpha82@gmail.com>
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
be reset. To fix this we adopted the same behavior as the BSP driver
which would typically (outside of first-boot scenarios) use a value
saved to NVRAM or the value from the coulomb counter directly and
then recalibrate with the OCV voltage once it was available.

3) A similar issue would happen during suspend, as values from the
coulomb counter could not be relied upon. So we add suspend specific
recalibration to the driver.

Included in this series is another fix that would cause the battery
to drain while the system was shut down. This patch replicates the
Rockchip BSP driver to set a shutdown register and provides a
device-tree parameter to override the behavior (though I am not aware
of any existing boards that need the override).

Chris Morgan (5):
  power: supply: rk817-charger: Fix NVRAM SoC Value
  power: supply: rk817-charger: Resolve boot state of charge from the
    coulomb counter
  power: supply: rk817-charger: Correct the gauge across system sleep
  dt-bindings: power: supply: rk817-charger: Add
    rockchip,gate-function-disable
  power: supply: rk817-charger: Clear SYS_CAN_SD register by default

 .../bindings/mfd/rockchip,rk817.yaml          |   7 +
 drivers/power/supply/rk817_charger.c          | 336 +++++++++++++++---
 include/linux/mfd/rk808.h                     |   3 +
 3 files changed, 290 insertions(+), 56 deletions(-)

-- 
2.53.0

