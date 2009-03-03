From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 3 Mar 2009 14:57:50 +0100
Message-ID: <20090303135750.GC5060__27620.2117828236$1236088739$gmane$org@elf.ucw.cz>
References: <200902192215.18365.rjw@sisk.pl> <200902272155.42010.rjw@sisk.pl>
	<d6200be20902271456w77951afata1d5f378ddbe6b84@mail.gmail.com>
	<200902281118.14595.rjw@sisk.pl>
	<d6200be20902281357r2d3a0075q77055c1781f174d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902281357r2d3a0075q77055c1781f174d7@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> If you ignore wakelocks with timeouts, the current
> >> wakelock interface can be implemented with a global atomic_t to
> >> prevent suspend, and a per wakelock atomic_t to prevent a single
> >> client from changing the global reference count by more than one.
> >>
> >> There are a couple of reasons that I have not done this. It removes
> >> the ability to easily inspect the system when it is not suspending.
> >
> > Care to elaborate?
> 
> If you have a single atomic_t and it is not 0, you do not know who
> incremented it.

Which is okay for already debugged system. For debugging, yes some
support can be nice.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
