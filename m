From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: QUESTION: How to fix race between .suspend routine and
	watchdog timer
Date: Sun, 28 Oct 2007 21:19:05 +0200
Message-ID: <200710282119.05266.maximlevitsky__6166.98385351828$1193599221$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0710271820240.2321-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710271820240.2321-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 28 October 2007 00:24:10 Alan Stern wrote:
> On Sat, 27 Oct 2007, Maxim Levitsky wrote:
> 
> > > Use del_timer_sync().  It guarantees that when it returns, the timer 
> > > will be stopped and the timer routine will no longer be running on any 
> > > CPU.
> > > 
> > Even if the timer re-enables itself, are you sure?
> 
> Last time I looked at the source code, that's what it did.  I'll look
> again...  Yep, it still does.  It checks to see if the timer routine is
> currently running; if so then it waits a little while and tries again.
> 
> Alan Stern
> 
> 

Thanks, a lot,
	Best regards,
		Maxim Levitsky
