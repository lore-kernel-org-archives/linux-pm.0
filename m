Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264153;
	b=JaKzGt6FEsjFRP54s0BUCgMrJvZ9ng6ki3haejXi8cMv7a8PDDxfU1ElnBg251kHGa6R
	 MnYhTQaW2jZXa7oeP/W5G3dqoiu9hcmCklS1TJWlb4iGTgdeO3PH9ob/NoHKXyk/tWE8D
	 /YFLuY8jA4t+RsY9EBBlYNr9QijVBD0SU2DLQwF5uLdhNBFhuNeAhcR/XCMTYg8KMFTuD
	 udVv9m3M/y67+25BjXO+aFdYG9u8D6YRPmpe0FVzIxoZkKRfKa26GBIKza1sVedZxD85E
	 QzxJDBm+Yu8VPLgF6cc76V8yJaG0FH9Gs4Y2YTIdp1CcDTx+1s/wf3a1HaoUKO4AN9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YYDnw0w3VJ1m8RLFL/nZJuly2Onkx72MVUQSXk8vs44=;
	b=3myWi6utMX1yOBHsK3lf4EmO1L6eh/Pr4e1flcSz4dXT1OHFrnPygLMg5e0+SQSFv10T
	 V20QZBp7lE3tVjx0+spqOfJUCMK3/f2i2e81QSNX7f8Q4J2EedbDCtzbmAi2EkYWq+eXL
	 vc1BtygLhZuZb1oCr697y1gCqO1tZYGX5xtQ2KnIQj0hnKfq48mup4uIF9zHjnKqqn6ZP
	 Q9PAtaqr/Mx+JI+A6GcIknXXRg191D59rBcGYJ+OxCTqOoMLtXFqvysNKuv57Aj7BQYSL
	 nA1aJ5ky1YsFbGBqB1abAfHh4ne5mey+J/qm/dAbthPcCjKWjIYpqchVQxj6YNFoF/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLptjGD4;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180C606A323
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 08:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F180C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLptjGD4
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-369f33df08eso3510999eec.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264152; x=1793868952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYDnw0w3VJ1m8RLFL/nZJuly2Onkx72MVUQSXk8vs44=;
        b=DLptjGD46znSG6byzVrIUXtEd0wYp2ocot16hHp52y7rmlSFqfhMJlc6i2rtkGMNBC
         Lgp16RnFrXpaOvusnzJqL0Eh7tb8mrb+2S6ryqC4/zFcjcyLv9hWVwYn3Ct8znpb1mAY
         so8I8+u8h95CImV2pByyPmF8cmpo1oCNQNz8QowMRx103M7m3wqfPNJaNdCOnyzam9aC
         s0Ew2+a8RHtNJQMbBZr3Fuyn6iie3/gbNdgGgCe1hA1aD+U7IEXr99AgA0mAo/8Z543B
         gQLUedJ85qZ4m2DMMLVn/f/dF2yt6LCZfyLT6jtXnVAoOe+nA0P/YgtA+MtL7Neibt5k
         lprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264152; x=1793868952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYDnw0w3VJ1m8RLFL/nZJuly2Onkx72MVUQSXk8vs44=;
        b=1tuTypI3Oq3eNqTOarM4bD6RIukaeR3ibiIrfFOQwWTnp5yjHmNzKSkoJbmIA7wR+1
         3u2YjAaGBZvbg8ZW1Fz29A1ngh6OilofnCAriHVIh1J6wf5g4TGknj/YZiwgDKq1CN00
         3yh72ufFbkSWgeF0o3wx0C/JC6umVJPyYHCIQhWelIVMZ0brcQ4ae829Xzu1EgbTshgn
         J39jD+nYhmwBO8a6didl1PeggK+Mwz0tJOD78Oy5ajAnPzpR9uBJaEJ65Sj/0IaboxUa
         abR1FtS0B+zK4sDKS1qXBU0u1q5hKfIpYT4C7KsNUnViJkShk+bm1+ReL9hWsxgSfKLO
         KZuw==
