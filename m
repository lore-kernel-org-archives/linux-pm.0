From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 5 Jul 2007 17:03:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051658021.2557-100000@iolanthe.rowland.org>
References: <200707052240.05950.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707052240.05950.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Oliver Neukum wrote:

> > > I am not sure we ever want to do runtime suspend without remote wakeup.
> > 
> > You mean the user shouldn't be able to disable remote wakeup during a
> > runtime suspend?  But what if the user wants to put the device to sleep
> > with no possibility of wakeup?
> 
> Then the user will have to force suspend anyway and we can use the existing
> attribute. Two points:
> 
> 1. For hubs I don't think we should allow it

Why not?

> 2. The important distinction is not between system wide vs. device,
> but between forced sleep and the "best effort" runtime suspension
> in style of autosuspend. The latter needs remote wakeup under control
> of the driver.

The existing USB code already takes this into account.  For "best 
effort" runtime autosuspend, if the driver wants remote wakeup 
capability and the user has disabled it (or the device doesn't provide 
it) then the autosuspend will fail.  However "forced" runtime 
suspension will succeed regardless of whether wakeup is enabled.

Alan Stern
