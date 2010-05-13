From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 11:17:56 -0700
Message-ID: <s2ga55d774e1005131117yd138c59bk54cc109401eb4a8d__1137.4577916742$1273774828$gmane$org@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<20100513121745.GA10749@srcf.ucam.org>
	<1273771990.19100.13.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1273771990.19100.13.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Linus Walleij <linus.walleij@ericsson.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 13, 2010 at 10:33 AM, Daniel Walker <dwalker@fifo99.com> wrote:
> On Thu, 2010-05-13 at 13:17 +0100, Matthew Garrett wrote:
>> On Wed, May 12, 2010 at 09:35:30PM -0600, Paul Walmsley wrote:
>> >
>> > Figuring out a different way to do this should not limit Android at all,
>> > since Google can do what other Linux distributions do and continue to
>> > patch opportunistic suspend/suspend-block calls into their kernels as
>> > needed to ship devices, while contributing towards a different solution to
>> > the problem.
>>
>> I basically agree, except that despite having a year to do so none of us
>> have come up with a different way that would actually work. Google have
>> done this work. Who's going to prove that there is actually a different
>> way to do this?
>
> We all feel the pain of inelegance right? I think it's clear that this
> system will not last (but there's no other immediate option) .. That
> doesn't mean we should reject it, but we need to be clear that this
> system will get replaced. So we should format the patches appropriately.
> To me the userspace aspect is a permanent change .. If we could drop
> that (or put it into debugfs) then it would make this a lot easy to
> accept as a stepping stone.

I'm in agreement on the first half of this -- from the Google/Android
point of view, if we can someday accomplish everything we need with
some different facility, we'll happily shift over to that.  That seems
like a normal operating mode for mainline -- new solutions arise,
drivers are migrated to those new solutions, old solutions fall to the
wayside.  We fully expect that the world will change over time and one
of our largest goals with trying to get work upstream is to reduce the
pain of those changes for everyone, while trying to get to "you can
build a kernel out of the box from mainline that Just Works with an
android userspace".

I'm not sure this necessitates using only debugfs for the userspace
interface.  A userspace interface is necessary to accomplish what
we're trying to do here, otherwise we have only half a solution, and
our hope is that it'd be a stable interface (as userspace interfaces
are supposed to be) for as long as its needed.  I could totally
imagine the userspace interface eventually becoming a no-op or
punching through to some other facility, depending on how this problem
is solved long-term in the ideal post-suspend-block future.

Brian
