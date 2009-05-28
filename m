From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 28 May 2009 13:50:41 +0200
Message-ID: <20090528115041.GB2159__28438.3613885895$1243511502$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905081611.41865.rjw@sisk.pl>
	<1241819569.19600.281.camel@nigel-laptop>
	<200905090046.21282.rjw@sisk.pl>
	<1241825408.19600.384.camel@nigel-laptop>
	<20090509135452.GE10859@elf.ucw.cz>
	<1243245214.16743.90.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1243245214.16743.90.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2009-05-25 19:53:34, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2009-05-09 at 15:54 +0200, Pavel Machek wrote:
> > > This is going to sound arrogant, but please don't take it that way: I
> > > can't see any other way of putting it. I don't *think* my code is
> > > better. It is better. swsusp has essentially stood still since Pavel
> > > first forked the code and got it merged. Yes, you have done some
> > > great
> > 
> > I don't think _I_ forked anything.
> 
> The conversation for May 2002 (around when you got it merged into
> vanilla) is here:
> 
> https://sourceforge.net/mailarchive/forum.php?forum_name=swsusp-devel&max_rows=100&style=flat&viewmonth=200205
> 
> Not sure why Sourceforge wants you to log in to get at it.

Not sure what to search for in 90+ emails.

> > > new features (support for multiple swap partitions & files, for writing
> > > to ordinary files, for mulithreaded I/O etc etc) making it more useful
> > > and more reliable. There are some new features that have been put in
> > > swsusp, but in just about every case (I think there might be an
> > > exception or two), they're things TuxOnIce had for ages before. eg: SMP
> > > support came with cpu hotplugging in 2.6.12 or so. TuxOnIce had SMP
> > > support in 2.4.
> > 
> > You were moving faster because you did not have to move in small
> > incremental steps, and you were allowed to add temporary hacks into
> > the code. Is that surprising? Not to me.
> 
> No, I moved in small incremental steps too - and the odd big rework.

...and sometimes you just added code that would not be acceptable in
the mainline (graphical progress bar), only to fix that in few
years. That allowed you to go faster, and that would not be allowed in
the mainline.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
