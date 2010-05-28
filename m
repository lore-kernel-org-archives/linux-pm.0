From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 11:14:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005281110340.1939-100000__35890.7895548784$1275059775$gmane$org@iolanthe.rowland.org>
References: <1275058794.27810.9571.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275058794.27810.9571.camel@twins>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010, Peter Zijlstra wrote:

> It seems most of the problems the suspend-blockers are trying to solve
> are due to the fact of not running runnable tasks.

That is only partially correct.

If Android were using idle-time PM and not forced suspend, then yes -- 
not running runnable tasks would be a big problem.

But as it stands, with forced suspend the problem is to avoid delays in
processing wakeup events.  That's what suspend blockers are meant to
solve.  The same problem would occur with idle-time PM if you don't run
all runnable tasks, and it would need a similar solution.

Alan Stern
