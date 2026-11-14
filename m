Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657114;
	b=tHWgGIftak+Y527CTHlTuiAihYbZJZOPRLJgwufeqnpMYxvYnLcabUyNJQbBx13AsD+g
	 7/B5KfJpjpQaraWNcR289UhSOk5J5smuVCVsENUKsV45NLJ5t2TQr3AeBmEgE4E0zvxlY
	 llSpUtEjerRAkaCCbR3MjUJn9NhKbgHCaQcQ59K6zjk+QUW7zzEw4fNEEhiQr9/asbmuM
	 NJNUO9+JC8evF3cj9XPU8oNpqLYiEDmj0q4jw+FFUGptCGDszLHixV3ODo649dNc7T1HY
	 IJRymCd4tWfcEwuO0XyRyIU4IpF2JSu0DOAwU1Z90FLpVGjG451EtQYnRV6A+sAdywg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657114;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gcijfE1EjnPkuvJh2fml5+/0Zg2s6AAJRpyGvfGcPGc=;
	b=QzdSIF0cFVusEhizpcq8q2szdZcKSH5q4MfLXycjeoJ8MfEEr/tnswv2myCvZ8GG8r71
	 IjZDsnrirDepU2/UL/cotw1cgzjfZbuQWopuStkWzWWhAoh0DOSOvn/BxuuG1kr5K0Aew
	 AfaDWCADphopqo6d8dZ1c6WxU688rixVA7sVVhbBIznXN0gPDowH1FcTD6A+OoxUoUT9Y
	 yQA8l0d7jfeTcthG731NIh9kWKNYxEZq6Qp7WvyvP1o+rApR53QMy/bYZzq0kIVRwJzSD
	 65k9ewNO1PtmiDEokvD8iKN2BXyr0eIFl3TxYQjK9eMNmanA2s0413COvU9FVV3EyeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYkF5qqs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54430606A327;
	Sat, 14 Nov 2026 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYkF5qqs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794657113;
	b=YxdBJCDnHWJ0z7xQTlOvkpd2lUsyBIB4PpAXNkpWjsQPZZT7MByCbWVgNgi2kJnIzeEC
	 B8fx2bLxQSJlro4TSuLy7KhUj2/K7oQYgZy2q1usGgCd2rHVvz5kWm6e1xC6p08fgG3/3
	 L1rsX8wWf58TD7aAoZYKsoWHGstsDJLEknp3cDo06bdSbUkNE6ozHJ8jRE/vPXGlhfORR
	 jOy79lvLOvhavgl98051bPmIPg+WJbdf0LVvgz/aI69TZ/GrxP0PoYc0UghS/dJDov9lM
	 kvPv9tEfwYy3ND07X1mox0SL/Ojb4WnLGEFY5EJ7JdzRHCfKvaoIOHYH0HK3MKWMMfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794657113;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gcijfE1EjnPkuvJh2fml5+/0Zg2s6AAJRpyGvfGcPGc=;
	b=rCjNUHq68rUyPU/YmSNEGYMZrGrrOkapUt/cR5TKGe2k6jr0EfU24DwWWuojXn9oiq4I
	 Qouqx15imMMZCh2vu/3/5Zca7tzgXQDQch6U6JpfLpP0FjfRXgweVrV4ZWP2ZzvJhMcp+
	 +td3SS/Y8Wv7tmOSh0eAX6vdUqErlBQ7hg4NuHl/8A+7N0oX6rDqTxC/PtZo7mwdphMgP
	 VX6EbPPuEwhFKMZd0sQd4QiFXBUlXxBexXcr547l208WWR/iT58WRzgIUMDrSSuztT6UI
	 bQagNzT2TK9ZaNbXWJgRFX2p1u9lYpvTbzU+of71gBIX0deSY8qLxTQpMmvsCUy8xeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 500A41F000C4;
	Sat, 14 Nov 2026 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657113;
	bh=gcijfE1EjnPkuvJh2fml5+/0Zg2s6AAJRpyGvfGcPGc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=WYkF5qqssOkidP4r5FdtTHdjVTT5Fb4rgvSjz9euZkq1H1XsOBcAyTEQV6ItAYXZ6
	 +aAC+lNg5VQEcW0GTgyNjwnrY4aP94gB4ceaZYM2wezyLdh6OW14DbRC8zpGnFdaxr
	 jY4Fz5UeCgL2w/G+TSa6wJI2lPfPwUO0ouqdT4C1fSsvNCJUc26yxTkndKNjQK7mNy
	 fj8mEhWcZiGTVal17F2FQbCdlwjT9oT/FZWOnaXTl0zY8V499HeSMRg/iF1AGQPsUz
	 8cqrR/k8cX56yB4pJvX6EpjPWJxCJjB7O3u5c1YYGaarI9HbPWcLCrPgFVH8OwO8Oz
	 pDE0M8+bGcu2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D078549D59;
	Sat, 14 Nov 2026 11:51:52 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Sat, 14 Nov 2026 11:51:52 +0000
Subject: [PATCH RFT] cpufreq: intel_pstate: Refresh cpuinfo.max_freq when a
 CPU goes online
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
Message-Id: <20261114-intel-pstate-online-max-freq-v1-1-1bbdae2b4986@hsal.es>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAxA0atUnrGEAxTEAThAxYYY0uCAUXFLH
 FClqncnwPj/8CYwTsIG+2qCxG8x6bUELSoIN69XRrmUBrd0NRGtUDRzh4Nlnxl77UQZH37EmPi
 JFOu1C26za7cEhRgSRxl//AmawxHO/2mv9s4hf2GY5w+NBwP7hQAAAA==
