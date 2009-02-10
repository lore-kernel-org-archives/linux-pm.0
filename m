From: Pavel Machek <pavel@ucw.cz>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13] PM:	Add wake lock?api.)
Date: Tue, 10 Feb 2009 14:14:58 +0100
Message-ID: <20090210131457.GA15539@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
	<200902090249.59119.u.luckas@road.de>
	<20090210111749.GC4636@atrey.karlin.mff.cuni.cz>
	<13B9B4C6EF24D648824FF11BE8967162037705B6E9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037705B6E9@dlee02.ent.ti.com>
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
Cc: "swetland@google.com" <swetland@google.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Tue 2009-02-10 06:10:24, Woodruff, Richard wrote:
> 
> > From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
> > bounces@lists.linux-foundation.org] On Behalf Of Pavel Machek
> > Sent: Tuesday, February 10, 2009 5:18 AM
> 
> > Plus I don't like that any application select-ing on input device can
> > prevent system from sleeping. That's quite a unexpected sideeffect.
> 
> Not sure this is your point.  But when doing PowerTop based debug in our Linux userspace we found several applications using select() (or some variant) with a much short timeout than needed.  In effect they were polling and keeping the system alive.
> 
> In the cases it was an application in our control we converted it to something sane.
> 

No, that's something different.

Apparently, on android, if there's event ready on one of the input
devices, system will not go to sleep. That's quite an "interesting"
behaviour.

Heh, they could rely on it and get rid of the wakelock. Just create
strange device that disallows system sleep when you select() on it,
and allows it when you read() from it :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
