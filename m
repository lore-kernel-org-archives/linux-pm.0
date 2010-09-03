From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Fri, 3 Sep 2010 02:35:00 +0200
Message-ID: <201009030235.00270.rjw__47873.207627754$1283474246$gmane$org@sisk.pl>
References: <AANLkTim7UM80MrwKoAz3hUFrqL2Fbyw6XS=X89PXRc2Q@mail.gmail.com>
	<201009030109.40816.rjw@sisk.pl>
	<AANLkTinbgShA+m3sdXrYAvW7ctCExp+fZv5EMuYSMLiE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinbgShA+m3sdXrYAvW7ctCExp+fZv5EMuYSMLiE@mail.gmail.com>
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

On Friday, September 03, 2010, Colin Cross wrote:
> On Thu, Sep 2, 2010 at 4:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, September 03, 2010, Colin Cross wrote:
> >> On Thu, Sep 2, 2010 at 2:34 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> > On Thu, 2 Sep 2010, Colin Cross wrote:
> >> >
> >> >> That would work, but I still don't see why it's better.  With either
> >> >> of your changes, the power.completion variable is storing state, and
> >> >> not just used for notification.  However, the exact meaning of that
> >> >> state is unclear, especially during the transition from an aborted
> >> >> suspend to resume, and the state is duplicating power.status.  Setting
> >> >> it to complete in dpm_prepare is especially confusing, because at that
> >> >> point nothing is completed, it hasn't even been started.
> >> >
> >> > The state being waited for varies from time to time and is only
> >> > partially related to power.status.  Instead of using a completion I
> >> > suppose we could have used a new "transition_complete" variable
> >> > together with a waitqueue.  Would you prefer that?  It's effectively
> >> > the same thing as a completion, but without the nice packaging already
> >> > provided by the kernel.
> >> No, that doesn't change anything.  What I'd prefer to see is a
> >> wait_for_condition on the desired state of the parent.  As is,
> >> power.completion means one thing during suspend (the device has
> >> started, but not finished, suspending), and a different thing during
> >> resume (the device has not finished resuming, and may not have started
> >> resuming).  That difference is exactly what caused the bug - the
> >> completion has to be set on init so that it is set before the device
> >> starts suspend.
> >
> > Not really.  The bug is there, because my analysis of the suspend error code
> > path was wrong.  Sorry about that, but it has nothing to do with the "different
> > meaning" of the completions during suspend and resume.
> >
> > The completions here are simply used to enforce a specific ordering of
> > operations, nothing more.  They have no meaning beyond that.
>
> The completion variable maintains state.

So what?  Locks also maintain state.

> It has meaning whether or not you want it to.  Leaving it as a completion
> variable requires that you manage that state, which is difficult considering
> there is no documentation and no clear idea in the code of exactly when that
> state is set or clear.

Please run "git show 5af84b82701a96be4b033aaa51d86c72e2ded061" and read the
changelog.  It's described in there quite clearly (I think).

> It would be much cleaner to use a wait queue, and use
> wait_on_condition to wait for the device to be in the desired state.

Well, in fact that was used in one version of the patchset that introduced
asynchronous suspend-resume, but it was rejected by Linus, because it was
based on non-standard synchronization.  The Linus' argument, that I agreed
with, was that standard snychronization constructs, such as locks or
completions, were guaranteed to work accross different architectures and thus
were simply _safer_ to use than open-coded synchronization that you seem to be
preferring.

Completions simply allowed us to get the desired behavior with the least
effort and that's why we used them.

Thanks,
Rafael
