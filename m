From: Len Brown <lenb@kernel.org>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Wed, 27 May 2009 15:10:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905271437530.4277__10162.6577358276$1243455607$gmane$org@localhost.localdomain>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905081611.41865.rjw@sisk.pl>
	<1241819569.19600.281.camel@nigel-laptop>
	<200905090046.21282.rjw@sisk.pl>
	<1241825408.19600.384.camel@nigel-laptop>
	<2c0942db0905081644l73a7a4f5i8af4677046797df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <2c0942db0905081644l73a7a4f5i8af4677046797df@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

> On Fri, May 8, 2009 at 4:30 PM, Nigel Cunningham <nigel@tuxonice.net> wrote:
> > I think you're putting unrealistic barriers in the way. Does all code
> > that goes into the kernel get "reviewed and agreed upon by everyone at
> > once"? No!
> 
> Actually, yes...
...
> Please stick at this.

I agree with Ray, and could not have said it better.

I will, however, reference prior art...

Greg KH said the exact same thing in 2005
when he met with Nigel and Pavel in Ottawa.

>From Patrick Mochel's minutes, available here:
http://lwn.net/Articles/144193/

"Suspend2 and Software Suspend

There was agreement among the attendees that Nigel Cunningham's 
suspend-to-disk patches ("Suspend2") are stable and worthwhile to many 
users. It was suggested that he begin the process of merging his patches 
with Pavel Machek's in-kernel software suspend implementation. A lengthy 
discussion followed about strategies for doing so and the philosophy of 
gradual kernel development.

To briefly recap: Suspend2 is very robust and feature rich. Not only does 
it include a reliable process freezer, it has the ability to compress and 
encrypt the suspended image and includes a graphical status bar. Although 
it apparently does receive positive reviews from users, most kernel 
developers do not care about such eye candy. It was suggested and agreed 
that Nigel will split the patches (all 69 of them so far) into functional 
groups, and push them separately. We agreed that the process freezer 
patches would come first, which should also benefit the existing suspend 
implementation as well. Next will most likely be the new algorithmic core 
and eventually the plugin architecture and graphical features. It was 
heavily stressed that Nigel and Pavel must work together and that the more 
effort that is put in to making the patches smaller and simpler, the 
easier it will be to merge this work. "

While "suspend2" is now called "tux-on-ice", the same message
about how to merge upstream applies in 2009
just as much as it did in 2005.

Rafael's reference to ch10 in HPA's articulate 2008 OLS paper is apt
http://ols.fedoraproject.org/OLS/Reprints-2008/anvin-reprint.pdf
The involved parties must have common motivation to make forward progress.

The process should be to cherry-pick the out-of-tree implementation
to gradually improve the in-tree-implementation.  If we had started
that 4 years ago, we'd be done by now.  If we don't start it now,
we'll be having this same conversation again in 2013.

thanks,
Len Brown, Intel Open Source Technolgy Center
