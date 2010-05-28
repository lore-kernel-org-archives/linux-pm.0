From: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 15:51:58 -0400
Message-ID: <20100528195158.GA5910__14907.6933078051$1275076486$gmane$org@gibbs.hungrycats.org>
References: <AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com>
	<4BFFC5DF.5030504@nokia.com> <20100528133900.GG26177@thunk.org>
	<4BFFCFC7.7070302@nokia.com> <20100528142124.GA26733@srcf.ucam.org>
	<AANLkTilj6i7Qi-eh7e3WWeh4zxKALqr-0yhAvWKis52t@mail.gmail.com>
	<20100528160628.7c121dab@lxorguk.ukuu.org.uk>
	<AANLkTin3suKfGBSfiDj0n8ztY8UiHzr4af_Cr0SPOevY@mail.gmail.com>
	<20100528172713.GA7444@gibbs.hungrycats.org>
	<1275070580.1645.379.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275070580.1645.379.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Brian Swetland <swetland@google.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, tytso@mit.edu, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 08:16:20PM +0200, Peter Zijlstra wrote:
> On Fri, 2010-05-28 at 13:27 -0400, Zygo Blaxell wrote:
> > From my reading of this thread, there's a lot of overlap between
> > suspendblockers and constraints.  Many use cases are served equally
> > well with one or the other, 

Oops, I apparently meant "many use cases *of suspendblockers* are served
equally well with one or the other."

> If using suspend-blockers, 
> Please explain to me how:
> - I will avoid the cpu going into some idle state for which the wakeup
> latency is larger than my RT app fancies?

...though I'd think you could do that by holding a suspendblocker, thus
preventing the CPU from going into any idle state at all.

There's four likely outcomes, corresponding to inclusion or non-inclusion
of suspend blockers and PM constraints in the kernel.  Both could coexist
in the same kernel, since a suspend blocker can be trivially expressed as
"an extreme PM constraint with other non-constraint-related semantics."

It's the "other non-constraint-related semantics" that seem to be the
contentious issue.  What can a suspend blocker do that a PM resource
constraint cannot do?  If that set contains at least one useful use case,
then we need either suspend blockers, or some other thing that provides
for the use case.

Lots of people want PM constraints, and I haven't seen anyone suggest
there should *not* be PM constraints in the kernel some day.  I've seen
a few "working and useful PM constraints aren't going to happen any time
soon" statements, and several "there's lots of stuff you still can't do
with PM constraints or suspend blockers" statements, but those aren't
arguments *against* PM constraints or *for* suspend blockers.
