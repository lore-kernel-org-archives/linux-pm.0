Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663810785
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287827; cv=none; b=g6JUp4Yja/vEYsAPOHGJIeRP/VapBVjJbTFiwlyyIg2BwqAR6w8T8Cyp4Rp37w+zphDcMB7NzhZ5ZXQguVjWaTjIn1kCE5Zc4A6NYxWnqnVUnw2KEdKOLaD6MMzrKcDqJ4qBktRHhQEjvDMUMkUR3gYANn5hvf75uWn5V8ZNqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287827; c=relaxed/simple;
	bh=Ms0260N9LkJUv3V2qU2ODpwuKVcozFxHSNPKHAVZZaE=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=QdhYNzv2XatXUbP0pTgIQkubDoPe9UWPiFR1oP52NayxfCTWLakGJGl6zPtgOjORIrYb9aXxUM9PhW7C7i6W/T+jXq5IxTYN3N6VVuIyGCsZ/7T55yiqVNaJ5dvKGtDJ+UqpcY0xHjZJ21aTo5gLLfFpLzeWJAvv8Jzie2T1DAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0iq.dev; spf=pass smtp.mailfrom=0iq.dev; dkim=pass (2048-bit key) header.d=0iq.dev header.i=@0iq.dev header.b=gqN4CP+U; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=le0xRqth; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0iq.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0iq.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0iq.dev header.i=@0iq.dev header.b="gqN4CP+U";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="le0xRqth"
DKIM-Signature: a=rsa-sha256; b=gqN4CP+UTMFTDyPmiKIsfelbvlgSqhvzE43+o6l4M7R6C/9ySuldmR6IqTY9jJv16Z+zU0GJZIl1QsgeUDa+rzvxHhXxd6TbfqiWDObSJ4m/ruUAZjycxU5l2n5do811LekhBTBLesggJYzkOSY5nFVPDa8YvmDha3duzFg4MSqmlACVrSz1pFlguQnDkN+ie7iNX/Zx2LjfWz2+jc2bAdtycMTleTWi4yTaUhVDOFil9bP55za3jDaU7hcvLHidXXiBbNTv0zU8f1y8VfqEuhgERiFt0P+wm0trsSh4BSqn4estlBBlmkPMh4Weq+gDUfXOTmfMFE3Ihn/dbbQ1NQ==; s=purelymail3; d=0iq.dev; v=1; bh=Ms0260N9LkJUv3V2qU2ODpwuKVcozFxHSNPKHAVZZaE=; h=Received:Date:From:Subject:To;
DKIM-Signature: a=rsa-sha256; b=le0xRqthj8NisktRkg2kbulb+VPKx5VaK6OuI2kzRcFe5kmYd9zBGDvS8W9rmL5wje8ARoHTIpTOkwoxt4hMKPgKUdAZeGhR5EhMviWDltsXBlD84MzwXYrvw9HYq+bMQrjWrSuldzXPE+XOe+AS3Ta5YRTT7DQadBXvcVRmR2tYJ7vJdmJROXgXb1373hascizhEg0wTr5CYVO/3LdFonmQSi3QYypGW9N3HyQGuvI1fxPQjvEF63ZBkhRjFvJWBOdX78OseEd41m9oiREc/DeYwloAlKdVvH9et3+5He2y/k5yl2l0tOHQoIQ21aX8AEScZ9voBR0MkOXyBORQig==; s=purelymail3; d=purelymail.com; v=1; bh=Ms0260N9LkJUv3V2qU2ODpwuKVcozFxHSNPKHAVZZaE=; h=Feedback-ID:Received:Date:From:Subject:To;
Feedback-ID: 319265:26396:null:purelymail
X-Pm-Original-To: linux-pm@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -320624632;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 05 Jul 2026 21:43:27 +0000 (UTC)
Date: Sun, 05 Jul 2026 23:43:17 +0200
From: Polina Vishneva <poli@0iq.dev>
Subject: Lunar Lake: silent fatal platform resets caused by idle-exit core
 hang
To: "Rafael J. Wysocki" <rafael@kernel.org>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <6O1QHT.QP6URTCEWLSV1@0iq.dev>
X-Mailer: org.gnome.Geary/46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hello.

So, I've got frustrated enough with my system cold-resetting every few
days to try to debug the issue, with some success.

TL;DR: cold reset on the cpuidle exit path.

It's *probably* not actually a kernel bug, but I don't know any better
place to submit it (hoping that the Intel folks will take a look).

System:
- Lenovo ThinkPad X1 Carbon Gen 13 (21NS001ACD), BIOS N4BET75W (1.45).
- Intel Core Ultra 7 258V (Lunar Lake), microcode 0x126.
- Kernel 7.1.1, intel_idle in ACPI _CST mode.
- Reproduces even with intel_idle.max_cstate=2, so the enabled
  states are only POLL, C1_ACPI and C2_ACPI.

On boot after each crash, the kernel logs:

  BERT: [Hardware Error]: Skipped 1 error records

I pulled /sys/firmware/acpi/tables/data/BERT by hand and decoded it with
https://github.com/intel/crashlog.

The region contains a full PMC crashlog (MCA, Punit, UNCORE, PCORE,
PMC, PMC_RST, PMC_TRACE records). iclg summarizes the failure as:

  CORE_TIMEOUT.SINGLE_STUCK_TRANSACTION.C898FH
  MCA.BANK3.INTERNAL_TIMER_ERROR.MSCOD_E184H
  CRASHLOG_REASON.PMC.10H
  CRASHLOG_REASON.PUNIT.20004H
  RESET_CAUSE.FIRMWARE_GLOBAL_RESET.FW_GBLRST_SCRATCH16
  RESET_CAUSE.GLOBAL_RESET.PMC_FW

The important registers (one P-core has captured state):

  mca.bank3.status = 0xbe000000e1840400
      VAL|UC|EN|MISCV|ADDRV|PCC, MCACOD 0x0400 (internal timer /
      retirement watchdog, "three-strike"), MSCOD 0xE184
  mca.bank3.addr = mca.bank3.misc = arch_state.lip
                 = 0xffffffff9471bb3c        (kernel text)
  super queue: exactly one stuck transaction (cacheline 0xC898F)
  pmc_rst: gblrst_cause_0.pmc_fw=1, fw_gblrst_cause_0.scratch16=1,
      gblrst_req_0 = pmc_fw|syspwr_flr|pchpwr_flr

The LIP: given that KASLR slide is 2MB-aligned, (lip mod 2M) is an
invariant. Solving over System.map text symbols gives 14 candidates, of
which only one can be related:

  cpuidle_enter_state+0xbc

Disassembly:

  +0x73  call __x86_indirect_thunk_rax   ; target_state->enter()
   ...   sched_clock_idle_wakeup_event / local_clock_noinstr /
         sched_idle_set_state
  +0xb6  call *pv_ops...irq_enable       ; patched to STI at boot
  +0xbc  test %r14d,%r14d                ; <- LIP

So (my best guess) the core had already returned from MWAIT, executed
STI on the idle-exit path, and then stopped retiring instructions. The
retirement watchdog then fires, Punit reports CORE_TIMEOUT, and PMC
firmware pulls a global platform reset.

The question is whether it is something known or rather something
platform-specific that should be reported to Lenovo instead.

I can provide the raw BERT dump, and also I'd be happy to debug/test if
requested.

Best regards,
Polina.


