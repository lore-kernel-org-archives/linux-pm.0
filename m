From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Sat, 9 May 2015 15:59:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4290667.ZqInAykFGS@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 8 May 2015, Rafael J. Wysocki wrote:

> My current view on that is that whether or not to do a sync() before suspending
> ultimately is a policy decision and should belong to user space as such (modulo
> the autosleep situation when user space may not know when the suspend is going
> to happen).
> 
> Moreover, user space is free to do as many sync()s before suspending as it
> wants to and the question here is whether or not the *kernel* should sync()
> in the suspend code path.
> 
> Since we pretty much can demonstrate that having just one sync() in there is
> not sufficient in general, should we put two of them in there?  Or just
> remove the existing one and leave it to user space entirely?

I don't know about the advantages of one sync over two.  But how about
adding a "syncs_before_suspend" (or just "syncs") sysfs attribute that
takes a small numeric value?  The default can be 0, and the user could
set it to 1 or 2 (or higher).

Alan Stern
