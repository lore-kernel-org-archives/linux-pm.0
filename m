From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Fri, 5 Mar 2010 22:09:41 +0100
Message-ID: <201003052209.42002.rjw__43880.2621480592$1267823378$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003051559410.1384-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003051559410.1384-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 05 March 2010, Alan Stern wrote:
> On Fri, 5 Mar 2010, Rafael J. Wysocki wrote:
> 
> > On Friday 05 March 2010, Alan Stern wrote:
> > > On Thu, 4 Mar 2010, Rafael J. Wysocki wrote:
> > > 
> > > > I agree with all of the comments above, hopefully addessed them in the new
> > > > patch below.
> > > 
> > > It looks good.  One small thing: You probably should change the
> > > kerneldoc for pm_generic_runtime_idle to match the changes in
> > > pm_generic_runtime_{suspend,resume}.  I must have missed that one.
> > 
> > Yeah, I missed that too.  Should be better now.
> 
> So it is.

Thanks!

I'll try to send it to Linus during this merge window along with a missing
runtime PM documentation update.

Then, I'm going to start updating the old device PM documentation, because
it's hopelessly outdated.

Rafael
