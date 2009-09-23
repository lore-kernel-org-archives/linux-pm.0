From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Help
Date: Wed, 23 Sep 2009 18:43:07 +0200
Message-ID: <20090923164307.GA2092@elf.ucw.cz>
References: <E1McOLX-0003Lq-BN@665xhf1.ch3.sourceforge.com>
	<200908152239.15915.rjw@sisk.pl> <20090822073516.GD2108@elf.ucw.cz>
	<200909230133.28689.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909230133.28689.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, kix <kixdotes@users.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>, stefan.seyfried@googlemail.com
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Message body follows:
> > > > 
> > > > I would like to help in the project.
> > > > 
> > > > - updating the database.
> > > > 
> > > > Have you seen the patch I sent?
> > > 
> > > Yes, sorry for the lack of response, but I didn't really have the time to
> > > review the patch.
> > > 
> > > That said, I don't think we'd like to move the whitelist to a separate file.
> > > Rather than that, we've been considering removing it altogether.
> > > 
> > > Still, if you want to maintain the whitelist in its current form, I think
> > > you could do that.
> > 
> > Yes, maintainer for the whitelist would be very welcome.
> > 
> > Now... whitelist inside the binary is very welcome for init=/bin/bash,
> > etc; OTOH if the .c file is compiled from .txt description... that's
> > probably acceptable. Also it might make sense to load external
> > whitelist _in addition_ to the internal one, so people can quickly
> > experiment with whitelist entries...
> 
> If you're still willing to be a whitelist maintainer, please set up a git
> repository from which I can pull the whitelist updates.

Yes, that would be great.

> If you'd like to move the whitelist to a separate file, please do so.  You are
> free to use whatever format you think is suitable, although it would be nice
> if the whitelist file could be easily updated by users.

Ack.
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
