From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
 resume after abort
Date: Thu, 2 Sep 2010 22:42:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009022233030.19022-100000__47557.1075840437$1283481887$gmane$org@netrider.rowland.org>
References: <AANLkTikug=+ztLCJbxYiyx1U_whLkQ9zsYvEMbV9JyJi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikug=+ztLCJbxYiyx1U_whLkQ9zsYvEMbV9JyJi@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Sep 2010, Colin Cross wrote:

> > Well, in fact that was used in one version of the patchset that introdu=
ced
> > asynchronous suspend-resume, but it was rejected by Linus, because it w=
as
> > based on non-standard synchronization. =A0The Linus' argument, that I a=
greed
> > with, was that standard snychronization constructs, such as locks or
> > completions, were guaranteed to work accross different architectures an=
d thus
> > were simply _safer_ to use than open-coded synchronization that you see=
m to be
> > preferring.
> If I'm reading the right thread, that was using rwlocks, not
> conditions.

No, the thread talked about rwsems, not rwlocks.  And that's not what =

Linus didn't like -- indeed, using rwsems was his idea.  He didn't like =

non-standard open-coded synchronization.

>  wait_on_condition looks just as cross-architecture as
> completions, and is almost as simple.

Do you mean wait_event?  It doesn't include the synchronization that =

completions have.

> I look at it like this:  Are you waiting for something to complete, or
> are you waiting for something to be in a specific state?  Completion
> works great if you know that you will only want to wait after it
> starts.  That's not true for an aborted suspend - you may call
> dpm_wait on a device that has never started resuming, because it never
> suspended.  You can use a completion, and make sure it's state is
> right for all the corner cases, but at the end of the day that's not
> what you mean.  What you mean is "wait on the device to be resumed",
> and that's a condition, not a simple completion event.
> =

> > Completions simply allowed us to get the desired behavior with the least
> > effort and that's why we used them.
> I'm happy with the end result, but I may submit a patch that converts
> the completions to conditions for discussion.

Be sure to add memory barriers at the appropriate places.  That's what =

Linus was complaining about in the earlier approach.

Alan Stern
