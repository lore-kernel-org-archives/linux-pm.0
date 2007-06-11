From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Remove prev_state from dev_pm_info
Date: Mon, 11 Jun 2007 10:14:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706111013220.11888-100000@iolanthe.rowland.org>
References: <200706110131.54904.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706110131.54904.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Jun 2007, Rafael J. Wysocki wrote:

> > Along the same lines, feature_removal_schedule.txt says that 
> > dev->power.power_state will be removed next month.  In preparation, 
> > you could consider removing the prev_state member now.  As far as I 
> > know, it isn't used for anything other than avoiding resume method 
> > calls to devices that were already suspended when a system sleep 
> > began.
> 
> Patch for that is appended.

It looks good.  The USB portion might generate a merge conflict because 
of other ongoing changes, but they will be easy to fix.

Alan Stern