X-Change-ID: 20261113-intel-pstate-online-max-freq-1f642c258b71
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Len Brown <lenb@kernel.org>
Cc: Ximing Zhang <xzhangjr@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4935; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=G18cioDv2pnyDIPXQ04NQfkLJuWBJarAvUfVI3wRTGU=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn54R5wTdJvH/LFETEi2kt/7ddzXT51iyRU64qwX2
 NrPbebbd6GjlIVBjItBVkyRRfeGJwPLxMkzc4qeL4GZw8oEMoSBi1MAJhKWyMhwnzGX91Zdc1VV
 6Ac7gwDB6glC9m+PGTDNiih1qX8eu/wzw18BDR6ujhTp7PDnS/arcS7UWRHfb9S3/uIvt6fyFX8
 mXOUBAJxeRgQ=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
Reply-To: hugo@hsal.es
Content-Transfer-Encoding: 7bit

From: Hugo Sales <hugo@hsal.es>

A write to no_turbo or a change in the HWP capabilities updates
policy->cpuinfo.max_freq through intel_pstate_update_max_freq(), which
gets the policy with cpufreq_cpu_get(). That returns NULL for an offline
CPU, so its policy keeps the old value. When the CPU comes back, the
core reuses the policy and calls ->online(), and
intel_pstate_cpu_online() doesn't recompute cpuinfo.max_freq either.
Before commit 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and
->online callbacks"), ->init() ran on every online and set it

Turning turbo on while a CPU is offline leaves that CPU at the non-turbo
maximum once it's back, while the other CPUs report the turbo frequency.
In the reverse order the CPU keeps the turbo maximum with turbo off

Set cpuinfo.max_freq at the end of intel_pstate_cpu_online(), after HWP
is enabled again, the same way __intel_pstate_update_max_freq() does.
cpufreq_online() applies the policy limits after that. Hold the CPU
hotplug lock in store_no_turbo(), so a CPU can't come online between
the no_turbo store and the update of the online CPUs

Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online callbacks")
Reported-by: Ximing Zhang <xzhangjr@gmail.com>
Closes: https://lore.kernel.org/all/20261108071225.54656-1-xzhangjr@gmail.com/
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Tested on an i7-4720HQ (Haswell, no HWP) in passive and active mode.
With CPU 1 offline, writing no_turbo and then onlining CPU 1 leaves its
cpuinfo_max_freq equal to CPU 0's (2600000 with turbo off, 3600000 with
it on). Without the patch CPU 1 kept the value it had before going
offline. I have no HWP machine, so the HWP capability path is untested

On hybrid CPUs, onlining now reads the HWP capabilities twice, once in
hybrid_update_capacity() and once for cpuinfo.max_freq. If the firmware
changes them in between, the CPU's capacity and cpuinfo.max_freq come
from different values until the HWP notification work recomputes both.
intel_pstate_notify_work() already reads them twice the same way, in
the other order. Reading them once would mean splitting
hybrid_update_capacity(), which I left out of this fix. If you'd like
that change, I can write it as a follow-up

Ximing found this while testing "ACPI: processor: thermal: Recompute the
frequency cap when boost changes" [1]. Patch 2 of that series sends an
event when intel_pstate updates cpuinfo.max_freq, so with this fix the
event also fires when a CPU comes online. This patch doesn't depend on
that series

[1] https://lore.kernel.org/all/20261101185807.112449-1-hugo@hsal.es/
---
 drivers/cpufreq/intel_pstate.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c78dcd681511c..96c5775ed161d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1426,16 +1426,24 @@ static void intel_pstate_update_policies(void)
 		cpufreq_update_policy(cpu);
 }
 
-static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
-					   struct cpudata *cpudata)
+static void intel_pstate_update_cpuinfo_max_freq_locked(struct cpufreq_policy *policy,
+							struct cpudata *cpudata)
 {
-	guard(cpufreq_policy_write)(policy);
+	lockdep_assert_held_write(&policy->rwsem);
 
 	if (hwp_active)
 		intel_pstate_get_hwp_cap(cpudata);
 
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+}
+
+static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
+					   struct cpudata *cpudata)
+{
+	guard(cpufreq_policy_write)(policy);
+
+	intel_pstate_update_cpuinfo_max_freq_locked(policy, cpudata);
 
 	refresh_frequency_limits(policy);
 }
@@ -1569,6 +1577,12 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 		return -EINVAL;
 
 	guard(mutex)(&intel_pstate_driver_lock);
+	/*
+	 * intel_pstate_update_max_freq() skips offline CPUs, and a CPU coming
+	 * online reads global.no_turbo in intel_pstate_cpu_online(). Keep CPUs
+	 * from coming online until every online CPU has the new limit
+	 */
+	guard(cpus_read_lock)();
 
 	if (!intel_pstate_driver)
 		return -EAGAIN;
@@ -3019,6 +3033,14 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 		hybrid_update_capacity(cpu);
 	}
 
+	/*
+	 * intel_pstate_update_max_freq() skips offline CPUs, so the turbo
+	 * setting or the HWP capabilities may have changed since this CPU
+	 * went offline. Read the HWP capabilities only once HWP is enabled
+	 * again
+	 */
+	intel_pstate_update_cpuinfo_max_freq_locked(policy, cpu);
+
 	return 0;
 }
 

---
base-commit: a1c4d4a4603198108564963bb42a1e07f4eec3ff
change-id: 20261113-intel-pstate-online-max-freq-1f642c258b71

Best regards,
--  
Hugo Sales <hugo@hsal.es>


