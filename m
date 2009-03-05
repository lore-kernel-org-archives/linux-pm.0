From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 5 Mar 2009 17:54:07 +0100
Message-ID: <20090305165407.GB1379__10911.4113533453$1236272314$gmane$org@ucw.cz>
References: <200902191356.53584.rjw@sisk.pl>
	<200902231504.27879.oliver@neukum.org>
	<20090227101818.GH4582@elf.ucw.cz>
	<200902271622.25141.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902271622.25141.oliver@neukum.org>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-02-27 16:22:19, Oliver Neukum wrote:
> Am Freitag 27 Februar 2009 11:18:18 schrieb Pavel Machek:
> > > We can just as well have a class of tasks less important than power
> > > saving. They'd just run when power saving is not active for some other
> > > reason. Just like other such schemes we end up with the problem
> > > of priority inversion with locking.
> >
> > Ok, I guess this could be interesting in some cases... maybe. What are
> > real examples of such tasks?
> 
> The classical example is Seti@HOME.

So it is okay for you to waste 30W on seti on running machine on
battery power but you can't waste those remaining 10W...? I guess I'd
either expect seti to stop at battery power...

suspended machine 0.3W
awake machine 10W
machine running seti 40W

...? (thinkpad x60).

Ok... for something less computing intensive, it might make
sense... but I guess those examples are less widespread than you
expect.

> Any monitoring tool like umtsmon
> or kwifimanager.

I'd expect desktop environment to stop wasting cycles/electrons on
that when user can't see the screen.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
