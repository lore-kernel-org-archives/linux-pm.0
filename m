From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 23:05:05 +0100
Message-ID: <200902202305.09992.oliver__45413.0763806917$1235167383$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0902191659020.7953-100000@iolanthe.rowland.org>
	<200902192358.13068.oliver@neukum.org>
	<200902201146.59944.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902201146.59944.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Freitag 20 Februar 2009 11:46:55 schrieb Rafael J. Wysocki:
> On Thursday 19 February 2009, Oliver Neukum wrote:
> > Am Donnerstag 19 Februar 2009 23:21:46 schrieb Rafael J. Wysocki:
> > > > That's the whole point behind userspace wakelocks!  They provide a
> > > > mechanism for userspace to tell the kernel when (as far as userspace
> >
> > is
> >
> > > > concerned) it is or is not okay to auto-sleep.
> > >
> > > Still, one can go further and observe that the user space can in fact
> > > start automatic suspend by itself whenever it knows it's appropriate
> > > ...
> >
> > User space initiating this is a race condition.
>
> Do you mean a race with the other user space processes or with the kernel?

With the set of runnable processes.There's always a window between
evaluating the current set of runnable tasks and telling the kernel to sleep.
IMO the most elegant solution would be a task attribute that would signal
the kernel that a task should not count as keeping the system busy even
if it is runnable and trigger the sleep in kernel space.

	Regards
		Oliver
