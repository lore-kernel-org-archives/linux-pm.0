From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Runtime PM: Adding explicit check to make
 sure dev->parent supports runtime PM before accessing its PM fields.
Date: Fri, 4 Dec 2009 21:43:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912042139000.7227-100000@netrider.rowland.org>
References: <175E0F9A9EFCEA46A65F5552BB057298C5C4F193@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <175E0F9A9EFCEA46A65F5552BB057298C5C4F193@bgsmsx502.gar.corp.intel.com>
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

On Sat, 5 Dec 2009, Mahalingam, Nithish wrote:

> > The most troublesome case arises when you have a parent which is 
> > disabled for runtime PM and later on becomes enabled.  This may not 
> > happen very often -- it may not happen at all.  I would expect that if 
> > a device changes from disabled to enabled, it probably does so before 
> > acquiring any children.  But we can't be certain of this.
> 
> OK, get what you are saying. I was thinking of a particular use case and 
> before I talk about that let me prototype and see if I hit this 
> particular case.

All right.  If it does turn out that devices _never_ change from 
disabled to enabled while they have children (we could add a check for 
this!) then you are right -- it's not necessary to update 
parent->power.child_count if the parent is disabled.

But the only way to be sure it will never happen is to forbid it
explicitly in the documentation.

Alan Stern
