From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpuidle: fix description of exit latency in cpuidle.rst
Date: Tue, 22 Jan 2019 09:06:44 -0500
Message-ID: <20190122140644.25535-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, corbet@lwn.net
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Exit latency is the time from exiting the idle state to execute
the first instruction. This place may be a typo , so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/admin-guide/pm/cpuidle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 106379e2619f..3ca2ca60ff91 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -134,7 +134,7 @@ substantial), in order to save more energy than it would save by entering one of
 the shallower idle states instead.  [The "depth" of an idle state roughly
 corresponds to the power drawn by the processor in that state.]  The exit
 latency, in turn, is the maximum time it will take a CPU asking the processor
-hardware to enter an idle state to start executing the first instruction after a
+hardware to exit an idle state to start executing the first instruction after a
 wakeup from that state.  Note that in general the exit latency also must cover
 the time needed to enter the given state in case the wakeup occurs when the
 hardware is entering it and it must be entered completely to be exited in an
-- 
2.17.0
