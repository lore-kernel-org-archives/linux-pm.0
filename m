Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307423;
	b=s+1vkyl9vLU3YUw41zYtBfhCn7RI4D1+sgQuIkf7HGoIu/AvqMH6bQgqD0iBxDrmLByW
	 K6QckgWM+CQMbuaJgS4DlZSQ7beE4RGezqbi9VKVQc89Skkxn739RGOeCvhAOFt0QJa9R
	 Nb06cWE5v1e2TZi3KHvYNYYucSZ+OTp72cYwTPz8hizYt3rUdZyTIsNlyXl3bsPPaMa20
	 a/L0A7I2feFekTK0HhJd5bc3mry1gsRnQlgCUwQFA4hiKsh5fn4aXcwVf3JPDxicyhE4d
	 ADnUvZly/czV0zhEIYh5vV38EIdkSuBQJE6O70XJc7dIv7Hs/knac7/B8OFBcsKN0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307423;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YiuNtoadEb2fYu5D66M3jxWCnwLHpafBtCO8u8iTU+8=;
	b=L+hQFp0wkF718XdUIuRiKWR/rxaX0vX0xHURcZ6UrN0tWarzqX58pXvaQbc9hM8p/U/Z
	 e4piLJMxt1d5QwyOuekm0yvSaVreXETjzU+vV9kpPB409HfG5YlQIlAlUeLgz76hylcSW
	 /geUla8Jckedvy5bKwIeRkJ/CD9235EptA8kDDp0tdH+A4MZSUTWRXLl3HB6JztYNEbBb
	 IoHoRLrQ4BcPDTpQ+JT3ZdTzxLyuf0V+Y0KtDnTmSuxnDYrKi7Tr77QvuGzTa661jltGF
	 j6yKIoy1Qyopk1w6x2pQvXrX/Kf4U/jKPiBtertj4q3f7BwmlmDMkvipbuQM9HiMEAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FeY/AOWB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD7606A31C;
	Tue, 10 Nov 2026 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeY/AOWB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E391F0089F;
	Tue, 10 Nov 2026 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307422;
	bh=YiuNtoadEb2fYu5D66M3jxWCnwLHpafBtCO8u8iTU+8=;
	h=From:Subject:Date:To:Cc;
	b=FeY/AOWBpzQ/S7J6iFqLmzwVBXY9x40/I/FMoUIqTXr/ulv2nuiSSEomBX2mUD1jW
	 7XzDft8aDfLitv6DtU3dNvQoMkIPrjpEaQZwo3pP8aDdDGxhGgV33nDpOq2HbTrrgN
	 OFhE+2iaI4tqGxJr4SxRTBX2xaxn+fMYfr92OwFbNkPu2ga2aFhkM8L/eIENM/j/Ze
	 us1GN0DuwjEwkV5r0ozoJk0i+svTco7uaPGMJJDQiUgJU5x35V0OWIjPI5/wiyEu7w
	 eUVqUagr/6QOtoATPgzBHpq3AswkZWDSmx91HsXqWVDO05MbhqZUjihxyg3fhGiC1B
	 T0lmiL6/tWvJg==
From: Joshua Crofts <crofts@kernel.org>
Subject: [PATCH 0/3] PM: runtime: add new runtime metrics and summary
Date: Tue, 10 Nov 2026 11:43:19 +0100
Message-Id: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAEf18moC/x3MQQ5AMBBA0avIrE1iKhFcRSxKB7NoyRQh4u4ay
 7f4/4HIKhyhzR5QPiXKGhIoz2BcbJgZxSWDKUxFRAVuHvUIu3jGeHhv9cbaOdNYKutyGCGFm/I
 k1z/t+vf9ALnTxC1kAAAA
X-Change-ID: 20261110-pm-runtime-summary-8dd29a1383bc
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>, 
 Dominik Brodowski <linux@dominikbrodowski.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794307420; l=2886;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=4RppwwC72xqx+5SaBDh+X1cHLYomNYAi4BuP3a4n5rg=;
 b=29SLnYAn6ZWG6/R5iTCPusgi7yW9wIpk5bJJxOtAYiYjAl3NFdVq8DkUt3EnfwXzGrvxxYyLN
 xx+WiWT2iFbCJCpdlI5VRRrwz6fgFjty6B4IJFgyARKJWRmZpNX8y+A
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

Add a new set additional PM runtime metrics to improve power management
debugging and reporting (these metrics may be useful to userspace
utilities such as Powertop).

MOTIVATION:
The current implementation only measures the duration a device spends in
suspended or active mode, which is very limiting. We can't find out how
many times a device changed state or what its shortest suspend cycle
was (to detect a sort of power "thrashing" behaviour).

NEW FEATURES:
This series introduces the following new metrics:
- resume_count : number of successful transitions to active
- suspend_count: number of successful transitions to suspended
- last_suspended_time: duration of the most recent sleep cycle (ns)
- min_suspended_time / max_suspended_sleep: shortest and longest sleep
  cycle durations to help detect power thrashing (ns)

By reading the debugfs file /sys/kernel/debug/pm_runtime_summary, you
get the following table describing the power stats of each device with
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
Joshua Crofts (3):
      PM: runtime: add additional suspend/resume metrics
      PM: add sysfs attributes for additional suspend/resume metrics
      PM: runtime: add debugfs entry for pm_runtime_summary

 Documentation/ABI/testing/sysfs-devices-power |  36 ++++++
 drivers/base/power/runtime.c                  | 156 +++++++++++++++++++++++++-
 drivers/base/power/sysfs.c                    |  81 +++++++++++++
 include/linux/pm.h                            |  12 ++
 4 files changed, 281 insertions(+), 4 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-pm-runtime-summary-8dd29a1383bc

Best regards,
-- 
Joshua Crofts <crofts@kernel.org>

