From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 15:33:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707031529130.7671-100000@iolanthe.rowland.org>
References: <20070703170233.GA25129@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703170233.GA25129@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Jul 2007, Matthew Garrett wrote:

> On Tue, Jul 03, 2007 at 12:57:17PM -0400, Alan Stern wrote:
> > On Tue, 3 Jul 2007, Matthew Garrett wrote:
> > > On Tue, Jul 03, 2007 at 12:03:33PM -0400, Alan Stern wrote:
> > > > Quite apart from the sync() matter, _any_ synchronous call to a FUSE 
> > > > filesystem during STR will cause trouble.  Even if the user task 
> > > > implementing the filesystem isn't frozen, when it tries to carry out 
> > > > some I/O to a suspended device it will either:
> > > > 
> > > > 	block until the system wakes up, or
> > > 
> > > For the suspend to RAM case, that sounds absolutely fine.
> > 
> > It's not so good when your suspend process has to wait for the call to 
> > complete!
> 
> Why would it have to? Sorry, I suspect I'm missing something obvious 
> here.

Well, the sys_sync() that caused your original problem did exactly 
that.  It's the reason you get deadlocks, right?

I agree that in general the suspend process should not have to wait for 
a userspace callback to complete.  Indeed, there's no particular 
reason that anything running during STR should have to wait for 
something in userspace to complete.  Given that fact, I don't see 
anything wrong with freezing userspace when doing STR.

Alan Stern
