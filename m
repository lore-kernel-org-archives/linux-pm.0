From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor
	register on resume
Date: Wed, 25 Jun 2008 22:17:26 +0200
Message-ID: <200806252217.27059.rjw__5436.86541864208$1214425274$gmane$org@sisk.pl>
References: <200806242303.49498.rjw@sisk.pl>
	<20080624214610.GC18679@elf.ucw.cz> <20080625170126.GA2482@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080625170126.GA2482@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 25 of June 2008, Ingo Molnar wrote:
> 
> * Pavel Machek <pavel@suse.cz> wrote:
> 
> > Acked-by: Pavel Machek <pavel@suse.cz>
> > 
> > If this could be sneaked into Ingo's tree for some automated testing, 
> > that would be good.
> 
> sure - i have applied it to tip/out-of-tree. I'm equally nervous about 
> this change - it affects every suspend+resume cycle that people do on 
> those boxes which are working just fine currently.
> 
> btw., it would get a lot more coverage on my test-systems if this commit 
> in tip/out-of-tree:
> 
> | commit 01259383c345d13b70efcc549439927ae64dc66d
> | Author: David Brownell <david-b@pacbell.net>
> | Date:   Fri May 16 10:12:36 2008 +0200
> |
> |     sleepy linux self-test
> 
> was upstream and if it was enabled more prominently, instead of hidden 
> behind the rather obscure condition of:
> 
>   config PM_TEST_SUSPEND
>         bool "Test suspend/resume and wakealarm during bootup"
>         depends on SUSPEND && PM_DEBUG && RTC_LIB=y
> 
> and even then it needs certain other config options related to RTC_LIB 
> to actually work during bootup.
> 
> As a result of all this obstruction, the automated testing i do, which 
> builds and boots more than 1 random kernel per minute, will only run 
> this self-test once every hour or so.
> 
> I dont mind if this option breaks boxes (that its purpose: it does the 
> same thing that a real suspend+resume does and suspend+resume frequently 
> breaks boxes), but right now it's all obscured so heavily which makes 
> automated testing a lot harder than it should be.
> 
> it would be wonderful if this excellent suspend+resume self-test was 
> upstream and was more prominent! :-)

I thought it was in linux-next, wasn't it?

Rafael
