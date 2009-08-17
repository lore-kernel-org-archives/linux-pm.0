From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 17 Aug 2009 17:50:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908171749050.10102-100000@netrider.rowland.org>
References: <200908172321.38476.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908172321.38476.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, 17 Aug 2009, Rafael J. Wysocki wrote:

> On Monday 17 August 2009, Alan Stern wrote:
> > On Mon, 17 Aug 2009, Rafael J. Wysocki wrote:
> ...
> > 
> > (That's from the serial log; it wasn't on the screen.)
> > 
> > It appears that some part of the resume messed up the VT console
> > driver.
> 
> Hm, perhaps the no_console_suspend thing doesn't really work on this machine?

It _used_ to work.  I hadn't tried it for a while before this.

Alan Stern
