From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: PATCH [0/4] perf: clean-up of power events API
Date: Mon,  4 Oct 2010 17:20:57 +0200
Message-ID: <1286205661-24448-1-git-send-email-jean.pihet__33794.3655824803$1286205978$gmane$org@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vg
Cc: Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

Here is a re-spin of the patches after discussion.
It includes:
- clean-up of the API,
- a deprecation process for backward compatibility,
- support for x86 and OMAP processors,
- support for the following tracepoints: cpuidle, cpufreq,
   system suspend, clocks & power domains

ToDO:
- documentation of the new API (once the code is agreed on),
- cpu idle latency tracing not included


  [PATCH 1/4] perf: cleanup power events API
  [PATCH 2/4] perf: add OMAP support for the new power events
  [PATCH 3/4] perf: add calls to suspend trace point
  [PATCH 4/4] perf: provide a DEPRECTAED power trace API to user space
