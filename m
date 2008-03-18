From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
 and hibernation callbacks
Date: Tue, 18 Mar 2008 11:10:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803181103410.1476-100000@netrider.rowland.org>
References: <20080318100106.GA10830@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080318100106.GA10830@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Mar 2008, Pavel Machek wrote:

> > + * @complete: Undo the changes made by @prepare().  This method is executed for
> > + *	all kinds of resume transitions, immediately following one of the resume
> > + *	callbacks: @resume(), @thaw(), @restore(), or @recover().  Also executed
> > + *	if a suspend callback (@suspend(), @freeze(), @poweroff(), @quiesce())
> > + *	immediately following a successful @prepare() fails OR if a new child
> > + *	of the device has been registered during @prepare().

"during a successful call to @prepare()"?

> So... we do prepare() but it detects new child, so it returns -EAGAIN.
>   so we call complete() based on description above
> ...and then we call prepare() to suspend again?

You misunderstood (maybe the comment needs to be clarified as above).  

If prepare() returns any error (including -EAGAIN) then complete() does
not get called.  If prepare() returns successfully but the PM core
detects that a new child was added while prepare() was running, then we
call complete(), suspend the child, and call prepare() again.

> > + * @suspend: Executed before putting the system into a sleep state in which the
> > + *	contents of main memory are preserved.  Quiesce the device, put it into
> 
> content....is?

It's okay to use "contents" -- analogous to the table of contents in a
book.  It's one of those weird corner cases where either alternative is
acceptable.

Alan Stern
