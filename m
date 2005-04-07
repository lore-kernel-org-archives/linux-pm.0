From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: freeze_processes questions
Date: Thu, 07 Apr 2005 22:47:27 +1000
Message-ID: <1112878047.3757.104.camel@desktop.cunningham.myip.net.au>
References: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
	<200504062335.34143.rjw@sisk.pl> <20050407091157.GB1541@elf.ucw.cz>
	<200504071429.12687.rjw@sisk.pl>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============85983115276758926=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504071429.12687.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============85983115276758926==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-04-07 at 22:29, Rafael J. Wysocki wrote:
> I am confused now.  AFAICS, we don't check anywhere if a process we
> are going to freeze holds any locks.  If we have a task in
> TASK_INTERRUPTIBLE, we just send it a fake signal which causes it to go
> to the refrigerator().  Could you please tell me how we prevent such a task
> from holding any locks?  [It probably doesn't matter, at least practically,
> but ...? :-)]

Checking that no locks aren't held is impossible at the moment afaik.
There's no 'I'm holding n locks counter'. And even if there were, if you
get rid of the refrigerator, you still can't guarantee that you won't
deadlock against processes grabbing locks after your atomic copy.

Dropping the freezer also means you're forever limiting suspend to
writing a maximum of one half of memory - unless you're going to do
non-atomic images.

> > OTOH... we may want to move completely away from refrigerator. Its
> > quite a hack, and it device support is okay, we'll not really need it.
> 
> Still, it won't happen soon, I guess. :-)  As of today, we have the
> refrigerator and the processes in TASK_UNINTERRUPTIBLE are mishandled.
> I think we should do something about it, at least for now, until we drop
> the refrigerator altogether (if we are going to drop it).  That's why I
> started the discussion and sent the patch.

I believe dropping the refrigerator is a fundamentally broken idea. You
have to (at least) stop processes doing disk I/O (otherwise the snapshot
you just took won't match the on-disk state). At the same time, though,
you still need I/O to work for your suspend implementation. You're then
talking about putting nous in the drivers which says "Hold this I/O,
it's not suspend but process this - it's suspend."

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============85983115276758926==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============85983115276758926==--
