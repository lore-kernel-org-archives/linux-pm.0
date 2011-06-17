From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question about expected behavior when PM runtime is
 disabled
Date: Fri, 17 Jun 2011 11:08:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171103020.2143-100000@iolanthe.rowland.org>
References: <201106142201.35264.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106142201.35264.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 14 Jun 2011, Rafael J. Wysocki wrote:

> > Then you suggest:
> > 
> > 	Call pm_runtime_disable after .suspend;
> > 
> > 	Call pm_runtime_get_noresume and pm_runtime_enable before
> > 	.resume;
> > 
> > 	Call pm_runtime_put_sync after .complete.
> > 
> > Right?
> 
> Yes, that would be resonable IMO.

This turns out to be harder than it looks.  If an error occurs, we may
run the complete callback for devices that never were suspended or
resumed and hence never had their usage_count incremented.  How can we
tell that we need to skip the pm_runtime_put_sync for these devices?

Would it be okay to call pm_runtime_put_sync immediately after the
resume callback instead of after complete?

Alan Stern
