From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 14:53:16 +0200
Message-ID: <1274878396.27810.334.camel__24705.9502792128$1274878466$gmane$org@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<AANLkTiksR3YozbBH0Iv5kNsQkEGKCH1APCvn_s6LkjV9@mail.gmail.com>
	<1274868593.5882.5185.camel@twins>
	<AANLkTinuxCbeBmxIR7b_1OtrqQYJCamiDZJbnNTih1Fb@mail.gmail.com>
	<1274869966.5882.5262.camel@twins>
	<AANLkTikRMBkoFxgaKsxMJ2lOMomTXpiHJDk3rVt0EtwM@mail.gmail.com>
	<1274870970.5882.5311.camel@twins>
	<AANLkTinlxsokwralwRAL9_YRQ7-SZUSvrGHTlRISA9bC@mail.gmail.com>
	<1274872357.27810.16.camel@twins>
	<20100526133510.6e9de670@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526133510.6e9de670@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-05-26 at 13:35 +0100, Alan Cox wrote:

> This is an area where machines are improving and where the ability to
> do stuff like autosuspend, the technology like the OLPC screen and so on
> create an incentive for the BIOS and platform people to improve their
> bits of it.

But do you think its a sensible thing to do? Explicitly not running
runnable tasks just sounds wrong. Also, at the extreme end, super fast
suspend is basically an efficient idle mode.

Why would the code holding suspend blockers be any more or less
important than any other piece of runnable code.

In fact, having runnable but non suspend blocking tasks around will
delay the completion of the suspend blocker, so will we start removing
those?

This whole thing introduces an artificial segregation of code. My 'cool'
code is more important than your 'uncool' code. Without a clear
definition of what makes code cool or not.

> > So yes, I do think merging this will delay the effort in fixing
> > userspace, simply because all the mobile/embedded folks don't care about
> > it anymore.
> 
> The mobile space probably doesn't care too much about many of the large
> bloated desktop apps anyway and traditional embedded generally has a very
> small fixed application set where the optimise both halves of the system
> together.

Sure, but at least we share the kernel. It was said that the kernel
generates too many wakeups (and iwlagn certainly is the top most waker
on my laptop). Improvements to the kernel will benefit all, regardless
of whatever userspace we run.
