From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM wakeup flags revisited (was: Re: +
	pm-convert-wakeup-flag-accessors-to-inline-functions-fix.patch
	added to -mm tree)
Date: Wed, 19 Mar 2008 22:33:54 +0100
Message-ID: <200803192233.55313.rjw@sisk.pl>
References: <200803190315.m2J3FXnK029022@imap1.linux-foundation.org>
	<20080319114829.bf993b72.akpm@linux-foundation.org>
	<20080319185755.GA18464@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080319185755.GA18464@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 19 of March 2008, Greg KH wrote:
> On Wed, Mar 19, 2008 at 11:48:29AM -0700, Andrew Morton wrote:
> > I'll drop everything, let's start again.
> > 
> > Only how?  umm, please review Greg's driver tree, let us know which patches
> > shoudl be dropped from that then send new ones, I guess.
> 
> Yes, please do, I'm confused as well :)

Please drop pm-make-wakeup-flags-available-whenever-config_pm-is-set.patch 
and apply the following three patches instead.

Thanks,
Rafael
