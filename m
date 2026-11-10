Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329610;
	b=xsun5FF4u6Y1x2FgZLE6uzMNVX7DvAA6LWh1f0WnjprXh99uKBKmrA52m/Ptfle1677b
	 B4JysDU8UkMytK8s3HOHiuHt3LOks3PX3Jq07BmRx3nal1QYw3ryg7heiiNYg9VSjNwuo
	 NVP/wytuCCyQFaFHIKHlwUV6gcGdRKbNTXF2Kas8UyqWKwKMxHoVq1oUQ1MSc4UA3Z7Th
	 PZjmqBg4KtaypHvxbeyrbKtLB+irxzxkH05//rItLg5+OICu6+7DoXXqybALuzpBepfng
	 oVrAicRQJeTp57PiAhfvlsXK3CsWUdOSzmTgIFSjItLA+c7iy1l0cb20Sds6s9TiyUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329610;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=BMGhFUUKqtsymOFM3FSL8CI+cNPAOk5onkllibeQyp8=;
	b=AfjLYPAZsq4blcS25Q0in7UaCfMuV3IuNSI/Ja9wk7yyUmzngf2EdpVxvI4WB38VacDQ
	 QoSIuVM5+IkTCuRM2oOEpWGtBn+8cUok51iD+kbwSEwwXiJT4PEUbC7mBxy0S96JInze5
	 tuAeG9UX6yj1js5SvwIAv2wy4s0zkjcU3ZOsre7Gn6vEX92JA9kAAF/PQ9u5V4cS+u8+o
	 X4U97SCZ6QARDtIWuVjVOLtW8d6MYrKaZ6pm/nwR1x9hUgHjej58xqiDGv3g+FPPEY6vS
	 1WjCe4z3mxhGU8HthM9GhFdzsPMC0h0VsCmQJyKCFD/97h0tJFdPzMTzcXyj36R1+qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=irADzqM6;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B160A2635
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 16:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E3B160A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=irADzqM6
DKIM2-Signature:  i=1; m=1; t=1794329607;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:lnjeOx1Fb0nbm725iEV7vI6EynHC
   f15wnEVP/OJxtRFCOyxMEJAbJWNC7kPDPbliK4fdAX9PPniXbclhIYj+A2OFPLYitUrUsgLODB5
   qWp/+aNgQbshcWrThgSI0R0ggF30ttqRPjk/pLc+wA+pQcLTM7/BG3whiUd3nzYJA5fPZYC3BHU
   Ivc3M3MvelxlXhEtWsNy1zEc+T8O/6r7XrE6IR40acremEVzYQGdKn71hzDtCBeIElPGZEcXN1c
   K6yRR7RDgiJvpo3uLzwNSpAvZlyZJDGSt82vFISEPv/rVvP9dm/oQ6Ul3w73Ex48VtMngtkUYxV
   AaUiJsfVOjjRDg==;
Message-Instance:  m=1;
 h=sha256:
   F1ds7OpEXO1iEeGHOmlKu8QCL+iPw2WqtnS8VcPtSPQ=:
   XMdYS9ULReZWwxX3gfjbK01FzDDms6CvelYIHL7foiw=,
  sha512:
   COb+NZCHbNjManu5JnoQ9hSz7qgeKjZ2HvhKmz5Bz93HXdN6w+G03bt4ImTC6Sd/NJpmwATCAnqa7fVrALI/0g==:
   Z7erAL4cRx6ZGJbzlcYWZqkFMtbfbwGAmjVomcYrBdoK7XS/zPwS1ErVsD5PF9ljM5SHkON/5g/BEQ2mOEKZjQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329604; x=1794934404; i=w_armin@gmx.de;
	bh=BMGhFUUKqtsymOFM3FSL8CI+cNPAOk5onkllibeQyp8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=irADzqM6P4FSeklvng2rFQIFd+ePR/K2jg+lYjGNZOvowFxz+j5cOaH8xv4jnfdK
	 JNs/6JsYEIQF5jQtYqI48W0M2P2zv5JHIX390pxZ+hRE9wVCJ7Da++vbN7lCKmXFD
	 0vA6DQYGFykHpdTlRg5K0lJ/+dRM6zlHIUiNYjv8fNQsJvQcmRwNybkJI6Kswsz2L
	 nez9tjp66GOUD7bXS+XWxhkU5AQncsWFRITIaF/uSEKr5hvM6Lxl5kAtNY/AHv56K
	 XXHFH4y6dSYd4GDOaRBr6o8ccrJGLFXs8AJzXCpq1DNuf0VeGl9XNMtwJg4RpOTWT
	 3R8LodsoJij8507ztQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1wTFTG3QEr-00rKPJ; Tue, 10
 Nov 2026 17:53:23 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bifangknt@qq.com,
	nicokessler@icloud.com,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH v2 0/9] platform/x86: uniwill-laptop: Complete battery support
Date: Tue, 10 Nov 2026 17:50:01 +0100
Message-ID: <20261110165318.631010-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8acHIAMNTWy8/A58Kpw2ifyEWM1rWhuIZzg160dkK8vY1NTkf5U
 JO4dS/Pqy8UYGOxAI7F8XrKLhxyMGBHKVzUKgH+GFygKCujokc+jeOlhXuqZf5rVWnIPQl/
 kKPAp/xd63kkiWhOgImCXnD8Er9txWb0irk2pdZbnDSb8kUHlHDJYW81MP5wbmaCtAbanNA
 FvNOFriMAh71iucGYdgvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:muNvuozvy2s=;1GrAYp1189ffGwUuRIzJ/xGxY3V
 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
 Kd+Q/ZuNbc6WAJgmvz+3jVF3lfQ==

According to the work item for upstreaming the out-of-tree
tuxedo-drivers package, the mainline uniwill-laptop driver still does
not allow userspace to read the cycle count and raw capacity of the
battery, preventing Tuxedo Computers from switching over to the
mainline driver (among other things).

This patch series aims to add the missing battery-related bits. The
first two patches extend the power supply subsystem, while the third
patch uses the new API to expose the battery cycle count on devices
where this not already being done by the ACPI firmware itself. The
fourth patch also exposes the raw battery capacity using a custom
sysfs attribute below the battery power supply device. The fifth
patch only does some generic sysfs-related cleanup, while the last
three patches add support for new devices based on user reports.

All patches have been tested on a TUXEDO InfinityBook Pro 14 Gen10 AMD
and appear to work without issues.

Link: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drive=
rs/-/work_items/253

Changes since v2:
- fix error handling inside patch 5

Armin Wolf (9):
  power: supply: core: Add power_supply_has_property_direct()
  power: supply: Enable struct power_supply_ext to be construct
    dynamically
  platform/x86: uniwill-laptop: Report battery cycle count
  platform/x86: uniwill-laptop: Expose battery health and cycle count on
    all devices
  platform/x86: uniwill-laptop: Expose raw battery capacity to userspace
  platform/x86: uniwill-laptop: Mark sysfs attributes as const
  platform/x86: uniwill-laptop: Add support for MECHREVO Yilong15Pro
  platform/x86: uniwill-laptop: Add MECHREVO JIAOLONG Series-X6xR55xK
  platform/x86: uniwill-laptop: Add support for XMG EVO 14 (E25)

 .../ABI/testing/sysfs-driver-uniwill-laptop   |  11 +
 drivers/platform/x86/uniwill/uniwill-acpi.c   | 269 ++++++++++++------
 drivers/power/supply/power_supply_core.c      |  26 +-
 include/linux/power_supply.h                  |   3 +-
 4 files changed, 220 insertions(+), 89 deletions(-)

=2D-=20
2.56.0

