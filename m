From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/5] PM/Freezer: Disable OOM killer when
	tasks are frozen
Date: Thu, 7 May 2009 14:10:37 +0200
Message-ID: <200905071410.37812.rjw__41496.2534596727$1241698524$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl> <200905070041.04787.rjw@sisk.pl>
	<1241650843.19600.124.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241650843.19600.124.camel@nigel-laptop>
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
To: nigel@tuxonice.net
Cc: pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, Nigel Cunningham wrote:
> Hi.

Hi,

> On Thu, 2009-05-07 at 00:41 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The OOM killer is not really going to work while tasks are frozen, so
> > we can just give up calling it in that case.
> > 
> > This will allow us to safely use memory allocations for decreasing
> > the number of saveable pages in the hibernation core code instead of
> > using any artificial memory shriking mechanisms for this purpose.
> 
> Should we disable the warning that the nopage path gives if tasks are
> frozen? I'm in two minds - if you get problems as a result, it might
> help to diagnose them. On the other hand, you don't want tons of
> warnings due to the hibernation code trying to allocate memory it can't
> get. In TuxOnIce, I currently do all allocations with __GFP_NOWARN.

Yes, I use __GFP_NOWARN in the next patches too. :-)

Thanks,
Rafael
