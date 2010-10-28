From: Thomas Renninger <trenn@suse.de>
Subject: Cleanup and enhance power trace events
Date: Thu, 28 Oct 2010 11:02:56 +0200
Message-ID: <1288256579-22957-1-git-send-email-trenn__44050.5278566436$1288256639$gmane$org@suse.de>
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
To: trenn@suse.de, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, jean.pihet@newoldbits.com, arjan@linux.intel.com, mingo
List-Id: linux-pm@vger.kernel.org

Tested with:
acpi_idle and intel_idle as cpuidle drivers.
also tested perf timechart userspace tool without the new interface
and it still works fine with the new kernel changes.

There are quite some issues with the balance of cpu_idle
enter/leave a sleep state, but this was the case already.
perf timechart handles double "leave idle" events gracefully (should
still get fixed up at some time).

The first patch makes intel_idle cpuidle driver tracable, even
if compiled as a module.

Ingo: Can you please push these into an approprate git tree/branch.

Thanks,

    Thomas
