From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks
Date: Wed, 19 Mar 2008 00:54:57 +0100
Message-ID: <20080318235457.GA1936@elf.ucw.cz>
References: <20080318100106.GA10830@elf.ucw.cz>
	<Pine.LNX.4.44L0.0803181103410.1476-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0803181103410.1476-100000@netrider.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> > So... we do prepare() but it detects new child, so it returns -EAGAIN.
> >   so we call complete() based on description above
> > ...and then we call prepare() to suspend again?
> 
> You misunderstood (maybe the comment needs to be clarified as above).  

Yes, please :-).

> If prepare() returns any error (including -EAGAIN) then complete() does
> not get called.  If prepare() returns successfully but the PM core
> detects that a new child was added while prepare() was running, then we
> call complete(), suspend the child, and call prepare() again.

Ok.

> > > + * @suspend: Executed before putting the system into a sleep state in which the
> > > + *	contents of main memory are preserved.  Quiesce the device, put it into
> > 
> > content....is?
> 
> It's okay to use "contents" -- analogous to the table of contents in a
> book.  It's one of those weird corner cases where either alternative is
> acceptable.

Ok -- I guess I should get that english course ;-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
