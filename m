Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD66392811
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777101968; cv=none; b=tPpI0cKKGMohqV+gnTtvdGXBVblja3GoiiM+Mjx9zO4o9IkCGs3iEFdH1fbWmSzR5mE1x2pwna3nVbStIT8cucPc8SX36jkWf0GSDP7Mqqvx/+zHW3f+ZKwriHkUBEri+E74Ci6GHhA1/KMJIEr+0BYmktbGQ/YWODnn8fvX8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777101968; c=relaxed/simple;
	bh=RFmC3K8jrTupJ7dhSLkA7csOOl7bPoSWGxTXXk+meu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hM3abtfhtnYVwXGCh5nOyqMfhEU3fbvF3jFNrsf1Lxj62QH7jpyOdb+af2yEfdz5LcK5tLRcrfYzt/it+Yuue1yY4N/oGdOsFudRnqM4wLSUvg18gEJFq4jPkVdm1cvrfBUww/AonAnf1LGgYHHPv2iDsUpIXU6JbdVLhYTZbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe2hprLu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe2hprLu"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso76730941fa.3
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777101962; x=1777706762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKHVqReBQ3i+ELdn29zZ2vARVPMZfgkKZuXtW92mDcc=;
        b=Pe2hprLue/BZXjC8vDIZVajmCf6LRfbp6JIfrZdeHBZ5caJRNBB6UkepwmUMBlg0OU
         Xvbrwt/f5TSHClATZTepgoQ+4mNKz3H2QVIla7yqoQVzcD9kr2A0LoiQAUbGKd1LcB3/
         BiflVxJ+VAgbhOZGnDrbbGeeQU/CqRXSsq33XZrPInHDF/rty76uxZD2pZ0TTNDJEljo
         UvuxFwUv/0f0c9tyJFhVg6p7cLvNMT50hkJiwnH0yN9vaWJN3xCgKhpUTWAJZnzndqbH
         4VfLmmL37GKdjrUJr0kZ5oNTm7CWY9MNethuNs7F9UorK8DlABSyffFp8jmGS3LRF22O
         1mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777101962; x=1777706762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKHVqReBQ3i+ELdn29zZ2vARVPMZfgkKZuXtW92mDcc=;
        b=IB16MXDwVaFpZvLfIZVRY4JxEVeiF7QE+EV2MAGY92piOpGnoDtlePBP9PipYaRHKO
         X0yMhsuCdSe7SNcVumfQ4rKIN1U8BStz5kOsGgrm+xtSfOrGPTdTkhKWy8WLv1ThdIWR
         9+c48Tvdyajc4cLiXHkIUiwr8zrTnglWnH3fBd07cMicqLSBKwM1YucRkOh3Q7rqRG/H
         kPWAmb7fNZcR5BuZSKIGK8Ok0EgRYS9pRmFdS5uBsXfZ/mXVZ6pv/fOnCsEiTnE5nmkQ
         sF201H7B204KPoe5CFarx//6E9aIff1cofGx+023D0HFIJUikcgTfYfwF3CtAnw+/PuY
         QKGw==
X-Gm-Message-State: AOJu0Yz72RoiFBxOgrkFDAewNJP11/eECwjdIImeACVwzECDvnu16EeN
	b8kkagZNgLYc6UiZgJ4e5C64b7Fou8hdorqDLWLamEhcW1FN2jAmHpMfEi3KCMTx
X-Gm-Gg: AeBDiesnufSEW4oKhx9Rn1hvnmnJE/F8kQo6ZaA90dgPx0smea7wCADpWa1LfiurwxS
	78c9ZMpFLPxkRiLKJtJ63sGfuZ/tGk0YNxJmWI+0ZsuCHxrHrclKMioZPD1+8qPwp3Cx+YOdvPq
	p8XqIfdvScrkJEqq9ygSBFOs19QnepEoHM438qhTKMBHuiX4SJgdzh4JgWylYyhvfZmM3O4/VJ4
	gUFYb/Vq2xSR+GfsZA7jAhrAPAUhMF8Wjtmm6w3IDBVRnPs6o1+YCioYtqdFx7Ptztu6l47a+MP
	acfntKvTHRpUQYjXXUHlexetXCALkaX+n8kT3oL5/PQHSq1KseQ58rGVI+spudBPa5uuk1TzyDU
	X1YUTCEnleEE4y1KzTYK52DwTp/bg1YU9BK6DB+wPyvJnRZ561M9UlsXiJpl/JMDLNV/ZZZpfvC
	EpZ+baDL+o8C79H4nYWLLPYr3QvRD+vaD8amAy6luPbi8Fh6U1LnFkJCB3yFviBVXFaiU5LJFra
	ICfsyc=
