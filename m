From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Sun, 30 Aug 2009 08:45:33 +0200
Message-ID: <20090830064533.GA1417__44426.1419158012$1251614904$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.0908282146550.9540-100000@netrider.rowland.org>
	<200908291449.57667.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908291449.57667.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > > The same goes for the noirq versions.
> > > > > 
> > > > > I thought about that, but there are a few things to figure out:
> > > > > - how many threads to start
> > > > 
> > > > That's a tough question.  Right now you start roughly as many threads
> > > > as there are async devices.  That seems like overkill.
> > > 
> > > In fact they are substantially fewer than that, for the following reasons.
> > > 
> > > First, the async framework will not start more than MAX_THREADS threads,
> > > which is 256 at the moment.  This number is less than the number of async
> > > devices to handle on an average system.
> > 
> > Okay, but MAX_THREADS isn't under your control.  Remember also that 
> > each thread takes up some memory, and during hibernation we are in a 
> > memory-constrained situation.
> 
> We keep some extra free memory for things like this.  It's not likely to be
> exhausted by the async threads alone.

What extra memory? You are creating quite a lot of threads. For 256 of
them, it would take cca 2MB... You recently removed code from s2disk
that freed 4MB of extra memory, so you are now essentially relying on
min_free_kbytes -- and even then is not reliable, user might s2disk
under memory pressure. min_free_kbytes is 1MB on my system.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
