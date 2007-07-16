From: jfannin@gmail.com (Joseph Fannin)
Subject: Re: Hibernating To Swap Considered Harmful
Date: Mon, 16 Jul 2007 01:37:52 -0400
Message-ID: <20070716053751.GA13707@nineveh.local>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707131130.51279.rjw@sisk.pl>
	<20070714004517.GA18336@nineveh.local>
	<200707141148.18279.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707141148.18279.rjw@sisk.pl>
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
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Joseph Fannin <jfannin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 14, 2007 at 11:48:17AM +0200, Rafael J. Wysocki wrote:
> On Saturday, 14 July 2007 02:45, Joseph Fannin wrote:
> > On Fri, Jul 13, 2007 at 11:30:50AM +0200, Rafael J. Wysocki wrote:
> > > On Friday, 13 July 2007 07:42, Joseph Fannin wrote:
> > > > On Thu, Jul 12, 2007 at 08:06:43PM -0700, david@lang.hm wrote:
> > >
> > > If you're afraid of that, use a dedicated swap file.
> >
> >     I don't understand what you mean.  A dedicated swap file for what?
>
> Sorry, I should have been more precise.
>
> For hibernation (ie. a swap file that you activate right befor the
> hibernation).
>
> Also tuxonice (formerly known as suspend2) allows you to use regular files
> hibernation.

     How is that different from what I proposed, other than the
requirement to pass the swap data stuctures between the two kernels?

     Even if you only expect hibernation to work only _most of the
time_, suspending to swap means allocating a bunch of swap space that
you intend to never be used as swap.  The two functions don't really
belong together.

--
Joseph Fannin
jfannin@gmail.com
