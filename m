From: Thomas Garnier <thgarnie@google.com>
Subject: [PATCH v1 0/2] x86/power/64: Make KASLR memory randomization compatible with hibernation
Date: Mon,  1 Aug 2016 10:07:58 -0700
Message-ID: <1470071280-78706-1-git-send-email-thgarnie@google.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33559 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbcHARIm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 13:08:42 -0400
Received: by mail-pa0-f47.google.com with SMTP id b2so1866214pat.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2016 10:08:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Thomas Garnier <thgarnie@google.com>, Yinghai Lu <yinghai@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel-hardening@lists.openwall.com

***Background:
KASLR memory randomization for x86_64 was added when KASLR did not support hibernation. Now that it does, some changes are needed.

***Problems that needed solving:
Hibernation was failing on reboot with a GP fault when CONFIG_RANDOMIZE_MEMORY was enabled. Two issues were identified.

The original fault was due to a wrong physical address assigned to cr3. The problem was introduced with __PAGE_OFFSET becoming a global variable when randomized. The fix uses a define to use the glbobal or immediate value based on config settings.

The second isssue was that the temporary page table mapping did not support virtual addresses not aligned on PGD level. KASLR memory randomization will generated a random address aligned on PUD level. The fix correctly calculates the offset on all levels of the temporary page table.

***Parts:
 - 01/02: Support unaligned addresses (second issue)
 - 02/02: Fix __PAGE_OFFSET usage on assembly (first issue)

