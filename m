From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: adjust comment regarding default wakeup
	policy
Date: Mon, 24 May 2010 16:09:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005241608390.1698-100000@iolanthe.rowland.org>
References: <201005242058.53092.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005242058.53092.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 May 2010, Rafael J. Wysocki wrote:

> On Friday 21 May 2010, Alan Stern wrote:
> > This patch (as1381) updates a comment describing the kernel's policy
> > toward enabling wakeup by default.
> > 
> > It also makes device_set_wakeup_capable() actually do something when
> > CONFIG_PM isn't enabled.  It's not clear this is necessary; however if
> > it isn't then device_init_wakeup() and device_can_wakeup() should also
> > be do-nothing routines.  Furthermore, I don't expect this change to
> > have any noticeable effect -- but if it does then clearly the old
> > behavior was wrong.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > CC: David Brownell <david-b@pacbell.net>
> 
> OK by me.
> 
> Do you want me to push that in this merge window?

No, it can wait for the window after this one.

Alan Stern
