From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2 v2] sh-sci / PM: Fix problem with runtime PM
	callbacks run with interrupts off
Date: Sun, 21 Aug 2011 21:09:30 +0200
Message-ID: <201108212109.30399.rjw__4707.80957625738$1313954002$gmane$org@sisk.pl>
References: <201108202131.19479.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108202131.19479.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-sh@vger.kernel.org
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

> The sh-sci driver uses pm_runtime_get/put_sync() in such a way
> that they may be run with interrupts off and cause the (recently
> added) might_sleep_if() to trigger in rpm_suspend/resume().
> 
> To avoid that, it's necessary to set the SCI device's power.irq_safe
> flag to indicate that it's runtime PM callbacks may be executed with
> interrupts off safely.  However, the sh-sci driver needs to be able to
> clear that flag sometimes, so a new runtime PM helper for doing that
> is needed.

The previous version of this patchset was not very good as Alan pointed out,
so hopefully this one will be better.

[1/2] - Change PM subsys_data lock type into spinlock.
[2/2] - Make sh-sci use power.irq_safe to indicate that runtime PM callbacks
        may be run with interrupts off.

Thanks,
Rafael
