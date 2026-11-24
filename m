Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534847;
	b=4s2zxEmZvvTjkGaz+r9QgKY673WUlDFXusTPgwt9AbZYJWLRPrXw5lv1m1eDQVjQJR1O
	 GfduA/IotsjkTZKDZROvnfdUptn7b+YPv7AWjfN0x3JLqDGhW5RaGvnPoOURe4eNqJ3fm
	 ehEnXobBlAA/ScdAfcWJNxHmZCBmSjf+UpFMtra2P89668vtaSkhIxytfoH08itjPsb0g
	 AvG1oCF878D1+CrRj1lF4xMfvCykMuqUvQvBe4gI1amT57NIRdAdIyMo1rYpPBiD+NBK6
	 3bB44baI9lriX7+0KY/fc23KAaXJoREhKnDA8Fsfaob9X3l6ME2q2mp+y3EdSmeJGqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=7U6XDcsaPa3oJvWeidcYr1VQKbTn/dGfWC31VZJODa8=;
	b=kZc8ku09AY9f2ESl8b+naxLlRLIGEwV3Wu/osh3t4AX5Iezbh4EesyEw+yzo/LeKdvhU
	 uNs7zJWqI12fuJ5ftD7taC2ayB7t3gg/Gu/7oQFvzPjJJZmJr865XfCPDlDVvVnIBIQ/h
	 MrRE6E0mQ4zCP1qTCPiXQNhe6WXcYWpMVsJ6SDX25L1InBeY8gPbulHyqR3JP3hC0P4yF
	 W9LwH7U0wGE5kOzESJATYtiMXdq0hQu+TCM+x1Nhw8Bg9FIB0QlI8RBjWEsBczNci+mnD
	 vxDJ4jHBcYcVm4vQE1BVY60ErnWG8DuPlIN01iO2NKxnIzauCbZqfCzHW4R9ASmjh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYlgtuVH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924E606A321;
	Tue, 24 Nov 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYlgtuVH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656671F000E1;
	Tue, 24 Nov 2026 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534847;
	bh=7U6XDcsaPa3oJvWeidcYr1VQKbTn/dGfWC31VZJODa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MYlgtuVHZZ5/kMGaA3WYnsw6QUYVDMNmh/7cbSep23muHvz3/wR9hNpdWJN4r1Xad
	 FHJaGp0LGHiLMVsMTfQT8KI3BrOzXT5iRsec2xmhYrr1wA9tra9jfyF7HwWEBdR9PN
	 MPNXQhjynHF1aF7S0XaSwbARFJECybLwe/fw74bXbM96Mrx6sLUEIAP+9IDwylrLZ/
	 2rWMF4Wf3LiFh7uPbiUXXygYSjAwkRk4zzc5+UUsbkX/YV2mDzGMYv2AeoQfdF1MKL
	 PWD+ZJA/PQQhDnqve1d1QL6PLdR54yLG73XExejAzN+AC0Jsx03T4I6EKgVU5hx+CW
	 sQQQc6UB4ESVw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v2 1/4] PM: runtime: Add memory barrier before reading last_busy
Date: Tue, 24 Nov 2026 16:31:51 +0100
Message-ID: <14142601.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4779892.LvFx2qVVIh@rafael.j.wysocki>
References: <4779892.LvFx2qVVIh@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The users of pm_runtime_put_sync_autosuspend() and
pm_runtime_put_autosuspend() can expect that the autosuspend delay of
the device will be respected after calling one of them because they
both invoke pm_runtime_mark_last_busy() upfront.  However, that may not
happen due to a leftover autosuspend timer running when the last_busy
update takes place, in which case rpm_suspend() triggered by the timer
may run in parallel with the lockless last_busy update.

Namely, the last_busy access in pm_runtime_autosuspend_expiration()
called by rpm_suspend() may be reordered before the initial read of the
device's runtime PM usage counter in rpm_suspend(), and if last_busy
gets updated between those two reads, the update will be missed and the
device may be suspended right away.

To prevent that from occurring, add a read memory barrier before the
last_busy read in pm_runtime_autosuspend_expiration() along with a
comment explaining the reason for adding it.

Fixes: b3db492e8335 ("PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()")
Fixes: e24e0630b5ba ("PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2, based on

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=26236a3e8803f7e1ace104020d7f006edb220116

---
 drivers/base/power/runtime.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0b15c718c1bb..c295acf6a718 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -186,6 +186,13 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 	if (autosuspend_delay < 0)
 		return 0;
 
+	/*
+	 * Prevent last_busy updates occurring before the rpm_drop_usage_count()
+	 * invocations in __pm_runtime_idle() and __pm_runtime_suspend() from
+	 * being missed if the last_busy access below gets reordered before the
+	 * initial usage counter check in rpm_suspend().
+	 */
+	smp_rmb();
 	expires  = READ_ONCE(dev->power.last_busy);
 	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
 	if (expires > ktime_get_mono_fast_ns())
-- 
2.51.0




