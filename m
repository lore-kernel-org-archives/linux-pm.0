From: Don Zickus <dzickus@redhat.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector
	bug)
Date: Wed, 2 Jun 2010 14:44:59 -0400
Message-ID: <20100602184459.GA15159__31792.4641109586$1275504580$gmane$org@redhat.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com>
	<4C051D44.7040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C051D44.7040203@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 01, 2010 at 04:46:28PM +0200, Jiri Slaby wrote:
> On 06/01/2010 03:50 PM, Don Zickus wrote:
> > On Mon, May 31, 2010 at 04:22:00PM +0200, Jiri Slaby wrote:
> >> Hi,
> >>
> >> with -next I get the following errors while trying to hibernate in
> >> qemu-kvm after the image is stored on disk:
> > 
> > Is this the host that is hibernating or the guest?
> 
> Guest.
> 
> > KVM guests don't emulate the performance counters, so the nmi piece
> > shouldn't be functioning and the soft lockup piece just sits on top of an
> > hrtimer, so off the top of my head it is hard to imagine it intefering
> > with a sata driver.
> > 
> > I'll need your whole boot up log to see how the lockup detector
> > initialized itself.

Ok, so I found out what is causing the problem, not entirely sure why or
what the right fix is, but this patch should do the trick.

This is probably one of those fixing the symptoms but not the problem patch,
but I don't know enough about suspend/resume to understand what the real
problem is.

---->SNIP<---------------------
[lockup detector] don't return NOTIFY_BAD when cpu goes online for suspend

KVM guests do not support performance counter emulation, so if the nmi
watchdog piece is compiled in, it will always fail during boot.  The
failure returns NOTIFY_BAD when the cpu goes online in the cpu notifier
callback.  Returning NOTIFY_BAD causes hibernation to do really bad
things, so avoid doing that.

The cpu failure shouldn't be a critical failure anyway, so returning
NOTIFY_BAD was probably overstating things.

Signed-off-by: Don Zickus <dzickus@redhat.com>


diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6b7fad8..fda9770 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -550,8 +550,7 @@ cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 		break;
 	case CPU_ONLINE:
 	case CPU_ONLINE_FROZEN:
-		if (watchdog_enable(hotcpu))
-			return NOTIFY_BAD;
+		watchdog_enable(hotcpu)
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
