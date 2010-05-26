From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 21:56:06 +0200
Message-ID: <20100526215606.2a747c61__1887.01334777779$1274916079$gmane$org@schatten.dmk.lab>
References: <20100526171106.0e44a736@schatten.dmk.lab>
	<alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
	<20100526190204.5efe4d59@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526190204.5efe4d59@lxorguk.ukuu.org.uk>
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
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 19:02:04 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > The power efficiency of a mobile device is depending on a sane overall
> > software stack and not on the ability to mitigate crappy software in
> > some obscure way which is prone to malfunction and disappoint users.
> 
> Even if you believe the kernel should be containing junk the model that
> works and is used for everything else is resource management. Not giving
> various tasks the ability to override rules, otherwise you end up needing
> suspend blocker blockers next week.
> 
> A model based on the idea that a task can set its desired wakeup
> behaviour *subject to hard limits* (ie soft/hard process wakeup) works
> both for the sane system where its elegantly managing hard RT, and for
> the crud where you sandbox it to stop it making a nasty mess.
> 
> Do we even need a syscall or will adding RLIMIT_WAKEUP or similar do the
> trick ?
> 
> Alan

Your approach definitely sounds better than the current solution. 
What about mapping suspend blocker functionality later on, when this
interface exists, on to this new approach and deprecating it?

Cheers,
Flo
