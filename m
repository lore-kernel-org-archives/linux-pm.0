From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 15:35:18 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005271530240.3032__15113.4096472108$1274967375$gmane$org@localhost.localdomain>
References: <20100526171106.0e44a736@schatten.dmk.lab>
	<alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
	<20100526190204.5efe4d59@lxorguk.ukuu.org.uk>
	<20100526215606.2a747c61@schatten.dmk.lab>
	<AANLkTil3OdarNjeIuzWqM59x4ysFqJrMeiUZzceC_r7P@mail.gmail.com>
	<20100527071100.3a38bbac@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527071100.3a38bbac@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Florian Mickler wrote:

> On Wed, 26 May 2010 22:03:37 +0200
> Vitaly Wool <vitalywool@gmail.com> wrote:
> 
> > On Wed, May 26, 2010 at 9:56 PM, Florian Mickler <florian@mickler.org> wrote:
> > 
> > > Your approach definitely sounds better than the current solution.
> > > What about mapping suspend blocker functionality later on, when this
> > > interface exists, on to this new approach and deprecating it?
> > 
> > What about coming back after some while with the appropriate solution
> > when it's ready instead of stubbornly pushing crap?
> > 
> > ~Vitaly
> 
> Because quite frankly, for a good part of linux users, suspend blockers
> is already in the kernel. It's just an historical mistake that they are
> not in the linux kernel's hosted on kernel.org. 

No, it's not a historical mistake. It's a technical decision _NOT_ to
merge crap. If we would accept every crappy patch which gets shipped
in large quantities as a defacto part of the kernel we would have a
completely unmaintainable mess since years.

> So why don't we do what we always do? Improve existing interfaces step
> by step? 

Exactly, that's what we are going to do. We improve and extend
existing interfaces step by step, but not by creating a horrible and
unmaintainable mess in the frist place which we can never get rid of
anymore.

> Top Down approaches fail from time to time. Also it is not clear, that
> that proposed interface works for the use cases. This has to be proven
> by providing an implementation. 

Nobody prevents you to sit down and start with a prove of concept
implementation.

Thanks,

	tglx
