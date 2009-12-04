From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: [PATCH] Runtime PM: Adding explicit check to make
 sure dev->parent supports runtime PM before accessing its PM fields.
Date: Fri, 4 Dec 2009 21:43:21 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298C5C4F11C@bgsmsx502.gar.corp.intel.com>
References: <175E0F9A9EFCEA46A65F5552BB057298C5C4EDD5@bgsmsx502.gar.corp.intel.com>
	<Pine.LNX.4.44L0.0912041021140.3070-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912041021140.3070-100000@iolanthe.rowland.org>
Content-Language: en-US
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>> The below patch makes sure that dev->parent supports runtime PM before accessing its PM fields. Though the code does this check at a later point in time, doing it earlier > can optimize the code flow.

> This is not a good idea.  Those fields should be set correctly even if 
> the parent's disable_depth is positive.  What would happen if the 
> fields were wrong and then somebody called pm_runtime_enable(parent)?

Yes Alan, those fields do get set but if you look at __pm_runtime_set_status function -

	if (status == RPM_SUSPENDED) {
		/* It always is possible to set the status to 'suspended'. */
		if (parent) {
			atomic_add_unless(&parent->power.child_count, -1, 0);
			notify_parent = !parent->power.ignore_children;
		}
		goto out_set;
	}

This code gets executed without doing any check to see if the parent supports runtime PM. Doing explicit check before can avoid executing these code at runtime.

> Whether this change optimizes the code flow is not entirely clear.  
> Sure, it speeds things up a little in the case where the parent is
> disabled.  But it also slows things down in the case where the parent
> is enabled.

As I mentioned the checks do happen in the code at a later point in time so these are not extra checks which will slow things when parent is enabled. But pulling this check up will avoid lot many other PM fields (like lock etc) access when runtime is not enabled, which I think is optimization.


Regards,	
Nithish Mahalingam
