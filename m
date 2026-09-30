Received: from outbound.st.icloud.com (st-2002i-snip4-11.eps.apple.com [57.103.78.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7D3F4DE0
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807218; cv=none; b=qK9ojynJ22deQjg0aHzNUuVDX41eyBjvO7GuoQOI+O8RPXAqvKV5PYDXGBgK7q885+Qw+9YCcaUa/M6LB8gcKtREHyKoFZzkzWnQCpDVOSku0QGcgvu8Z4weTwT3GtSaamkI/O4+0TXFvnCBsApl7NnX5iz9TfvcMxY45ibi4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807218; c=relaxed/simple;
	bh=hmEdMg6wTnd34APfEfu5j/0oYZY/XEIo7DobIEh6zug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0aC7mcqSzgPxvImdoVmjv2yeW4af/fW3hmpZakUS3oszYjfFQEUdIzDlwxBeWLfOet65cMmiaw4V4jrBvAfX5yFhnsNnISlU/7tAhcJOSbhbMGMoqmbFSVQ/SUA46DTh/I1Y5G5V5yQXz8go0HE8GvZdZ8mHQXEwUJjlxeVhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brough.org; spf=pass smtp.mailfrom=brough.org; dkim=pass (2048-bit key) header.d=brough.org header.i=@brough.org header.b=CQXqvMK7; arc=none smtp.client-ip=57.103.78.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brough.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brough.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brough.org header.i=@brough.org header.b="CQXqvMK7"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id 7EE541800548;
	Wed, 30 Sep 2026 22:26:53 +0000 (UTC)
X-ICL-RepId: 01a0f46d-8573-7e4c-8e3e-9f51fa919291
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhLBUMEXRxIDlYCWwdLVxQEElwfUwpcMFsKXBhQAxwfSx8TC1NWUAJWDVQFGQRAFxkKUFAGWhIYXBRcUFgeRhJWDV0JGRhGXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVlACVg1UBRkEQBcZFVoJClcAQAtOA1QEWwBCC04GXRlaCkgKQANYGlofGlYKVwxZK1ACVg1UBRkEQBcHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brough.org; s=sig1; t=1790807215; x=1793399215; bh=Ik3YPnPwNm4KQVJBOqdf88VvdIj/yJ6gOH3tmGf/EYQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=CQXqvMK7UAh37BVDsuuZ82hJAgWSxtkeYhj/CwLbiVDfZ6Lwkp2Zet1ad4tttmYYG+Dnt9UBsH30+J5jpNwBogshKlZDHKHPQhhkfuo/CV4P0EykHOEXTXtNM8zv5hEScN/vTXvuYYctbazuU7nHweguEUZk4+Z80mQjbYMV5KM2f4Ipu6FikX29yVEU8DYeS+U1q8kk/nTO1DKWQFTIzHrnnZ/N9UcuGZTvuR11dX1eAYaLtqpdiDy5SYameA7P/YZuhpz1is4+oMkskWKqZ66kB0WBtVXNX7SPEIsa/5jUKj10DAccMbNqCBfGCXbViWy5iXqx0VsNT8AtnoOg9A==
mail-alias-created-date: 1646594351620
Received: from jb-desktop (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id C9D8E180016B;
	Wed, 30 Sep 2026 22:26:51 +0000 (UTC)
From: Jordan Brough <jordan@brough.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Jordan Brough <jordan@brough.org>,
	chrome-platform@lists.linux.dev,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 0/3] hwmon: (applesmc) add charge_control_end_threshold support
Date: Wed, 30 Sep 2026 16:26:32 -0600
Message-ID: <20260930222650.1883805-1-jordan@brough.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Np/cssdJ c=1 sm=1 tr=0 ts=6abd8cae
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gFGppuTrAAAA:8
 a=3KJn3nblrUCwOSVLmvsA:9 a=QEXdDO2ut3YA:10 a=_Y0xhhAoguY4gwfEQMhp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MSBTYWx0ZWRfX4kTtyWo45inW
 ZKuMuSqHwF0HMBtKGMuyS0k+gGO3i3p4jcBfyB+m0PS0KDuyd6oR2q3mhWJG0UAthNmXtVTC1dS
 Bxd1vx4tD1o+kYqg+3Tq3PTFbk79ysOLr2dixehCaosjBtemRQLtiAVDItKGE+KadahBrP+0hnZ
 u3hKBGrAi2ZFM0te26zh06oFafqYyBCVvLF74HBL6pXYN9oBZpIpkgUGA4CImn6irdww0JkLMlL
 tIvnJXz9UWCrjCyuGB1WzBBZ3mhGDZP9Y8pX5GyrMDjaENJIz66LKHG//LPafv76ltM1X1GC9gy
 +wrVgBllZufzmFSUVWqYkBdBfDUSwT/zsmCfTytYwdh/f3SMc4Jbj/dLabFu4s=
X-Proofpoint-GUID: Ma3gpkMd9Du3364tovKf4jTfmQzGwxXq
X-Proofpoint-ORIG-GUID: Ma3gpkMd9Du3364tovKf4jTfmQzGwxXq
X-JNJ: AAAAAAABiS5yuYAq9u12fjzs8oQBYVjKUij4JSpuJom/DzWsqS5bePJkXTwavM57wDHNibPbIcti86nuffyH/zUyXoUpgz+zUsuGkXaZ7qVrLkISF0uNzM8PyzA2Q3L3+uvqA/QPCHIRk0GBRFSchrrIbcwWq26CYFt5aru9TjPMw5cKmMN0Twr4fbLZamK7uX4yEbRSucrJ8uYCvDFI9wrAYepj+Bt0Hcjlz5XhNy/hUrm5FEV+Uq7us129niXyKvshXyov6YV056wBipxhlfxFQnSZHDkpC4ODZTOstj0BupXQOgXd6uncck8mzmjbN9/FlYGWCsLUdlRM2HDCSp8IcH2bwr6VhKRZYw7ikCBPPLsIcN2V+RvcsisvK19MTjU9t/xYB8GUB3/e4TW+tQ4NNh2oAHbngtWZM7gG/5PBHNs5YuGjYnPHF7fHFAFo8wACSLIQzWiR2VeUq21FUHk2m7x68t5/SkNjVMFLcaBdQm8QbwmyJKG2LhSHPWkWr720frM0SdrQskPUR7r1YdMwIeDLVPZOWtEYpBMEiBK52yp4Z5t+FnpLTCK3eGksiro5h66wn/0YX9HoXDhJp7gmb8fQ4vaIuSDyYErGHKIx9PBuiSW3HbcfoEOdxamJbvMffEntUzkXAzriXlTwPOhKn6JOhy3trIfjC4pnJZMfM4dSHZxfO4CCPiOcYBwyQhLFGK6GfkQM8ukQ7Q9J3p533uq1GvTsI2MF3UFtfCk2mPn1XZWN8KgeraxKcr3eETqASRMX4lDp+013vs8zykp4MNtqwTScP0I+hkUKVgCgHEo2gusmyWgvpY71Vdyr3+NGt2Fdmly65wpn0ti1ePG0rZPWrfgw6BWNYAlx4qV1+Q7yEuKw7RhjzHuIzsWs742XGupdtQJbvy3dS0Hz+OJdRi2KI7Qy3DIzSuFbGutsl88l1TAoCMt43gJhfib5Yk21tyLTSLv6lIor3WNM6YLMtwWOH3c
 vTYhrNjUJLylUp2FOXHed+0aSMeEaJ5l9eVxUkWteXxlAACX8zM1GAxL6KPfo1IAfy4dMgdxX771dsMWrlN3Cxe2yeFyX2ci5yI5BJokyQU4raz5TzTmmUORGcmBhqeCZuHKsF0/ns2fkGxeXN/DieaxN/dugqghPifjFwakdlTm22q3fdXcSCrmYnybLqXJVfb7dBrPIIM1eggfyj0CctD9uBUs/lvHOcLXiEzLC9AJtD3nWjM8zOQ0uYTy0U1kfjjFoo/H5qiULCq6JAPluat92tB+DlBS9UqZBJQ8fFad1/K8TZeQBo+VGsTrGb9cDyIzMT0LopaTiOVSutta77bR51ZuBdnfLbWxYS3oAKMAIUuYHH3eESoI9eOuQB7XdhgmNrA/c8nobnOtyw1P1MNrjK6xyPvOTrZaOELo7hzxpgIYz8cc=

This series adds charge_control_end_threshold to the applesmc driver for
Intel MacBooks, using the power_supply extension API.

Some of these machines have an SBS battery (drivers/acpi/sbs.c), which,
unlike battery.c, has no battery hook mechanism. Patch 2 moves the hook code
into a helper that both drivers use, and patch 3 adds the applesmc support.
Patch 1 is the acpi_ prefix rename of the existing hook functions that Rafael
asked for; it is separate because it touches 18 callers in other subsystems.

The series is based on linux-pm's bleeding-edge branch (4c18627a1dfb). Patch
3 depends on patch 2, so the series would need to go in through the ACPI
tree with an ack from the hwmon side, or I can resend patch 3 once patches 1
and 2 are in, whichever is easier.

Changes in v3 (thanks to Rafael for the review):
- Patch 1 is new: acpi_ prefix for the exported hook functions, with their
  callers updated.
- Patch 2:
  - Renamed battery_hook.c to battery_hooks.c, built only when ACPI_BATTERY
    or ACPI_SBS is, through a hidden ACPI_BATTERY_HOOKS symbol that both
    select.
  - Renamed the struct and the new functions as suggested, exported the new
    functions in the ACPI_BATTERY_HOOKS namespace, used mutex guards and
    updated the file header.
  - battery_hook_exit() is gone, so hooks now stay registered across a
    reload of battery.ko or sbs.ko.
- Patch 3:
  - BFCL is only written when the SMC has the key, and the BCLM write is read
    back, at the suggestion of Michal Szpakowski, whose MacBookPro13,1 has no
    BFCL.
  - No BFCL margin at a limit of 100.
  - The lower limit of 20 is conservative: 20 works and 10 is not accepted
    on the hardware I tried, but I did not find the exact floor. I am happy
    to change it.
  - Dropped the applesmc_hooked_battery tracking and the mutex in
    applesmc_bat_get_property().
  - The hook is only registered when CONFIG_ACPI_BATTERY_HOOKS is reachable.

Testing:
- MacBookAir6,2 (SBS battery), on an earlier revision: limits from 20 to 100
  match the SMC keys, charging stops at the limit, repeated module reloads
  caused no errors, and the threshold was unchanged after a suspend/resume.
- MacBookPro13,1 (SBS battery, no BFCL), by Michal Szpakowski, before the
  acpi_ rename: valid limits read back exactly, invalid ones are rejected,
  applesmc reload and an acpi-sbs unbind/rebind re-attach the attribute, and
  charging stops at the limit.
- Lenovo ideapad FLEX 4-1480 (Control Method battery, ideapad_laptop), on
  Fedora's 7.2.7 kernel with the series applied on top (a rebase of the
  patches, not this exact tree): the ideapad_laptop hook registers and its
  charge_types attribute appears on BAT1, charge_types can be read and
  written back unchanged, 25 battery unbind/bind cycles re-attach it each
  time, and unloading and reloading ideapad_laptop removes and re-adds it.
  There were no warnings in dmesg. That kernel did not have lockdep
  enabled.
- Built and linked with ACPI_BATTERY and ACPI_SBS as y/m/n and applesmc as
  y/m, and an x86 allmodconfig build of the touched files with W=1 shows no
  warnings; each patch builds on its own.
- Applies with git am on linux-pm bleeding-edge, and with git am --3way on
  hwmon-next.

Link: https://lore.kernel.org/r/20260918175052.85461-1-jordan@brough.org [v2]
Link: https://lore.kernel.org/r/20260913231410.416922-1-jordan@brough.org [v1]


Jordan Brough (3):
  ACPI: battery: add acpi_ prefix to the battery hook API
  ACPI: battery: add unified battery hook mechanism for ACPI and SBS
    batteries
  hwmon: (applesmc) add charge_control_end_threshold support

 drivers/acpi/Kconfig                         |   5 +
 drivers/acpi/Makefile                        |   1 +
 drivers/acpi/battery.c                       | 166 +------------------
 drivers/acpi/battery_hooks.c                 | 159 ++++++++++++++++++
 drivers/acpi/sbs.c                           |   8 +-
 drivers/hwmon/Kconfig                        |   1 +
 drivers/hwmon/applesmc.c                     | 146 ++++++++++++++++
 drivers/platform/x86/asus-wmi.c              |   4 +-
 drivers/platform/x86/ayaneo-ec.c             |   2 +-
 drivers/platform/x86/dell/dell-laptop.c      |   4 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c     |   2 +-
 drivers/platform/x86/fujitsu-laptop.c        |   4 +-
 drivers/platform/x86/huawei-wmi.c            |   4 +-
 drivers/platform/x86/lenovo/ideapad-laptop.c |   4 +-
 drivers/platform/x86/lenovo/thinkpad_acpi.c  |   4 +-
 drivers/platform/x86/lenovo/wmi-other.c      |   4 +-
 drivers/platform/x86/lg-laptop.c             |   4 +-
 drivers/platform/x86/msi-ec.c                |   4 +-
 drivers/platform/x86/oxpec.c                 |   2 +-
 drivers/platform/x86/samsung-galaxybook.c    |   3 +-
 drivers/platform/x86/samsung-laptop.c        |   4 +-
 drivers/platform/x86/system76_acpi.c         |   4 +-
 drivers/platform/x86/toshiba_acpi.c          |   4 +-
 drivers/platform/x86/uniwill/uniwill-acpi.c  |   2 +-
 drivers/power/supply/cros_charge-control.c   |   2 +-
 include/acpi/battery.h                       |  16 +-
 26 files changed, 367 insertions(+), 196 deletions(-)
 create mode 100644 drivers/acpi/battery_hooks.c


base-commit: 4c18627a1dfbfe537580f831e60218644c94ce12
-- 
2.56.0

