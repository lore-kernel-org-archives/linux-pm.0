From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
	interrupt handlers
Date: Sun, 3 Oct 2010 00:06:33 +0200
Message-ID: <201010030006.33454.rjw__36976.3289265849$1286057373$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1010021004150.15874-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1010021004150.15874-100000@netrider.rowland.org>
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, October 02, 2010, Alan Stern wrote:
> On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
...
> > At the moment it suspends when the network cable is removed from the device
> > and the hack I mentioned is used during the resume after the cable has been
> > reinserted (it checks if the cable is still there and schedules suspend if not).
> 
> That does seem like a strange hack.  Instead of scheduling a suspend,
> why not simply do a suspend as soon as you learn that the cable has
> been removed again?  Is there a problem about the connection status
> bouncing?

I don't remember 100%, but ISTR there was a problem with that.

> > If we removed the immediate idle notification after a successful resume, it
> > might need to be reworked slightly.
> 
> My suggestion was that we remove the idle notification after a failed 
> suspend, not the notification after a successful resume.

And I said I was fine with that.

Rafael
