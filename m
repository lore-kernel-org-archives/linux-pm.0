From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:34:18 +0100
Message-ID: <20100527223418.281a687f__23922.3559889526$1274995642$gmane$org@lxorguk.ukuu.org.uk>
References: <1274980420.27810.5557.camel@twins>
	<Pine.LNX.4.44L0.1005271327560.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271327560.3239-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 13:29:18 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 27 May 2010, Peter Zijlstra wrote:
> 
> > On Thu, 2010-05-27 at 13:04 -0400, Alan Stern wrote:
> > > 
> > > Does this mean you believe "echo mem >/sys/power/state" is bad and
> > > should be removed?  Or "echo disk >/sys/power/state"?  They pay no
> > > attention to latencies or other requirements. 
> > 
> > Those are a whole different beast, those are basically a quick-off
> > button like thing. Forced suspend is conceptually a very different beast
> > from power-saving a running system.
> 
> They may be different conceptually.  Nevertheless, Android uses forced 
> suspend as a form of power saving.  Until better mechanisms are in 
> place, it makes sense.

For them, not for Linux.

Several vendors have exciting kernel drivers that do things like binary
patch other modules. Until better mechanisms are in place it does *NOT*
make sense to merge such stuff.

I don't care what they do in their own tree (consenting adults in their
own home and all that) but what they do in the public tree is another
matter.

Alan
