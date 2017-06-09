From: Mason <slash.tmp@free.fr>
Subject: Drivers taking different actions depending on sleep state
Date: Fri, 9 Jun 2017 17:20:18 +0200
Message-ID: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:60695 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbdFIPUl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 11:20:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>

Hello,

I read the "Sleep States" documentation:
https://www.kernel.org/doc/Documentation/power/states.txt

It mentions /sys/power/mem_sleep but I don't have that in 4.9
# ll /sys/power/
-rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_async
-rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_freeze_timeout
-rw-r--r--    1 root     root          4096 Jan  1 00:31 state
-rw-r--r--    1 root     root          4096 Jan  1 00:31 wakeup_count

# cat /sys/power/state 
freeze mem

Currently my platform's "mem" is a true suspend-to-RAM trigger,
where drivers are supposed to save their state (register values
will be lost), then Linux hands control over to firmware which
enables RAM self-refresh and powers the chip down. When the system
resumes, drivers restore their state from their copy in memory.

One driver is responsible for loading/unloading microcode running
on the DSPs. This operation is required only when powering down
the chip, but it should be avoided for "low-latency" sleeps.

The problem is that, if I understand correctly, drivers have no way
of knowing which sleep state is being entered/exited?

How can I have the microcode driver take different decisions
based on the sleep state?

Regards.
