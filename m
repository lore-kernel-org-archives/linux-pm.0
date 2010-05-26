From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 10:38:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005261033440.1961-100000__44036.5788098008$1274884795$gmane$org@iolanthe.rowland.org>
References: <20100526151945.1b3813ac@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526151945.1b3813ac@schatten.dmk.lab>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010, Florian Mickler wrote:

> I don't think that the in-kernel suspend block is a bad idea. 
> 
> You could probably use the suspend-blockers unconditionally in the
> suspend framework to indicate if a suspend is possible or not.

That's not how it works.  Drivers aren't supposed to abort
unconditional suspend -- not without a really good reason (for example,
the device received a wakeup event before it was fully suspended).  In
short, suspends should be considered to be _always_ possible.

> Regardless of opportunistic suspend or not. This way, you don't have to
> try-and-fail on a suspend request and thus making suspending
> potentially more robust or allowing for a "suspend as soon as
> possible" semantic (which is probably a good idea, if you have to grab
> your laptop in a hurry to get away).

That's different.  Suspend blockers could block (not abort!) regular 
suspends, just as they do opportunistic suspends.

But why should they?  I mean, if userspace wants to initiate a suspend
that is capable of being blocked by a kernel suspend blocker, then all
it has to do is initiate an opportunistic suspend instead of a normal
suspend.

Alan Stern
