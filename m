From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM: Changes related to wakeup events
Date: Fri, 3 Dec 2010 01:18:30 +0100
Message-ID: <201012030118.30603.rjw__41187.4187332161$1291336239$gmane$org@sisk.pl>
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
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following three patches change the way in which wakeup events are taken
into account by dpm_prepare() and dpm_suspend().

[1/3] - Prevent dpm_prepare() from aborting suspend if events_check_enabled is
        unset.

[2/3] - Replace pm_check_wakeup_events() with pm_wakeup_pending() to avoid
        confision with the return value.

[3/3] - Check pm_wakeup_pending() in device_suspend().

If there are no objections, I'm going to queue them up for 2.6.38.

Thanks,
Rafael
