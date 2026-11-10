Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269987;
	b=Us8yCJxhNS43/RiyIP8X+C6cw8Gcz7gcweonLyepUbHDacTXhHqgUZCI3cFvTjfP5QRO
	 0zrwvzBukxjxnsz3pWr7faWa0q/NVMOVKk6GCxXT8SXcITC4YpAdVeS5pKg7UWeSY2yPG
	 XrAxpryIua6JCEG9pF/e6NVB5jhcXyW1KQ7sjCae/rUbSRueBjjpYTED/tbMv1kFI3/5K
	 3/QyNeDIoMcLgu/AFSaeWvs8XYVrkYsv536gvLF+Bn0mF2WY4b7Fju2ENcHn5wYs4tz31
	 +EbPplE2uy72qKzt6vhUtbLGnIZAYSRo6/CiyutJ8Lh5FR4lPh1Z07MmN+luDWYYNGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269987;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=gkkb4gpKR4Vgz9MiobMARFB9Q1suK/+U8IcbiYiCYSM=;
	b=bk+Gc0f+fz723XZo07CFo1q0TvUs+Z4/ftJ7rXp2j+uNie6JLc4YRyETwvysaN1AEI9Y
	 nwv8+72chOuRbbPzg9rBkELCbWrorY24Xr8BQedJbI1B6uGIsxKegSyLedjTQvtdB6l5N
	 OlUFx24ed08aXsYhWtMSO3PAy2V2M048kILp+TFHd42UPixwSnv2s1PTwW8AGftbwtNkA
	 gLMH/EfV3pTzerlYqdIXSLBgHCK7wT9Mn+UuJQjePgLBdnzfR+W8+HGwCYy4GnKMxaIoG
	 npngYQ6K4qiU06HNfBUjWB4bRSh2iwR1JMEEOqcny3juMW4rUOt8F+sQ1yQzFBtuYCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="FwOBSAO/";
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F8606A325;
	Tue, 10 Nov 2026 00:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 365F8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FwOBSAO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269980; x=1794874780; i=w_armin@gmx.de;
	bh=gkkb4gpKR4Vgz9MiobMARFB9Q1suK/+U8IcbiYiCYSM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FwOBSAO/MzUNs++0162EyC5kwU2uQFfocdFUf1Bcg6rsmd2hUA6rVnfkDFR146dH
	 UXXg5Qb1IsiHtQBRT43mNFbRTa3RI5REXNyeh1Ny0qO/vZfOsCaV14/zSIWwPHrzC
	 PmvDj8XqVdqKDGRmuwITuJU8SrzgqsNoA3IwRzBbKqd5RhbToFPnH2Ut+tVHB01Dl
	 qzVr6QxZQdbQqt+rfR+EBqRyxkx77eK7SnsqNxrOxCAxjOeVYJHMg644cB+BhTEy9
	 ApISVeLUf5YcAuFObRSH51HKcEe2RAvYsofItgRh7o9QWxOrnSNBIWETGanYOl2mV
	 cWrCfaMpwAwonVyGkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1wZ39a3sXV-010BWR; Tue, 10
 Nov 2026 01:19:40 +0100
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
Subject: [PATCH 0/9] platform/x86: uniwill-laptop: Complete battery support
Date: Tue, 10 Nov 2026 01:06:42 +0100
Message-ID: <20261110001725.851443-1-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:0RSdqTA6UXxmTWGNuqnM3wg6wjbXpqZDtzHWodjhp7gRm+4CE6M
 I+MScbSRGxWNJxehU+uUjiqlaEzMl2T46LbbbGCd5+s05j/Zm2yulzKpiCxm5MtrcyTdmB4
 wp8SSWGHuzkRb6ePZLs4Gu3nv0b/r2K0TnpOnMRf6mxmxdTTn/zwYzQggVWrddnvOsZ3LoD
 wIGypjD2FmFfXp0D2oZrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fzMNHJu/xUs=;MCTK5Ci3FRhzUtFKbVMFadYS/l5
 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

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
sysfs attribute below the battery power supply device.
The last three patches add support for new devices based on user
reports.

All patches have been tested on a TUXEDO InfinityBook Pro 14 Gen10 AMD
and appear to work without issues.

Link: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drive=
rs/-/work_items/253

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
 drivers/platform/x86/uniwill/uniwill-acpi.c   | 265 ++++++++++++------
 drivers/power/supply/power_supply_core.c      |  26 +-
 include/linux/power_supply.h                  |   3 +-
 4 files changed, 218 insertions(+), 87 deletions(-)

=2D-=20
2.56.0

