From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Question about behavier of the freezer
Date: Sun, 24 Jan 2010 21:42:11 +0200
Message-ID: <1264362131.7011.13.camel@maxim-laptop>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I know following things:

All kernel threads aren't freezable by default, thus are running while
suspend/resume is done. (Of course this is unless thread sleeps on a
lock, or when pm core enters atomic context)

Kernel thread can became freezable, and then it is frozen when it calls
try_to_freeze.

I also know that userspace program that is in TASK_UNINTERRUPTIBLE can't
be frozen, and breaks suspend.

Now what happens if userspace thread is TASK_RUNNING? Can it be
interrupted inside the kernel?

Or in other words, userspace thread can be interrupted to receive signal
while inside the kernel?

I think that signals are only delivered if userspace task in running in
user mode. If it is in TASK_INTERRUPTIBLE, then the task will be woken
up (this is corresponding wait function will return some predefined
error message, and then kernel code will try to return to userspace as
fast as possible. When task returns to userspace, right away the signal
handler is called.

Did I answer my own question?

Best regards,
Maxim Levitsky
