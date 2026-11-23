Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424859;
	b=zs77JG7c195l9RIIqcFt1CwEgysSwawRxY/nIyWIYywYywbxN7cux4lv9xHv9XXLHHLF
	 B+dAlB14Hs9YvrcArknBtuoiCqU2VoqXMYxH+BsYGoN1qLPZ+ABCp/9l70n1dLhGvTecF
	 3Jf8DiR25EBFu3rbKAspKwLLvAaGqM9n/ZrbEG9H5dK9QTWCKqaPeouPMZsL78DpngFH2
	 Pjyrdaqb9PM0X6KDIhdU59nXi/Zceh2mUiVSfCQ5rASjeJPg7eQ1oSdU5qq7+fwsUO3qb
	 d7+qSYA/z7palU3doJT2NfuWXSVObtuKgrtvhxdLGLMzuBEMF38QvPC8hV1cwMxxm6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424859;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jLIPT02dVVv6qszhT2W4/G5KPBa16vNIGlRpw6ARLT0=;
	b=twEZSnr5JM/gqHwjH7e5ospZjAJhMnrKbAiHLp+1n6pxxpa9G/7AHGRLzIKAFKhWvwLu
	 5yyNNKBAc0J5pg3WLTtKOP0wEohe0THZaR+x+k4dA9wb6HGdMMSeafvmY9fMowPXZyvYH
	 BQ77IA+SO6NlVY984ejghOh1MRrhlDOU/DHGZUvkc3T7ctf/u7pwDxCYWqT6HdUshoH7E
	 Vr/uKDvyBLYj1nmpP30opDZfOjfi7d1N7sDh9Zh4nDYqoT7sIL4SFt0+Qy6JR5Cd7AnXS
	 vR1LJoC4R2xMaSn/eXfDw91MMHKO25pGs34Lq+US5K6MU0VBkAa2pF8CkBEyuMf+DZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYW7ZfgB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F3606A321;
	Mon, 23 Nov 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYW7ZfgB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FCD1F000D8;
	Mon, 23 Nov 2026 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424858;
	bh=jLIPT02dVVv6qszhT2W4/G5KPBa16vNIGlRpw6ARLT0=;
	h=From:Subject:Date:To:Cc;
	b=kYW7ZfgBSvpg8KfKNVpDYkG5LXZZ9zcSkLwhJrrDQZ1NBk5pKWgcD3RgjhOTCeOyv
	 odFFw0v0DWmrKvfMmFRtO1icOKyTr7f+68iQ2bMnJOSdkEqie3qffCIIpJStNpx0uP
	 WT2L5l7jprUtCBXjJ8qVKgOm1o56x8wdOLchN/1qtOtat8DlID4CfEZnRXochJ/6Xy
	 y5q2XK1Aix6AOJWUMlmlddAcRhjywx5/10nSfvUyrQtk4kFrYzCajIZ29EdHNb2G4M
	 2HbtGUwU3torm+LUezSy0mZIeo7OJxnLQtQ9tcIIYEqJ54g4g/LKCCy3ZCl7olWoZI
	 OSk6XFEXIVIPg==
From: Joshua Crofts <crofts@kernel.org>
Subject: [PATCH v3 0/2] PM: runtime: add new runtime metrics and summary
Date: Mon, 23 Nov 2026 10:06:53 +0100
Message-Id: <20261123-pm-runtime-summary-v3-0-81a966953a81@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0CBGsC/33NQQ7CIBCF4as0rMUU0IquvIdxAWVoiUKboSU2T
 e8u7UoT4/J/yXwzkwjoIJJLMROE5KLrQg6xK0jdqtAAdSY34SWvGGMl7T3FMQzOA42j9wonKo3
 hZ8WEFLom+bBHsO61obd77tbFocNp+5HYuv7lEqMlZRy05VIYfZLXB2CA577Dhqxe4p9G9dPg2
 VDCyOp40MpK+2Usy/IG0IOyBfkAAAA=
X-Change-ID: 20261110-pm-runtime-summary-8dd29a1383bc
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Samuel Wu <wusamuel@google.com>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795424856; l=4098;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=OtDsCHXwWD+Ufbu1uwi7CcAIu2+RlIScZzvgxk6ftQg=;
 b=kLr1WSPWI7eZxcI6jLCNGqF/iv0BwCUxTkm1NbmxA9jWehzuL2FNVHScLyhUk7LjXahqXEnie
 jkKSpxyElxzCaZPzx3/S7Z4RX/2O8qzJroRcQ7QSuBzr5IwLIoQHB8l
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

Add a new set additional PM runtime metrics to improve power management
debugging and reporting (these metrics may be useful to userspace utilities
such as Powertop).

MOTIVATION:
The current implementation only measures the duration a device spends in
suspended or active mode, which is very limiting. We can't find out how many
times a device changed state or what its shortest suspend cycle was.

This overview would be useful for detecting power "thrashing" and tuning
autosuspend delays. Currently, sysfs only shows the total time a device spent
in active and suspended mode; from an energy standpoint, a continuous 50
second suspension is different from a device cycling 1000 times for 50ms each
(these transitions can be pretty power-hungry). This could help userspace
utilities like PowerTOP to more effectively determine what is causing an
increased power consumption.

NEW FEATURES:
This series introduces the following new metrics:
- resume_count : number of successful transitions to active
- suspend_count: number of successful transitions to suspended
- last_suspended_time: duration of the most recent sleep cycle (ns)
- min_suspended_time / max_suspended_time: shortest and longest sleep
  cycle durations to help detect power thrashing (ns)

By reading the debugfs file /sys/kernel/debug/pm_runtime_summary, you get
the following table describing the power stats of each device with
runtime PM enabled:

Device                           Status        Resumes Suspends   Active(ms)  Suspend(ms)   Last(ms)    Min(ms)    Max(ms)
--------------------------------------------------------------------------------------------------------------------------
0000:00:02.0                     active              1        0        45688            0          0          0          0
0000:00:1f.0                     active              1        0        45687            0          0          0          0
0000:00:1f.2                     active              1        0        45686            0          0          0          0
0000:00:1f.3                     suspended           1        1         1658        44028          0          0          0
00:03:0                          active             15       14        19627        25899         42          5      14811
00:03:0.0                        active             14       13        19626        25900         42          5      14811

TESTING:
Tested with an x86_64 defconfig kernel and QEMU.

AI ASSISTANCE:
Gemini was used to prepare this series.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
Changes in v3:
- Guard new metrics with #ifdef CONFIG_DEBUG_FS to reduce overhead on
  non-debugfs enabled systems (Rafael)
- Fix runtime status transition fixes flagged by Sashiko
- Link to v2: https://lore.kernel.org/r/20261116-pm-runtime-summary-v2-0-a3d8654baf8f@kernel.org

Changes in v2:
- Drop sysfs patch as it would have a non-negligible impact on boot times and
  the debugfs summary is enough (Samuel Wu)
- Expand cover letter
- Fix Sashiko findings - typo in commit message, race condition, duplicate
  function call
- Link to v1: https://lore.kernel.org/r/20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org

To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Pavel Machek <pavel@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

---
Joshua Crofts (2):
      PM: runtime: add additional suspend/resume metrics
      PM: runtime: add debugfs entry for pm_runtime_summary

 drivers/base/power/runtime.c | 179 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm.h           |  16 +++-
 2 files changed, 189 insertions(+), 6 deletions(-)
---
base-commit: d40cb8a12ed25789f39404c5f7968a65e98d89c3
change-id: 20261110-pm-runtime-summary-8dd29a1383bc

Best regards,
--  
Joshua Crofts <crofts@kernel.org>

