From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 07:11:00 +0200
Message-ID: <20100527071100.3a38bbac__43604.615974664$1274937114$gmane$org@schatten.dmk.lab>
References: <20100526171106.0e44a736@schatten.dmk.lab>
	<alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
	<20100526190204.5efe4d59@lxorguk.ukuu.org.uk>
	<20100526215606.2a747c61@schatten.dmk.lab>
	<AANLkTil3OdarNjeIuzWqM59x4ysFqJrMeiUZzceC_r7P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTil3OdarNjeIuzWqM59x4ysFqJrMeiUZzceC_r7P@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 22:03:37 +0200
Vitaly Wool <vitalywool@gmail.com> wrote:

> On Wed, May 26, 2010 at 9:56 PM, Florian Mickler <florian@mickler.org> wrote:
> 
> > Your approach definitely sounds better than the current solution.
> > What about mapping suspend blocker functionality later on, when this
> > interface exists, on to this new approach and deprecating it?
> 
> What about coming back after some while with the appropriate solution
> when it's ready instead of stubbornly pushing crap?
> 
> ~Vitaly

Because quite frankly, for a good part of linux users, suspend blockers
is already in the kernel. It's just an historical mistake that they are
not in the linux kernel's hosted on kernel.org. 
So why don't we do what we always do? Improve existing interfaces step
by step? 

Top Down approaches fail from time to time. Also it is not clear, that
that proposed interface works for the use cases. This has to be proven
by providing an implementation. 

Cheers,
Flo
