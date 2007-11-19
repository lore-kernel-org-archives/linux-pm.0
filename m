From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: apm emulation driver broken ?
Date: Mon, 19 Nov 2007 14:05:04 +0100
Message-ID: <47418A00.1000704__30002.2636926316$1195477705$gmane$org@gmail.com>
References: <cda58cb80711160706l2cfac2b1p81c7a1090f228f2e@mail.gmail.com>
	<200711171346.51363.rjw@sisk.pl> <4740992D.9030906@gmail.com>
	<200711182322.41354.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711182322.41354.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Sunday, 18 of November 2007, Franck Bui-Huu wrote:
>> Rafael J. Wysocki wrote:
>> See the call to wait_even() made by apm_ioctl(). If any processes
>> run this, it will prevent the system to suspend...
> 
> True, but does it actually happen in practice?
> 

when several processes are waiting for a suspend event.

> 
> At this point the second branch of the "if (as->suspend_state == SUSPEND_READ)"
> can be fixed by replacing wait_event_interruptible() with
> wait_event_freezable(), 

yes

> but the fix for the first branch depends on whether or
> not the wait_event() is really necessary.

As I said I don't know. It's probably time to put some people
on CC but don't know who though.

> 
> If it can be replaced with an interruptible sleep, we can use
> wait_event_freezable() in this case too.  Otherwise, the only woking fix would
> be to reintroduce the PF_NOFREEZE in there.

BTW, why not raising PF_NOFREEZE in wait_event(), so thread sleeping
in UNINTERRUPTIBLE state won't prevent suspend to happen ?


		Franck
