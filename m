From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/4] sched / idle: Reduce the number of branches in the idle loop
Date: Mon, 04 May 2015 15:54:43 +0200
Message-ID: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The "reflect" variable that had to be added to cpuidle_idle_call() to fix a
regression during the 4.0 cycle has bothered me a bit since then and guess
what?  It is not necessary.

After the last regression fix related to tick_broadcast_exit() I realized
that it should be possible to eliminate this variable by splitting
cpuidle_idle_call() into smaller routines and reordering the code in
question which is done by this patch series.

It also gets rid of one more redundant check while at it.

[1/4] Move the default idle call code into a separate function.
[2/4] Make cpuidle_reflect() check the sign of its index arg.
[3/4] Eliminate the "reflect" check from cpuidle_idle_call().
[4/4] Eliminate a redundant check of the cpuidle_enter() return value.

All on top of 4.1-rc2.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
