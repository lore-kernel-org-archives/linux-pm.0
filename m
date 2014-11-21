From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] cpuidle: acpi: Remove TIME_INVALID flag from acpi
Date: Fri, 21 Nov 2014 10:29:51 +0100
Message-ID: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36021 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaKUJaB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 04:30:01 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so2061852wib.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2014 01:29:57 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org

The commit 8e92b6605d introduced the TIME_VALID flag for the C1 state
if this one is a mwait state assuming the interrupt will be enabled
before reading the end time of the idle state.

The changelog of this commit mention a potential problem with the menu
governor but not a real observation and I assume it described an old
code as the commit is from 2008.

I have been digging through the code and I didn't find any place where the
interrupts are enabled before reading the time. Moreover with the changes
in the meantime, we moved the time measurements in the cpuidle core as well
as the interrupts enabling making sure the time is measured before the
interrupt are enabled again in a single place.

Remove this test as the time measurement is always valid for this
state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 380b4b4..7afba40 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -985,8 +985,6 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		state->flags = 0;
 		switch (cx->type) {
 			case ACPI_STATE_C1:
-			if (cx->entry_method != ACPI_CSTATE_FFH)
-				state->flags |= CPUIDLE_FLAG_TIME_INVALID;
 
 			state->enter = acpi_idle_enter_c1;
 			state->enter_dead = acpi_idle_play_dead;
-- 
1.9.1

