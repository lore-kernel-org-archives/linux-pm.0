From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
 resume} helper functions
Date: Fri, 5 Mar 2010 16:00:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003051559410.1384-100000__38861.1527429477$1267822864$gmane$org@iolanthe.rowland.org>
References: <201003052140.16948.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003052140.16948.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Mar 2010, Rafael J. Wysocki wrote:

> On Friday 05 March 2010, Alan Stern wrote:
> > On Thu, 4 Mar 2010, Rafael J. Wysocki wrote:
> > 
> > > I agree with all of the comments above, hopefully addessed them in the new
> > > patch below.
> > 
> > It looks good.  One small thing: You probably should change the
> > kerneldoc for pm_generic_runtime_idle to match the changes in
> > pm_generic_runtime_{suspend,resume}.  I must have missed that one.
> 
> Yeah, I missed that too.  Should be better now.

So it is.

Alan Stern
