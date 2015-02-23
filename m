From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 06/27] power: wakeup: Remove use of seq_printf return
 value
Date: Mon, 23 Feb 2015 12:54:04 +0100
Message-ID: <20150223115404.GC3206@Nokia-N900>
References: <cover.1424573328.git.joe@perches.com>
 <1b5eb664ab9313f1c5b9868819e1960d5dc597ac.1424573328.git.joe@perches.com>
 <20150222213835.GA7817@amd>
 <1424641978.20944.20.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424641978.20944.20.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun 2015-02-22 13:52:58, Joe Perches wrote:
> On Sun, 2015-02-22 at 22:38 +0100, Pavel Machek wrote:
> > On Sat 2015-02-21 18:53:33, Joe Perches wrote:
> > > The seq_printf return value, because it's frequently misused,
> > > will eventually be converted to void. 
> > > 
> > > See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
> > >      seq_has_overflowed() and make public")
> > 
> > You've just removed overflow handling from
> > print_wakeup_source_stats.
> > 
> >  Can you explain why that is good idea?
> 
> If overflow occurs, the seq_file subsystem allocates
> a bigger buffer and calls the show function again.
> 
> See Al's comment in the 0/n patch and here:
> https://lkml.org/lkml/2015/2/17/642

You may want to explain while this is good idea in the changelog.

>From your explanation it looks like error is somehow handled
on higher-level retry, but...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
