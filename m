From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 08:52:49 -0400
Message-ID: <20100812125248.GA2763__2.51966198465681$1281617753$gmane$org@thunk.org>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 03:28:01PM +0300, Felipe Contreras wrote:
> 
> The question is why are we adding a user-space API that:
>  1) no user-space beside Android has expresses interest in implementing
>  2) is dubious whether the benefits are worth the pain for non-Android
> user-space
>  3) will become less and less attractive as dynamic PM gets closer to
> the sweet-spot, and then surpass it
>  4) Android can keep in a separate tree until it's clear in the linux
> community that it's useful (if it ever happens)

So, Felipe,

Do you believe you speak for all of LKML?

Are you willing to tell ZDNet and the Slashdot fanboys that it's OK
for Suspend blockers to live in a separate tree, and it's not a case
of OMG!  Google is forking the kernel?

If you could speak out a passionately on those forums as you have
here, that would be great.

						- Ted
