From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Runtime PM: Adding explicit check to make
 sure dev->parent supports runtime PM before accessing its PM fields.
Date: Fri, 4 Dec 2009 10:28:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912041021140.3070-100000@iolanthe.rowland.org>
References: <175E0F9A9EFCEA46A65F5552BB057298C5C4EDD5@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <175E0F9A9EFCEA46A65F5552BB057298C5C4EDD5@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Dec 2009, Mahalingam, Nithish wrote:

> The below patch makes sure that dev->parent supports runtime PM before accessing its PM fields. Though the code does this check at a later point in time, doing it earlier can optimize the code flow.

This is not a good idea.  Those fields should be set correctly even if 
the parent's disable_depth is positive.  What would happen if the 
fields were wrong and then somebody called pm_runtime_enable(parent)?

Whether this change optimizes the code flow is not entirely clear.  
Sure, it speeds things up a little in the case where the parent is
disabled.  But it also slows things down in the case where the parent
is enabled.

Alan Stern
