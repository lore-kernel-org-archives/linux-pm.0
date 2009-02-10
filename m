From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13] PM:	Add wake lock?api.)
Date: Tue, 10 Feb 2009 07:20:48 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037705B707@dlee02.ent.ti.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
	<200902090249.59119.u.luckas@road.de>
	<20090210111749.GC4636@atrey.karlin.mff.cuni.cz>
	<13B9B4C6EF24D648824FF11BE8967162037705B6E9@dlee02.ent.ti.com>
	<20090210131457.GA15539@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090210131457.GA15539@elf.ucw.cz>
Content-Language: en-US
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
Cc: "swetland@google.com" <swetland@google.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org


> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Tuesday, February 10, 2009 7:15 AM

> > Not sure this is your point.  But when doing PowerTop based debug in our
> Linux userspace we found several applications using select() (or some variant)
> with a much short timeout than needed.  In effect they were polling and
> keeping the system alive.
> >
> > In the cases it was an application in our control we converted it to
> something sane.
> >
>
> No, that's something different.
>
> Apparently, on android, if there's event ready on one of the input
> devices, system will not go to sleep. That's quite an "interesting"
> behaviour.
>
> Heh, they could rely on it and get rid of the wakelock. Just create
> strange device that disallows system sleep when you select() on it,
> and allows it when you read() from it :-).

Ok, thanks. When I looked quickly a couple months back I thought they raised a user space side wake locks on input consumers.  These translated back to the kernel lock and keep the system up.

Gist was something like you don't want to sleep until user activity data was processed.  Any high latency sleep/suspend would be perceived by user.

Regards,
Richard W.
