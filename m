From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Hibernate: Fix memory corruption
	related to swap
Date: Fri, 3 Dec 2010 01:06:48 +0100
Message-ID: <201012030106.49226.rjw__20630.1389066086$1291335006$gmane$org@sisk.pl>
References: <201012030040.37273.rjw@sisk.pl>
	<20101202155453.92e8ca57.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101202155453.92e8ca57.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, Hugh Dickins <hughd@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Friday, December 03, 2010, Andrew Morton wrote:
> On Fri, 3 Dec 2010 00:40:36 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > There is a problem that swap pages allocated before the creation of
> > a hibernation image can be released and used for storing the contents
> > of different memory pages while the image is being saved.  Since the
> > kernel stored in the image doesn't know of that, it causes memory
> > corruption to occur after resume from hibernation, especially on
> > systems with relatively small RAM that need to swap often.
> > 
> > This issue can be addressed by keeping the GFP_IOFS bits clear
> > in gfp_allowed_mask during the entire hibernation, including the
> > saving of the image, until the system is finally turned off or
> > the hibernation is aborted.  Unfortunately, for this purpose
> > it's necessary to rework the way in which the hibernate and
> > suspend code manipulates gfp_allowed_mask.
> > 
> > This change is based on an earlier patch from Hugh Dickins.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Reported-by: Ondrej Zary <linux@rainbow-software.org>
> > Acked-by: Hugh Dickins <hughd@google.com>
> > ---
> > 
> > Hi,
> > 
> > This patch is a fix for a regression and nasty memory corruption, so I'd like
> > to push it to Linus for 2.6.37 if there are no objections.
> > 
> 
> It looks OK to me for 2.6.37 but for 2.6.38 please let's make
> everything here a 100% no-op for CONFIG_PM_SLEEP=n builds. 
> Specifically the slight overhead in __alloc_pages_nodemask.

OK, I'll take care of it.

> Because given the global nature of saved_gfp_mask and the unlocked way
> in which it is accessed, this facility won't be at all useful for
> anything other than suspend.

Right.
