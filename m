From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: s2disk hang update
Date: Wed, 24 Feb 2010 20:19:32 +0000
Message-ID: <9b2b86521002241219v648458c1gad1c18b0c3e7ca83__30644.9052565315$1267043222$gmane$org@mail.gmail.com>
References: <9b2b86521001020703v23152d0cy3ba2c08df88c0a79@mail.gmail.com>
	<201002222017.55588.rjw@sisk.pl>
	<9b2b86521002230624g20661564mc35093ee0423ff77@mail.gmail.com>
	<201002232213.56455.rjw@sisk.pl>
	<20100224102037.2cca4f83.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100224102037.2cca4f83.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, hugh.dickins@tiscali.co.uk, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2/24/10, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> On Tue, 23 Feb 2010 22:13:56 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
>> Well, it still looks like we're waiting for create_workqueue_thread() to
>> return, which probably is trying to allocate memory for the thread
>> structure.
>>
>> My guess is that the preallocated memory pages freed by
>> free_unnecessary_pages() go into a place from where they cannot be taken
>> for
>> subsequent NOIO allocations.  I have no idea why that happens though.
>>
>> To test that theory you can try to change GFP_IOFS to GFP_KERNEL in the
>> calls to clear_gfp_allowed_mask() in kernel/power/hibernate.c (and in
>> kernel/power/suspend.c for completness).
>>
>
> If allocation of kernel threads for stop_machine_run() is the problem,
>
> What happens when
> 1. use CONIFG_4KSTACK

Interesting question.  4KSTACK doesn't stop it though; it hangs in the
same place.

> or
> 2. make use of stop_machine_create(), stop_machine_destroy().
>    A new interface added by this commit.
>   http://git.kernel.org/?p=linux/kernel/git/torvalds/
> linux-2.6.git;a=commit;h=9ea09af3bd3090e8349ca2899ca2011bd94cda85
>    You can do no-fail stop_machine_run().
>
> Thanks,
> -Kame

Since this is a uni-processor machine that would make it a single 4K
allocation.  AIUI this is supposed to be ok.  The hibernation code
tries to make sure there is over 1000x that much free RAM (ish), in
anticipation of this sort of requirement.

There appear to be some deficiencies in the way this allowance works,
which have recently been exposed.  And unfortunately the allocation
hangs instead of failing, so we're in unclean shutdown territory.

I have three test scenarios at the moment.  I've tested two patches
which appear to fix the common cases, but there's still a third test
scenario to figure out.  (Repeated hibernation attempts with
insufficient swap - encountered during real-world use, believe it or
not).

Alan
