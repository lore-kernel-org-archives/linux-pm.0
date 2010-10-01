From: Thomas Renninger <trenn@suse.de>
Subject: Perf: Power events/tracepoints cleanups
Date: Fri,  1 Oct 2010 17:04:22 +0200
Message-ID: <1285945464-10884-1-git-send-email-trenn__36767.6798640334$1285945529$gmane$org@suse.de>
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
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, jean.pihet@ne
List-Id: linux-pm@vger.kernel.org

This is the outcome from the thread:
Subject: [PATCH] tracing, perf: add more power related events

-> The interfaces won't be fix. There may be a library at some time
   which may abstract versions or similar.

-> ARM people want to make use of several power event tracepoints and
   it came out they are wrongly defined, in a rather unusable way.
   Better fix and clean this up now, before more and more tools depend
   on them.

-> The perf userspace cleanups show that it's rather easy for userspace
   to adapt to the new trace ponts.

Ingo: This is against latest Linus master branch, can you push these if
      Jean is fine with them.

Thanks,

        Thomas
