From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 28 May 2010 06:42:55 -0700
Message-ID: <AANLkTimtBjrbtZDIP273kn4Xkhca-tq1bTet_MfmIvV9__13719.7956014008$1275054370$gmane$org@mail.gmail.com>
References: <20100505202826.GB7450@linux.intel.com>
	<Pine.LNX.4.44L0.1005051705200.1885-100000@iolanthe.rowland.org>
	<z2ta55d774e1005051437heb584584q6afca0b4b254d5d0@mail.gmail.com>
	<20100505234755.GI29604@atomide.com>
	<20100506134015.GA23426@srcf.ucam.org>
	<20100506170151.GA30928@atomide.com>
	<20100506170956.GA28104@srcf.ucam.org>
	<20100506171453.GC30928@atomide.com>
	<20100506172201.GA28578@srcf.ucam.org>
	<20100506173807.GD30928@atomide.com> <20100528132925.GA2677@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528132925.GA2677@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 6:29 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > > Why would you need to constantly try to suspend in that case?
>> >
>> > Because otherwise you're awake for longer than you need to be.
>>
>> If your system is idle and your hardware supports off-while-idle,
>> then that really does not matter. There's not much of a difference
>> in power savings, we're already talking over 10 days on batteries
>> with just off-while-idle on omaps.
>
> Makes me wish g1 was omap based... it looks like you have superior hw.

G1 will happily do 10 days idle (radio on) under typical network
conditions (roughly 4-5mA draw at the battery average in paging mode)
if you have data disabled and there's no reason for it to wake up,
process events, chat on the data network etc.  It'll go 25-30 days in
"airplane mode" (radio off) provided there are not excessive wakeups.

If you happen to be running a perfect userspace where every thread in
every process is blocked on something, it'll hit the exact same power
state out of idle.  If you have a less optimal userspace or random
third party nonoptimal apps, this becomes much harder, of course.
Which is why we do the wakelock thing.

OMAP does have a lot of nice auto-clock-down features compared to some
other SoCs, sometimes simplifying other parts of power management.

Brian
