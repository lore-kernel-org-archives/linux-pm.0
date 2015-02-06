From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] drivers/base: Remove unnecessary OOM message
Date: Fri, 6 Feb 2015 22:17:08 +0100
Message-ID: <20150206211708.GA25967@amd>
References: <20150206153912.GA8486@sloth>
 <20150206205852.GA14126@amd>
 <1423256670.4752.16.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423256670.4752.16.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Quentin Lambert <lambert.quentin@gmail.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2015-02-06 13:04:30, Joe Perches wrote:
> On Fri, 2015-02-06 at 21:58 +0100, Pavel Machek wrote:
> > On Fri 2015-02-06 16:39:12, Quentin Lambert wrote:
> > > This patch fix checkpatch warnings concerning the possible
> > > duplication of an "out of memory" message.
> > 
> > So, instead of nice and readable "not enough memory for clock..." we
> > get OOM, stackdump, and backtrace...? Not sure it is improvement.
> 
> All allocs without __GFP_NOWARN already gets an OOM and stackdump.
> These are just unnecessary.

"These" being human readable messages or ugly stackdumps?

Read what I have said. Figuring out what allocation failed from
unreliable backtrace is not fun.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
