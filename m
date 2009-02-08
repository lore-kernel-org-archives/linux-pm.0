From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state	interface
Date: Mon, 9 Feb 2009 00:41:42 +0100
Message-ID: <20090208234142.GA1382@ucw.cz>
References: <20090208210401.GE6369@elf.ucw.cz> <200902100117.37019.rjw@sisk.pl>
	<20090210091314.GA18835@atrey.karlin.mff.cuni.cz>
	<200902101518.29690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902101518.29690.rjw@sisk.pl>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> > > No, we are talking of allocating kernel memory on behalf of user space
> > > processes with no apparent limitations.
> > 
> > Ok, I see now. Yes, letting each process allocated unlimited number of
> > wakelocks is indeed bad.
> > 
> > (But the names for in-kernel users should be ok, right?)
> 
> Yes, in principle, but what exactly the benefit would be?
> 
> In the kernel we can use rwlock for blocking suspend, for example,
> that will be taken for reading by the code paths wanting to prevent suspend
> from happening and for writing by the suspend code.
> 
> > "Wakelock is a filedescriptor" would solve that...
> 
> Sort of.
> 
> Still, I don't think there's much point in having more than one "wakelock"
> per process.
> 
> Moreover, I _guess_ it would be sufficient to have only one such thing for
> the entire user space and single daemon and a (user land) library to manage it.

...which is what android userland actually does...

OTOH they also veto suspend if any events are unprocessed on input
device queues... so tying it to filedescriptor would make some sense.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
