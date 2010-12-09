From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM and autosuspend
Date: Thu, 9 Dec 2010 16:38:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012091610360.4339-100000@netrider.rowland.org>
References: <AANLkTinzZiPzz2OQr_n_gy0f9qcAq02mu74Rd6npsYCK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinzZiPzz2OQr_n_gy0f9qcAq02mu74Rd6npsYCK@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sundar <sunder.svit@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 10 Dec 2010, Sundar wrote:

> Hi Alan,
> 
> i want to clarify some of my doubts for the auto suspend PM run time.
> 
> The runtime PM documentation mentions the variable timer_autosuspends
> indicating the core to carry out timer based suspends rather than a
> normal suspend.

That's not quite right.  timer_autosuspends tells the core to carry out
an autosuspend when the timer expires rather than a regular runtime
suspend.  The difference is that with an autosuspend, the core checks
whether the entire autosuspend_delay has elapsed since the last_busy
time; if it hasn't then the timer is restarted.

>  For most of the devices, shouldn't I be using the
> timer based suspends more?

There are two kinds of timer-based suspends, which you use by calling
pm_runtime_schedule_suspend() or pm_runtime_autosuspend() (or one of
the various get/put/sync/etc. variants).  You should use whichever is
best for your purpose.

>  But a quick glance shows me that there isnt
> a API to allow the user to explicitly set this mode. Or is it expected
> to set this variable in my driver code to signal the PM core to
> suspend my device based on a timer?

Your driver should not touch timer_autosuspends.  Use only the
documented calls for runtime PM.

> My interest stems from trying to implement the auto suspends for the
> input layer which as discussed previously can be used in lieu of
> custom sysfs switches to disable/enable input devices. My
> understanding goes for like this:
> 1. Enable run time PM in the driver initialization.
> 2. Use pm_runtime_get() in the entry of the ISR to signal resource grab;
> 3. Use pm_runtime_put() whilst exiting the ISR to decrement usage
> count. Once the usage count drops to zero, the PM core on the
> expiration of the suspend timer will initiate the suspend. Is this
> correct?

No.  If you want the device to suspend after a delay then you have to 
call pm_runtime_put_autosuspend().  Have you read the descriptions of 
these functions in Documentation/power/runtime_pm.txt?

> Also one more doubt: In order to be available for wakeup via a input
> device, I cannot completely put the keypad controller in the lowest
> possible state. Does this mean that my driver's suspend call back
> would only be effective when I dont want to wakeup via the keypad and
> thus can turn off the controller completely?

Well, it would be _completely_ effective only if wakeup isn't required.  
If wakeup is required then the suspend routine might put the keypad 
controller in an intermediate power state, so it could be partially 
effective.  But if the controller must be at full power in order to 
generate wakeup signals then yes, your suspend routine wouldn't be able 
to do anything if wakeup is required.

>  Also, in such a auto
> suspend timer initiated suspend, will the device interrupt be the sole
> reason for triggering the resume()?

There are a few places, not many, where the kernel will resume a
device without the driver asking.  For example, when the entire system
wakes up from suspend-to-RAM, the keypad controller will be resumed
even without a device interrupt.  But usually a runtime resume occurs 
only when the driver asks for it.

Alan Stern
