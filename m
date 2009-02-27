From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 21:40:53 +0100
Message-ID: <20090227204053.GB1387__19788.6991933503$1235767411$gmane$org@ucw.cz>
References: <200902192215.18365.rjw@sisk.pl> <200902210057.27781.rjw@sisk.pl>
	<20090227100941.GE4582@elf.ucw.cz> <200902271522.41915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902271522.41915.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-02-27 15:22:39, Rafael J. Wysocki wrote:
> On Friday 27 February 2009, Pavel Machek wrote:
> > Hi!
> > 
> > > > > Then, the decision making logic will be able to use /sys/power/sleep whenever
> > > > > it wishes to and the kernel will be able to refuse to suspend if it's not
> > > > > desirable at the moment.
> > > > >
> > > > > It seems to be flexible enough to me.
> > > > 
> > > > This seems flexible enough to avoid race conditions, but it forces the
> > > > user space power manager to poll when the kernel refuse suspend.
> > > 
> > > And if the kernel is supposed to start automatic suspend, it has to monitor
> > > all of the wakelocks.  IMO, it's better to allow the power manager to poll the
> > > kernel if it refuses to suspend.
> > 
> > polling is evil -- it keeps CPU wake up => wastes power.
> > 
> > Wakelocks done right are single atomic_t... and if you set it to 0,
> > you just unblock "sleeper" thread or something. Zero polling and very
> > simple...
> 
> Except that you have to check all of the wakelocks periodically in a loop =>
> polling.  So?

No. I want to have single atomic_t for all the wakelocks... at least
in non-debug version. Debug version will be slower. I believe you
originally suggested that.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
