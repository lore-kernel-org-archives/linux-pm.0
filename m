From: Bastien ROUCARIES <roucaries.bastien@gmail.com>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Tue, 19 Jan 2010 10:04:49 +0100
Message-ID: <195c7a901001190104x164381f9v4a58d1fce70b17b6__33519.8101158769$1263918363$gmane$org@mail.gmail.com>
References: <20100118110324.AE30.A69D9226@jp.fujitsu.com>
	<201001182155.09727.rjw@sisk.pl>
	<20100119101101.5F2E.A69D9226@jp.fujitsu.com>
	<1263871194.724.520.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1263871194.724.520.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 19, 2010 at 4:19 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2010-01-19 at 10:19 +0900, KOSAKI Motohiro wrote:
>> I think the race happen itself is bad. memory and I/O subsystem can't solve such race
>> elegantly. These doesn't know enough suspend state knowlege. I think the practical
>> solution is that higher level design prevent the race happen.
>>
>>
>> > My patch attempts to avoid these two problems as well as the problem with
>> > drivers using GFP_KERNEL allocations during suspend which I admit might be
>> > solved by reworking the drivers.
>>
>> Agreed. In this case, only drivers change can solve the issue.
>
> As I explained earlier, this is near to impossible since the allocations
> are too often burried deep down the call stack or simply because the
> driver doesn't know that we started suspending -another- driver...
>
> I don't think trying to solve those problems at the driver level is
> realistic to be honest. This is one of those things where we really just
> need to make allocators 'just work' from a driver perspective.

Instead of masking bit could we only check if incompatible flags are
used during suspend, and warm deeply. Call stack will be therefore
identified, and we could have some metrics about such problem.

It will be a debug option like lockdep but pretty low cost.

My 2 cents.

Bastien
