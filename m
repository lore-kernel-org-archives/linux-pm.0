From: Sundar <sunder.svit@gmail.com>
Subject: runtime PM and autosuspend
Date: Fri, 10 Dec 2010 00:48:05 +0530
Message-ID: <AANLkTinzZiPzz2OQr_n_gy0f9qcAq02mu74Rd6npsYCK@mail.gmail.com>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Alan,

i want to clarify some of my doubts for the auto suspend PM run time.

The runtime PM documentation mentions the variable timer_autosuspends
indicating the core to carry out timer based suspends rather than a
normal suspend. For most of the devices, shouldn't I be using the
timer based suspends more? But a quick glance shows me that there isnt
a API to allow the user to explicitly set this mode. Or is it expected
to set this variable in my driver code to signal the PM core to
suspend my device based on a timer?

My interest stems from trying to implement the auto suspends for the
input layer which as discussed previously can be used in lieu of
custom sysfs switches to disable/enable input devices. My
understanding goes for like this:
1. Enable run time PM in the driver initialization.
2. Use pm_runtime_get() in the entry of the ISR to signal resource grab;
3. Use pm_runtime_put() whilst exiting the ISR to decrement usage
count. Once the usage count drops to zero, the PM core on the
expiration of the suspend timer will initiate the suspend. Is this
correct?

Also one more doubt: In order to be available for wakeup via a input
device, I cannot completely put the keypad controller in the lowest
possible state. Does this mean that my driver's suspend call back
would only be effective when I dont want to wakeup via the keypad and
thus can turn off the controller completely? Also, in such a auto
suspend timer initiated suspend, will the device interrupt be the sole
reason for triggering the resume()?

Thanx for the patience to read through the queries.

Cheers!

-- 
---------
The views expressed in this email are personal and do not necessarily
echo my employers'.
