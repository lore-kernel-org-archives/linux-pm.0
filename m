From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
 interrupt handlers
Date: Sun, 3 Oct 2010 11:52:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010031144420.26676-100000__40416.3731997416$1286121171$gmane$org@netrider.rowland.org>
References: <201010030006.33454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010030006.33454.rjw@sisk.pl>
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 3 Oct 2010, Rafael J. Wysocki wrote:

> On Saturday, October 02, 2010, Alan Stern wrote:
> > On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
> ...
> > > At the moment it suspends when the network cable is removed from the device
> > > and the hack I mentioned is used during the resume after the cable has been
> > > reinserted (it checks if the cable is still there and schedules suspend if not).
> > 
> > That does seem like a strange hack.  Instead of scheduling a suspend,
> > why not simply do a suspend as soon as you learn that the cable has
> > been removed again?  Is there a problem about the connection status
> > bouncing?
> 
> I don't remember 100%, but ISTR there was a problem with that.

Regardless, it seems like the sort of thing autosuspend would handle
easily with no need for idle notifications.  Just call
pm_runtime_mark_last_busy when the cable is plugged in, then do the
runtime resume, and then call pm_request_autosuspend.  The check for 
the cable being disconnected would have to move from the runtime_idle 
callback to the runtime_suspend callback -- but then the runtime_idle 
callback wouldn't have to be present at all.

Alan Stern

P.S.: Kevin, it looks like your name somehow got removed from the CC 
list on my last message.  This was odd because the message contained a 
question directed at you.  In case you didn't receive it, here's a 
link:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-October/028908.html
