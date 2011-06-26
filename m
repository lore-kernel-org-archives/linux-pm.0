From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM / Runtime: Documentation improvements
Date: Sun, 26 Jun 2011 22:57:10 +0200
Message-ID: <201106262257.10769.rjw@sisk.pl>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches improve the runtime PM documentation,
on top of the recent "PM: Fix up interactions between system
suspend/resume and runtime PM" series.

[1/2] - Fix documentation of pm_runtime_enable(), pm_runtime_disable()
        and add description of pm_runtime_barrier().

[2/2] - Consolidate the spelling of "runtime".

Thanks,
Rafael
