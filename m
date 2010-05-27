From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 15:19:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271517170.3239-100000__17052.7718415999$1274988597$gmane$org@iolanthe.rowland.org>
References: <1274983363.27810.5749.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274983363.27810.5749.camel@twins>
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
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Peter Zijlstra wrote:

> I still don't see how blocking applications will cause missed wakeups in
> anything but a buggy application at worst, and even those will
> eventually get the event when they unblock.
> 
> What seems to be the confusion?

During forced suspend, applications are block because they are frozen.

When an event occurs, the application is notified somehow.  But it 
can't respond because it is frozen.  Hence the event remains sitting in 
a kernel queue and the system goes ahead and suspends anyway.  The 
application doesn't get thawed until the system wakes up at some 
indefinite time in the future.

Alan Stern