X-Forwarded-Encrypted: i=1; AKwUvBzmznf0sND3ioQjMUQiGHYwVyxroaerZeypgVhXqMrenSVp1N7GY+tT8y9ZYiN4m5KNay49nKpVvg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIav09d+2jESJS0DUZ/jFAW1dw9M4G/IfGkU9NYZ1RVABXTeCrC
	TuAP1cSCrRUWD02Ktt8Cb87dGssfjjxda37sj5c0aMXVRbzyemW0rqc=
X-Gm-Gg: AYBFou2ygpEpQc4odn9wxVB4KSuSM20QrRDF1trAw29rsA0/ekSSv8lxiHkrEgsIy3o
	7ZlsWLSUk8ECG1lQcsM3C5inAt5rRHti+ubhm9LovQnmtC5250sPjC6sN8Ks95FBCHSY8hWhxNj
	eJtmdXHpUzDJYziVNRgaCPyy/1z7YJME1LzQ8HTyLuKwLZQemsYhpPrwZauvUNzliStTUp19IJX
	u9PO6t9dsJ7/r4x5SnL10NJVVwIiTN9lPJQDfkGaoSzIrVG+nnZ/1Sx1suY5+pLZ87ku5E2RS9D
	apa60hPbTj0rkj9U9Sg46aOT+KKRIUwRPKmT6nuoCcW/LwGJAFYtXdyl/QItvMghFJeIJIkOnFt
	N0AjQ6hgCIIyFAVczJqNysWX06poqaIGYturW9X/ql/EOiwaSwIstxDT3ZOEWrNDtdmkm3HKw3L
	Ct921P/C+WPCDfC3K+t3jw2acVBN548qoqTSXu29SZRjtJzm3hJz1E55WdCaKYTYpE3UGyIbP/K
	3lNCjmOAcnFoJhZQ9zGiTPJo0oYWSEsWU33tVqoo6o/nI1I8TL9UyHIM3pHwIPBv5lBr6M5ye+x
	tEyKEHuul/SCP4biLq3ziCSanx/U8FCe/Bkz+3NlibFq9+Gl60oBs/J4l0RmRCsY9nTEknjVj5Q
	5IcRJ5Xk=
X-Received: by 2002:a05:7301:7c12:b0:35c:ba31:6fef with SMTP id 5a478bee46e88-36a2016c61dmr10086277eec.36.1793264151721;
        Thu, 29 Oct 2026 01:55:51 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:55:51 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Thu, 29 Oct 2026 04:51:57 -0400
Message-ID: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

applesmc is very old, and all of its code is lumped into one
driver. Fan control, sensors, the light sensor, the motion
sensor and the keyboard backlight in a single file
with its own way of talking to the SMC. It is hard to extend
and to support new machines.

This series adds Intel Mac support to the macsmc drivers that
were written for Apple Silicon (the Asahi implementation).
The SMC works the same way on both platforms, so we share a
lot of code with Asahi. Only the way of talking to the SMC
differs.

To make that work, patch 1 splits the macsmc driver into a
common core and a backend. The existing RTKit code moves into
its own backend. Patch 2 adds an ACPI backend for Intel Macs
with I/O port, MMIO and interrupt support. After that, each
function gets its own small driver using the standard kernel
interfaces (hwmon, IIO, LEDs, power supply, RTC, watchdog),
instead of one large driver doing everything.

On Intel Macs these drivers replace applesmc (hwmon, light
sensor, motion sensor and keyboard backlight) and acpi-sbs
(battery and adapter). They are mutually exclusive with the
drivers they replace, so only one is used at a time.

This is an RFC to get early feedback on the design. The macsmc
split and the Intel Mac backend touch fundamental parts, so I
would rather change them now if maintainers ask. After that I
will test the series on more macsand send it upstream as a
proper series.

The series is organised as follows:

  1      Split macsmc into a core and backends
  2      ACPI backend for Intel Macs
  3-6    New drivers: watchdog, IIO light and accelerometer,
         keyboard backlight LED
  7-9    RTC support for T2 Macs, a T2 detection flag, and
         disabling the broken ACPI RTCs
  10-11  Power supply support, replacing acpi-sbs
  12-13  hwmon support for Intel Macs
  14     ioctl for userspace access to SMC keys


