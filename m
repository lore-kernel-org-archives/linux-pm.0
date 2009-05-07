From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 7 May 2009 21:27:11 +0200
Message-ID: <200905072127.11995.rjw__30637.0865706869$1241724673$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905072022.15202.rjw@sisk.pl>
	<b637ec0b0905071157x2d6f050aqcb825241c51ccb84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b637ec0b0905071157x2d6f050aqcb825241c51ccb84@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Matt Price <moptop99@gmail.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, Fabio Comolli wrote:
> On Thu, May 7, 2009 at 8:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday 07 May 2009, Matt Price wrote:
> >> On Thu, May 7, 2009 at 1:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Thursday 07 May 2009, U Kuehn wrote:
> >> >> Pavel Machek wrote:
> >> >> >> T
> >> > Also, as you can see from my previous message, I'm not a big fan of fighting
> >> > over this once again.  Lets try to work together to do something productive
> >> > instead, shall we?
> >> >
> >>
> >> thank you rafael.  i would really like to see the fighting stop, too.
> >> Perhaps the best palce to start would be to look directly at the
> >> patches and, if there are weaknesses, discuss how to improve them?
> >
> > Yes, I've talked about that already with Nigel and there's a kind of a plan.
> >
> 
> Well, if I may jump in I suggest you start with the full-memory image
> functionality. This is in my opinion the biggest advantage in tuxonice
> vs. uswsusp.

In fact I agree, but there's a catch.  The way in which TuxOnIce operates LRU
pages is based on some assumptions that may or may not be satisfied in future,
so if we decide to merge it, then we'll have to make sure these assumptions
will be satisfied.  That in turn is going to require quite some discussion I
guess.

We'll see how the things work out.

Thanks,
Rafael