X-Received: by 2002:a2e:9fcb:0:b0:37f:c5ca:a6d4 with SMTP id 38308e7fff4ca-38ec77f630emr109460031fa.6.1777101962176;
        Sat, 25 Apr 2026 00:26:02 -0700 (PDT)
Received: from abityuts-desk (176-93-242-43.bb.dnainternet.fi. [176.93.242.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6666sm55070071fa.15.2026.04.25.00.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:26:00 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 3/3] intel_idle: Drop C-states redundant when PC6 is disabled
Date: Sat, 25 Apr 2026 10:25:32 +0300
Message-ID: <20260425072532.358365-5-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425072532.358365-1-dedekind1@gmail.com>
References: <20260425072532.358365-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

On modern Xeon platforms, such as Granite Rapids, Sierra Forest, and
Clearwater Forest, there are two flavors of requestable C6 states: C6
and C6P. C6 allows only core C6 (CC6), while C6P allows both CC6 and
package C6 (PC6). PC6 saves more power but also has a higher exit
latency, so many users disable it in BIOS.

When PC6 is disabled, C6P becomes identical to C6 — the CPU treats C6P
requests as C6 requests. Exposing both C6 and C6P to user space in this
situation is confusing: two states with the same name look different but
behave the same. It also adds unnecessary overhead to the cpuidle
subsystem, which is a fast path: the governor evaluates every registered
state on idle entry.

Drop C-states that are redundant when PC6 is disabled by marking them
with CPUIDLE_FLAG_UNUSABLE, which causes cpuidle to exclude them when
registering idle states.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 562f8e27256e7..f052564eb308b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2087,6 +2087,53 @@ static void __init spr_idle_state_table_update(void)
 	}
 }
 
+/**
+ * drop_pc6_redundant_cstates() - Drop C-states redundant when PC6 is disabled.
+ * @states: Idle states table to modify.
+ *
+ * When PC6 is disabled in BIOS, C-states that exist solely to enable PC6
+ * entry (such as C6P or C6SP) become identical to shallower C-states like
+ * C6, and are therefore redundant. Should be called only on systems with
+ * multiple C6 flavors.
+ */
+static void __init drop_pc6_redundant_cstates(struct cpuidle_state *states)
+{
+	int count;
+
+	if (!skx_is_pc6_disabled())
+		/* PC6 is not disabled, nothing to do */
+		return;
+
+	for (count = 0; states[count].enter; count++)
+		continue;
+
+	if (count < 2) {
+		pr_debug("Too few idle states to drop PC6-redundant states\n");
+		return;
+	}
+
+	/*
+	 * Sanity check: At this point all platforms with multiple C6 flavors
+	 * use the CPUIDLE_FLAG_PARTIAL_HINT_MATCH flag. And the last state in
+	 * the table is the one that becomes redundant when PC6 is disabled.
+	 */
+	if (!(states[count - 1].flags & CPUIDLE_FLAG_PARTIAL_HINT_MATCH)) {
+		pr_debug("Can't drop PC6-redundant states: unexpected flags\n");
+		return;
+	}
+
+	/*
+	 * On all current platforms with multiple C6 flavors, there is only one
+	 * C-state that becomes redundant when PC6 is disabled. This state is
+	 * the last one in the table. Drop it by marking it with
+	 * CPUIDLE_FLAG_UNUSABLE so that cpuidle excludes it when registering
+	 * idle states.
+	 */
+	pr_info("Dropping idle state %s because PC6 is disabled\n",
+		states[count - 1].name);
+	states[count - 1].flags |= CPUIDLE_FLAG_UNUSABLE;
+}
+
 /**
  * byt_cht_auto_demotion_disable - Disable Bay/Cherry Trail auto-demotion.
  */
@@ -2176,6 +2223,12 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_ATOM_AIRMONT:
 		byt_cht_auto_demotion_disable();
 		break;
+	case INTEL_GRANITERAPIDS_D:
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_ATOM_CRESTMONT_X:
+	case INTEL_ATOM_DARKMONT_X:
+		drop_pc6_redundant_cstates(cpuidle_state_table);
+		break;
 	}
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
-- 
2.53.0

