Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821782;
	b=CwNjd/jEb8T7s0ssDI7YPcGPQ208f+EvEPs65QfJyASI4cx1HBf8XpjwuGpfJXwTfkf7
	 mwLA21yC7DuKEIRPdToKYtOZ0ctzrhTkZyxWYPXcXnCCrC7dvJlJRf1tayOEEMmMWxcNp
	 sPxr+wh2jKcgTcQljOMXRWLFaex9E2Sb8cn+EHRDS4tYEtqp8cxjtfUi0YbTy9jb3Xmtd
	 SjFeFth+o+OktiGlHfBl3guedgmc3USAbjn9jTM9D49spFpJuzQgK4kO+3UHXs3xArnHp
	 9EwkMkV3g3XkDzkpZKddu63fLyjKx2Hf9JhqTJZuat08RdD8Wqnp3T7fvSZ5vDM1GUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821782;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ViEliqle6kflCGgFCg32cx4wLOgez678KjjsxFsox/Y=;
	b=vWPVZuSFnPlKxRI8Qi4qGv6c9yH9KqM3RdxTqx9maFbg0OTX9kt0o1ehw9mZde4VYvA5
	 9sPuHuiOHqJIRjqk7O+UHXTLEtevHi50h3u653lqQ2ci4n/8DXw+VSfhZVZkWre0CixiS
	 PtJcv6h31iEGK0/YOqEObs+xfxRdN/JBKSN1B/qbCsGy6lGtUMKNF1KXFnFMdrqMbzIi1
	 J+zreEtO/uqPOWdHgwTds/CBzl2urwvx61VRWmQ9/fv4MjB3o73oAO9OT1UZF4Bz0uOpI
	 cWmEqCJbnbzaPOSuYOld8DQUUtZpXMqE3Qi1hLV4txFxIfRXS+xdWQtAKz4cfe21dZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7fR+OIR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A58606A31C;
	Mon, 16 Nov 2026 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7fR+OIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F11F000C4;
	Mon, 16 Nov 2026 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821781;
	bh=ViEliqle6kflCGgFCg32cx4wLOgez678KjjsxFsox/Y=;
	h=From:Subject:Date:To:Cc;
	b=Q7fR+OIRMhdXdZ9zp/PcYceBlSXFHyNV8n1ju2GC4d9wfSVFk+tujnBRx9mvB/qvZ
	 /9Dn+a6oVUrsV+XhluZAq5Uu+43TLJLUqZeF6o7fKZ6hzX4wOR846+S5UMaLceKDEp
	 oKyJPmV3uXnlN7LZ7tj7Ayth7N5nHzlXCF8YmmlHGeaiHCzfLZzaxmd2bZ5DWWTgML
	 hM2ttlNPfBBwArk0meBKMc22s3/4A19frV+vrZr4Z5U2PZQdx6DziAxONyA7oLUXMO
	 fMnT9K3JDB+Ibay5qQca7PidwD8t6vrgWBlQrFRmDSkeQtxZWdIKzG1parZnKgHat7
	 lmGWJD32oCQDA==
From: Joshua Crofts <crofts@kernel.org>
Subject: [PATCH v2 0/2] PM: runtime: add new runtime metrics and summary
Date: Mon, 16 Nov 2026 10:36:08 +0100
Message-Id: <20261116-pm-runtime-summary-v2-0-a3d8654baf8f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAIjO+moC/32NQQ6CMBBFr0Jm7RimJFpdeQ/DAugAE20hUyASw
 t2tHMDle8l/f4PIKhzhnm2gvEiUISQwpwyavgodo7jEYHJzIaIcR486h0k8Y5y9r3RF65y5VVT
 Yom4gDUflVj5H9Fkm7iVOg67Hx0I/+ze3EOZIhuvW2MLVV/t4sQZ+nwftoNz3/Qs8Wr/ytQAAA
 A==
X-Change-ID: 20261110-pm-runtime-summary-8dd29a1383bc
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Samuel Wu <wusamuel@google.com>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821782; l=3468;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=asIiqWvwTSWXMC3eVCm+se5bGbZK1Z7Ol8TWP0r6DhE=;
 b=WiO2Z25V4sDZg1GDbvwnfsWpb0Gepi3Esq8S/+3qAXm8FLSa/+t/BIrnJIgfhsZeEvBNEKNO4
 fqFHgIjQR/mCERJRWbbtHIT3wrP7PezJ6qc8GUklu4MoNDof80puh0w
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
Changes in v2:
- Drop sysfs patch as it would have a non-negligible impact on boot times and
  the debugfs summary is enough (Samuel Wu)
- Expand cover letter
- Fix Sashiko findings - typo in commit message, race condition, duplicate
  function call
- Link to v1: https://lore.kernel.org/r/20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org

---
Joshua Crofts (2):
      PM: runtime: add additional suspend/resume metrics
      PM: runtime: add debugfs entry for pm_runtime_summary

 drivers/base/power/runtime.c | 162 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm.h           |  12 ++++
 2 files changed, 169 insertions(+), 5 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-pm-runtime-summary-8dd29a1383bc

Best regards,
-- 
Joshua Crofts <crofts@kernel.org>

