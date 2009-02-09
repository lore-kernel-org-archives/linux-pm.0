From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Mon, 9 Feb 2009 01:03:44 +0100
Message-ID: <200902090103.45635.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<d6200be20902071620o2012e80es272745f98345b656@mail.gmail.com>
	<20090208212122.GG6369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090208212122.GG6369@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Pavel Machek wrote:
> Hi!
> 
> > >> > If my understanding is correct, a wakelock is a mechanism that, if held, will
> > >> > prevent the system from (automatically) entering a sleep state, but why do we
> > >> > need a number of such wakelocks instead of just one reference counter with the
> > >> > rule that (automatic) suspend can only happen if the counter is zero?
> > >>
> > >> Using wakelocks instead of a global reference count ensures that your
> > >> request cannot be cleared by someone else.
> > >
> > > Decreasing the refcount without increasing it would have been a bug, IMO.
> > 
> > Yes, but if all you have is a global reference count, you can't tell
> > where the bug is.
> ...
> > >> and detailed stats.
> > >
> > > Well, I'm not sure how this is useful in the long run.
> > 
> > You may want to know which app drained your battery.
> 
> _If_ we want to allow userspace to hold wakelocks (better name could
> be awakelock or nosleeplock?) then some way of displaying them is
> required.

BTW, I don't like the name "wakelocks" at all.  They are not locks in the
traditional sense, they are just flags preventing something (suspend) from
happening.

Thanks,
Rafael
