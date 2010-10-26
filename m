From: Thomas Renninger <trenn@suse.de>
Subject: Cleanup and fixes for power trace events
Date: Wed, 27 Oct 2010 01:43:21 +0200
Message-ID: <1288136605-10526-1-git-send-email-trenn__43916.6532284164$1288136683$gmane$org@suse.de>
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
To: arjan@linux.intel.com, jean.pihet@newoldbits.com, mingo@elte.hu, rjw@sisk.pl, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


[PATCH 1/4] PERF: Do not export power_frequency, but power_start event
[PATCH 2/4] PERF(kernel): Cleanup power events V3
[PATCH 3/4] PERF(userspace): Adjust perf timechart to the new power events V3
[PATCH 4/4] PERF: fix power:cpu_idle double end events
