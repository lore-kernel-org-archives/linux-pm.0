From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5] PM / Core: suspend_again callback for
	suspend_ops.
Date: Mon, 6 Jun 2011 12:29:10 +0200
Message-ID: <20110606102909.GC5820__17564.7264965393$1307356219$gmane$org@atrey.karlin.mff.cuni.cz>
References: <1306999978-4663-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1306999978-4663-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> A system or a device may need to control suspend/wakeup events. It may
> want to wakeup the system after a predefined amount of time or at a
> predefined event decided while entering suspend for polling or delayed
> work. Then, it may want to enter suspend again if its predefined wakeup
> condition is the only wakeup reason and there is no outstanding events;
> thus, it does not wakeup the userspace unnecessary or unnecessary
> devices and keeps suspended as long as possible (saving the power).
> 
> Enabling a system to wakeup after a specified time can be easily
> achieved by using RTC. However, to enter suspend again immediately
> without invoking userland and unrelated devices, we need additional
> features in the suspend framework.
> 
> Such need comes from:
> 
> 1. Monitoring a critical device status without interrupts that can
> wakeup the system. (in-suspend polling)
>  An example is ambient temperature monitoring that needs to shut down
> the system or a specific device function if it is too hot or cold. The
> temperature of a specific device may be needed to be monitored as well;
> e.g., a charger monitors battery temperature in order to stop charging
> if overheated.
> 
> 2. Execute critical "delayed work" at suspend.
>  A driver or a system/board may have a delayed work (or any similar
> things) that it wants to execute at the requested time.
>  For example, some chargers want to check the battery voltage some
> time (e.g., 30 seconds) after the battery is fully charged and the
> charger has stopped. Then, the charger restarts charging if the voltage
> has dropped more than a threshold, which is smaller than "restart-charger"
> voltage, which is a threshold to restart charging regardless of the
> time passed.
> 
> This patch allows to add "suspend_again" callback at struct
> platform_suspend_ops and let the "suspend_again" callback return true if
> the system is required to enter suspend again after the current instance
> of wakeup. Device-wise suspend_again implemented at dev_pm_ops or
> syscore is not done because: a) suspend_again feature is usually under
> platform-wise decision and controls the behavior of the whole platform
> and b) There are very limited devices related to the usage cases of
> suspend_again; chargers and temperature sensors are mentioned so far.
> 
> With suspend_again callback registered at struct platform_suspend_ops
> suspend_ops in kernel/power/suspend.c with suspend_set_ops by the
> platform, the suspend framework tries to enter suspend again by
> looping suspend_enter() if suspend_again has returned true and there has
> been no errors in the suspending sequence or pending wakeups (by
> pm_wakeup_pending).
> 
> Tested at Exynos4-NURI.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

ACK.