Tested-on: MacBookPro16,1 , iMac20,1 , MacBookAir4,2 , MacBookPro12,1 ,
MacBookPro15,1

NOTE: Almost all drivers have been tested except the motion sensor
driver as i was not able to find any device that had one.

Atharva Tiwari (14):
  treewide: Add backend for macsmc
  platform/x86: add backend for macsmc in intel macs
  watchdog: add driver for apple smc
  iio/light: add new driver for macsmc
  iio/accel: add driver for apple SMS
  leds: add support for macsmc kbl
  rtc: add support for x86 macs in macsmc-rtc
  treewide: Add a flag to detect the Apple T2 chip
  treewide: disable other rtc's in t2 macs
  power/supply: add support for x86 macs in macsmc-power
  acpi: disable battery and adapter for x86 apple machines
  hwmon/macsmc: add more types
  hwmon: add support for x86 macs in macsmc-hwmon
  mfd/macsmc: add ioctl to access smc keys

 MAINTAINERS                                   |    2 +-
 arch/x86/kernel/quirks.c                      |   37 +
 drivers/acpi/acpi_tad.c                       |    4 +
 drivers/acpi/sbs.c                            |   17 +-
 drivers/acpi/x86/utils.c                      |    4 +
 drivers/gpio/Kconfig                          |    2 +-
 drivers/gpio/gpio-macsmc.c                    |   13 +-
 drivers/hwmon/Kconfig                         |    7 +-
 drivers/hwmon/macsmc-hwmon.c                  | 1126 ++++++++++++++++-
 drivers/iio/accel/Kconfig                     |   10 +
 drivers/iio/accel/Makefile                    |    1 +
 drivers/iio/accel/macsmc-accel.c              |  248 ++++
 drivers/iio/light/Kconfig                     |   11 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/macsmc-light.c              |  189 +++
 drivers/leds/Kconfig                          |   11 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-macsmc.c                    |   69 +
 drivers/mfd/Kconfig                           |   15 +-
 drivers/mfd/Makefile                          |    2 +-
 drivers/mfd/macsmc-core.c                     |  362 ++++++
 drivers/platform/x86/Kconfig                  |   10 +
 drivers/platform/x86/Makefile                 |    1 +
 drivers/platform/x86/macsmc-acpi.c            |  642 ++++++++++
 drivers/power/reset/Kconfig                   |    2 +-
 drivers/power/supply/Kconfig                  |    2 +-
 drivers/power/supply/macsmc-power.c           |  751 ++++++++---
 drivers/rtc/Kconfig                           |    2 +-
 drivers/rtc/rtc-cmos.c                        |    4 +
 drivers/rtc/rtc-macsmc.c                      |  126 +-
 drivers/soc/apple/Kconfig                     |   14 +
 drivers/soc/apple/Makefile                    |    2 +
 .../macsmc.c => soc/apple/macsmc-rtkit.c}     |  185 ++-
 drivers/watchdog/Kconfig                      |   11 +
 drivers/watchdog/Makefile                     |    2 +-
 drivers/watchdog/macsmc_wdt.c                 |  140 ++
 include/linux/mfd/macsmc.h                    |  104 +-
 include/linux/platform_data/x86/apple.h       |    5 +
 .../platform_certs/keyring_handler.h          |    8 -
 security/integrity/platform_certs/load_uefi.c |   38 +-
 40 files changed, 3786 insertions(+), 395 deletions(-)
 create mode 100644 drivers/iio/accel/macsmc-accel.c
 create mode 100644 drivers/iio/light/macsmc-light.c
 create mode 100644 drivers/leds/leds-macsmc.c
 create mode 100644 drivers/mfd/macsmc-core.c
 create mode 100644 drivers/platform/x86/macsmc-acpi.c
 rename drivers/{mfd/macsmc.c => soc/apple/macsmc-rtkit.c} (70%)
 create mode 100644 drivers/watchdog/macsmc_wdt.c

-- 
2.55.0

