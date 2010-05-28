From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 07:29:27 -0700
Message-ID: <AANLkTilj6i7Qi-eh7e3WWeh4zxKALqr-0yhAvWKis52t__45613.875569734$1275057073$gmane$org@mail.gmail.com>
References: <20100527223605.GB11364@srcf.ucam.org>
	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	<20100528043114.GC26177@thunk.org>
	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<20100528114123.GA22947@srcf.ucam.org> <4BFFB681.1000105@nokia.com>
	<AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com>
	<4BFFC5DF.5030504@nokia.com> <20100528133900.GG26177@thunk.org>
	<4BFFCFC7.7070302@nokia.com> <20100528142124.GA26733@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528142124.GA26733@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 7:21 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, May 28, 2010 at 05:14:31PM +0300, Igor Stoppa wrote:
>
>> I have seen very good proposals for saner solutions.
>>
>> Is that progress?
>
> The proposals so far involve either redefining the problem space or
> being inherently racey. It may be that we can redefine the problem space
> in such a way that everyone's happy, but it's not possible to do so by
> fiat.

I think the suggestion that has the closet fit with what we're trying
to accomplish is Ingo's (or perhaps Ingo's explanation of Alan's):
http://lkml.org/lkml/2010/5/28/106 where it's implemented as a
constraint of some sort.

Arve points out that qos constraint objects could work (but not if
specifically tied to apps): http://lkml.org/lkml/2010/5/28/120 though
he suggests that "latency" constraints don't represent this as well as
"state" constraints.

Though if you look at it that way, then suspend_blockers become qos
constraint objects, but their implementation and usage remain pretty
much the same as we have now, which does not address Alan's concern
regarding code turning up in drivers, etc.  I'm not sure how you can
solve this problem (avoiding races around entering/exiting the suspend
or suspend-like state) without having a means for drivers to prevent
entry to that state.

I need to think more about the cgroups approach, but I'm pretty sure
it still suffers from wakeup race situations, and due to the
complexity of userspace (at least ours), I suspect it would risk
livelock/deadlock/priority-inversion style issues due to interaction
between different processes in different groups.

Brian
