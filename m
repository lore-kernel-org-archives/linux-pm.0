From: yuankuiz@codeaurora.org
Subject: [PATCH] [PATCH] time: tick-sched: use bool for tick_stopped
Date: Tue, 10 Apr 2018 15:45:46 +0800
Message-ID: <9ee70560651fefffcc61949d8a37315d@codeaurora.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, fweisbec@gmail.com, peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

 From: John Zhao <yuankuiz@codeaurora.org>

Variable tick_stopped returned by tick_nohz_tick_stopped
can only be true / false values. Since the return type
of the tick_nohz_tick_stopped is also bool, variable
tick_stopped nice to have data type as bool in place of int.
Moreover, the executed instructions cost could be minimal
without potiential data type conversion.

Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
---
  kernel/time/tick-sched.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 6de959a..4d34309 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -48,8 +48,8 @@ struct tick_sched {
  	unsigned long			check_clocks;
  	enum tick_nohz_mode		nohz_mode;

+	bool				tick_stopped	: 1;
  	unsigned int			inidle		: 1;
-	unsigned int			tick_stopped	: 1;
  	unsigned int			idle_active	: 1;
  	unsigned int			do_timer_last	: 1;
  	unsigned int			got_idle_tick	: 1;
