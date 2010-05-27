From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 13:04:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271303190.3239-100000__2470.43026979572$1274980288$gmane$org@iolanthe.rowland.org>
References: <20100527162740.GA9625@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527162740.GA9625@nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Felipe Balbi wrote:

> On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern wrote:
> >If people don't mind, here is a greatly simplified summary of the
> >comments and objections I have seen so far on this thread:
> >
> >	The in-kernel suspend blocker implementation is okay, even
> >	beneficial.
> 
> I disagree here. I believe expressing that as QoS is much better. Let 
> the kernel decide which power state is better as long as I can say I 
> need 100us IRQ latency or 100ms wakeup latency.

Does this mean you believe "echo mem >/sys/power/state" is bad and
should be removed?  Or "echo disk >/sys/power/state"?  They pay no
attention to latencies or other requirements.

Alan Stern
