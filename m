From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Thu, 2 Sep 2010 21:30:57 -0700
Message-ID: <AANLkTindhyovNphyCfnSuqN8KogZ0APdWyL7T=vYHHPF__33121.6909959496$1283552287$gmane$org@mail.gmail.com>
References: <AANLkTikug=+ztLCJbxYiyx1U_whLkQ9zsYvEMbV9JyJi@mail.gmail.com>
	<Pine.LNX.4.44L0.1009022233030.19022-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009022233030.19022-100000@netrider.rowland.org>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 2, 2010 at 7:42 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Thu, 2 Sep 2010, Colin Cross wrote:
>
>> > Well, in fact that was used in one version of the patchset that introd=
uced
>> > asynchronous suspend-resume, but it was rejected by Linus, because it =
was
>> > based on non-standard synchronization. =A0The Linus' argument, that I =
agreed
>> > with, was that standard snychronization constructs, such as locks or
>> > completions, were guaranteed to work accross different architectures a=
nd thus
>> > were simply _safer_ to use than open-coded synchronization that you se=
em to be
>> > preferring.
>> If I'm reading the right thread, that was using rwlocks, not
>> conditions.
>
> No, the thread talked about rwsems, not rwlocks. =A0And that's not what
> Linus didn't like -- indeed, using rwsems was his idea. =A0He didn't like
> non-standard open-coded synchronization.
>
>> =A0wait_on_condition looks just as cross-architecture as
>> completions, and is almost as simple.
>
> Do you mean wait_event? =A0It doesn't include the synchronization that
> completions have.
>
>> I look at it like this: =A0Are you waiting for something to complete, or
>> are you waiting for something to be in a specific state? =A0Completion
>> works great if you know that you will only want to wait after it
>> starts. =A0That's not true for an aborted suspend - you may call
>> dpm_wait on a device that has never started resuming, because it never
>> suspended. =A0You can use a completion, and make sure it's state is
>> right for all the corner cases, but at the end of the day that's not
>> what you mean. =A0What you mean is "wait on the device to be resumed",
>> and that's a condition, not a simple completion event.
>>
>> > Completions simply allowed us to get the desired behavior with the lea=
st
>> > effort and that's why we used them.
>> I'm happy with the end result, but I may submit a patch that converts
>> the completions to conditions for discussion.
>
> Be sure to add memory barriers at the appropriate places. =A0That's what
> Linus was complaining about in the earlier approach.

You're right, wait_event would be much worse.

I think there's another race condition during suspend.  If an
asynchronous device calls device_pm_wait_for_dev on a device that
hasn't had device_suspend called on it yet, power.completion will
still be set from initialization or the last time it completed resume,
and it won't wait.

Assuming that problem is fixed somehow, there's also a deadlock
possibility.  Consider 3 devices.  A, B, and C, registered in that
order.  A is async, and the suspend handler calls
device_pm_wait_for_dev(C).  B's suspend handler returns an error.  A's
suspend handler is now stuck waiting on C->power.completion, but
device_suspend(C) will never be called.

There are also an unhandled edge condition - what is the expected
behavior for a call to device_pm_wait_for_dev on a device if the
suspend handler for that device returns an error?  Currently, the
calling device will continue as if the target device had suspended.

What about splitting power.completion into two flags,
power.suspend_complete and power.resume_complete?
power.resume_complete is initialized to 1, because the devices start
resumed.  Clear power.suspend_complete for all devices at the
beginning of dpm_suspend, and clear power.resume_complete for any
device that is suspended at the beginning of dpm_resume.  The
semantics of each flag is then always clear.  Any time between the
beginning and end of dpm_suspend, waiting on any device's
power.suspend_complete will block until that device is in suspend.
Any time between the beginning and end of dpm_resume, waiting on
power.resume_complete will block IFF the device is suspended.

A solution to the 2nd and 3rd problems would still be needed - a way
to abort drivers that call device_pm_wait_for_dev when suspend is
aborted, and a return value to tell them the device being waited on is
not suspended.
