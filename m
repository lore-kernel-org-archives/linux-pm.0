From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 15:26:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005271519460.3032__19782.3704722852$1274966990$gmane$org@localhost.localdomain>
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
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010, Alan Cox wrote:

> > The power efficiency of a mobile device is depending on a sane overall
> > software stack and not on the ability to mitigate crappy software in
> > some obscure way which is prone to malfunction and disappoint users.
> 
> Even if you believe the kernel should be containing junk the model that
> works and is used for everything else is resource management. Not giving
> various tasks the ability to override rules, otherwise you end up needing
> suspend blocker blockers next week.

We definitely will need them when we want to optimize the kernel
resource management on a QoS based scheme, which is the only sensible
way to go IMNSHO.

> A model based on the idea that a task can set its desired wakeup
> behaviour *subject to hard limits* (ie soft/hard process wakeup) works
> both for the sane system where its elegantly managing hard RT, and for
> the crud where you sandbox it to stop it making a nasty mess.

Right, the base system can set sensible defaults for "verified" apps,
which will work most of the time except for those which have special
requirements and need a skilled coder anyway. And for the sandbox crud
the sensible default can be "very long time" and allow the kernel to
ignore them at will.

> Do we even need a syscall or will adding RLIMIT_WAKEUP or similar do the
> trick ?

That might be a good starting point.

Thanks,

	tglx
