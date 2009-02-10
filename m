From: Brian Swetland <swetland@google.com>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13]	PM: Add wake lock?api.)
Date: Tue, 10 Feb 2009 05:42:14 -0800
Message-ID: <20090210134214.GA6871@bulgaria.corp.google.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
	<200902090249.59119.u.luckas@road.de>
	<20090210111749.GC4636@atrey.karlin.mff.cuni.cz>
	<13B9B4C6EF24D648824FF11BE8967162037705B6E9@dlee02.ent.ti.com>
	<20090210131457.GA15539@elf.ucw.cz>
	<13B9B4C6EF24D648824FF11BE8967162037705B707@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037705B707@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

["Woodruff, Richard" <r-woodruff2@ti.com>]
> > From: Pavel Machek [mailto:pavel@ucw.cz]
> >
> > Apparently, on android, if there's event ready on one of the input
> > devices, system will not go to sleep. That's quite an "interesting"
> > behaviour.
> >
> > Heh, they could rely on it and get rid of the wakelock. Just create
> > strange device that disallows system sleep when you select() on it,
> > and allows it when you read() from it :-).
> 
> Ok, thanks. When I looked quickly a couple months back I thought they 
> raised a user space side wake locks on input consumers.  These 
> translated back to the kernel lock and keep the system up.
> 
> Gist was something like you don't want to sleep until user activity 
> data was processed.  Any high latency sleep/suspend would be perceived 
> by user.

The intention is to make sure we hand-off "awakeness" from kernel to
userspace when the system is waking up to process an event.  Which is
why the event dispatcher in the framework select()s, grabs a wakelock if
readable (overlapping with the wakelock held when data is in the input
queue in the kernel), read()s the events (causing the kernel side to
drop its lock when the queue is empty) and dispatches them while holding 
the wakelock until things are sorted out.

Generally, arbitrary processes cannot open input devices in Android, so
this being a mechanism for abuse of keeping the system awake has not
been an issue thus far. 

Brian
