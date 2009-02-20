From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 23:44:18 +0100
Message-ID: <200902202344.20040.rjw__27570.3158382841$1235170758$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0902191659020.7953-100000@iolanthe.rowland.org>
	<200902201146.59944.rjw@sisk.pl>
	<200902202305.09992.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902202305.09992.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 20 February 2009, Oliver Neukum wrote:
> Am Freitag 20 Februar 2009 11:46:55 schrieb Rafael J. Wysocki:
> > On Thursday 19 February 2009, Oliver Neukum wrote:
> > > Am Donnerstag 19 Februar 2009 23:21:46 schrieb Rafael J. Wysocki:
> > > > > That's the whole point behind userspace wakelocks!  They provide a
> > > > > mechanism for userspace to tell the kernel when (as far as userspace
> > >
> > > is
> > >
> > > > > concerned) it is or is not okay to auto-sleep.
> > > >
> > > > Still, one can go further and observe that the user space can in fact
> > > > start automatic suspend by itself whenever it knows it's appropriate
> > > > ...
> > >
> > > User space initiating this is a race condition.
> >
> > Do you mean a race with the other user space processes or with the kernel?
> 
> With the set of runnable processes.There's always a window between
> evaluating the current set of runnable tasks and telling the kernel to sleep.
> IMO the most elegant solution would be a task attribute that would signal
> the kernel that a task should not count as keeping the system busy even
> if it is runnable and trigger the sleep in kernel space.

Please see my last reply to Arve (http://lkml.org/lkml/2009/2/20/182) and tell
me what you think.

Best,
Rafael
