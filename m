From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: +
	pm-convert-wakeup-flag-accessors-to-inline-functions-fix.patch
	added to -mm tree
Date: Wed, 19 Mar 2008 22:55:28 +0100
Message-ID: <200803192255.29655.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803191736550.2504-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803191736550.2504-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 19 of March 2008, Alan Stern wrote:
> On Wed, 19 Mar 2008, Greg KH wrote:
> 
> > On Wed, Mar 19, 2008 at 11:48:29AM -0700, Andrew Morton wrote:
> > > I'll drop everything, let's start again.
> > > 
> > > Only how?  umm, please review Greg's driver tree, let us know which patches
> > > shoudl be dropped from that then send new ones, I guess.
> > 
> > Yes, please do, I'm confused as well :)
> 
> Okay.  No doubt Rafael will correct me if I get something wrong.
> 
> Greg's tree still contains the original, wrong version of 
> pm-make-wakeup-flags-available-whenever-config_pm-is-set.patch.  It 
> should be reverted.  In its place should be substituted this series of 
> patches (URLs for 0/3 ... 3/3):
> 
> 	http://marc.info/?l=linux-kernel&m=120561808422302&w=2
> 	http://marc.info/?l=linux-kernel&m=120561808522316&w=2
> 	http://marc.info/?l=linux-kernel&m=120561808522322&w=2
> 	http://marc.info/?l=linux-kernel&m=120561808622328&w=2
> 
> There is likely to be a conflict in applying the 2/3 patch, because its 
> first hunk touches a region of code also affected by work Rafael has 
> been doing.  The important aspect of that hunk is that it moves the 
> should_wakeup flag definition outside the region protected by "#ifdef 
> CONFIG_PM_SLEEP".

I've just resent the three patches, rebased on top of the current tree.

Please double check if everytning is right.

Thanks,
Rafael
