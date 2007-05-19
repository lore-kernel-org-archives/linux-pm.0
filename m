From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: (fwd) empty /sys/power/state?
Date: Sat, 19 May 2007 17:15:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705191714070.32062-100000@netrider.rowland.org>
References: <464F5625.9020905@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464F5625.9020905@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 19 May 2007, Stefan Richter wrote:

> Maybe linux-pm is the more appropriate list for this question:
> 
> I wrote at suspend-devel@lists.sourceforge.net:
> > What's wrong here?
> > 
> > # cat /sys/power/state
> > # echo mem > /sys/power/state
> > -su: echo: write error: No such device

> Thanks for advice,

No doubt other people will be able to give better answers than I.  However 
an important first step is to provide the dmesg log showing what happened 
when the attempted suspend failed.

Alan Stern
