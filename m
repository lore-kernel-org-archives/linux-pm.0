From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 19:02:04 +0100
Message-ID: <20100526190204.5efe4d59__48060.7672514909$1274896517$gmane$org@lxorguk.ukuu.org.uk>
References: <20100526171106.0e44a736@schatten.dmk.lab>
	<alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, felipe.balbi@nokia.com, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> The power efficiency of a mobile device is depending on a sane overall
> software stack and not on the ability to mitigate crappy software in
> some obscure way which is prone to malfunction and disappoint users.

Even if you believe the kernel should be containing junk the model that
works and is used for everything else is resource management. Not giving
various tasks the ability to override rules, otherwise you end up needing
suspend blocker blockers next week.

A model based on the idea that a task can set its desired wakeup
behaviour *subject to hard limits* (ie soft/hard process wakeup) works
both for the sane system where its elegantly managing hard RT, and for
the crud where you sandbox it to stop it making a nasty mess.

Do we even need a syscall or will adding RLIMIT_WAKEUP or similar do the
trick ?

Alan
