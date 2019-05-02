From: Nikitas Angelinas <nikitas.angelinas@gmail.com>
Subject: Re: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Date: Thu, 2 May 2019 10:59:58 -0700
Message-ID: <20190502175958.GA14955@vostro>
References: <20190502074305.GA6039@vostro>
 <20190502101500.GA23980@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502101500.GA23980@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 02, 2019 at 12:15:00PM +0200, Pavel Machek wrote:
> On Thu 2019-05-02 00:43:05, Nikitas Angelinas wrote:
> > There is no need to keep sysrq_poweroff_op after initialization, so mark
> > it with __initdata.
> 
> Are you sure?
> 
> pavel@duo:/data/l/k$ grep -ri sysrq_key_op . | grep initdata
> pavel@duo:/data/l/k$
> 
> 
> 									Pavel
> 
I am sorry about this. I completely missed the point of registering this
structure. Please ignore this patch.



Cheers,
Nikitas
> >  
> > -static struct sysrq_key_op	sysrq_poweroff_op = {
> > +static struct sysrq_key_op sysrq_poweroff_op __initdata = {
> >  	.handler        = handle_poweroff,
> >  	.help_msg       = "poweroff(o)",
> >  	.action_msg     = "Power Off",
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
