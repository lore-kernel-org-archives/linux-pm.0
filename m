From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Thu, 2 Sep 2010 17:14:04 -0700
Message-ID: <AANLkTinbgShA+m3sdXrYAvW7ctCExp+fZv5EMuYSMLiE__22239.6233505153$1283552281$gmane$org@mail.gmail.com>
References: <AANLkTim7UM80MrwKoAz3hUFrqL2Fbyw6XS=X89PXRc2Q@mail.gmail.com>
	<Pine.LNX.4.44L0.1009021723460.1311-100000@iolanthe.rowland.org>
	<AANLkTin_-y2nsXhH+mXv=bku=WXO7VhfvknYwtLhURfv@mail.gmail.com>
	<201009030109.40816.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009030109.40816.rjw@sisk.pl>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 2, 2010 at 4:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, September 03, 2010, Colin Cross wrote:
>> On Thu, Sep 2, 2010 at 2:34 PM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
>> > On Thu, 2 Sep 2010, Colin Cross wrote:
>> >
>> >> That would work, but I still don't see why it's better. =A0With either
>> >> of your changes, the power.completion variable is storing state, and
>> >> not just used for notification. =A0However, the exact meaning of that
>> >> state is unclear, especially during the transition from an aborted
>> >> suspend to resume, and the state is duplicating power.status. =A0Sett=
ing
>> >> it to complete in dpm_prepare is especially confusing, because at that
>> >> point nothing is completed, it hasn't even been started.
>> >
>> > The state being waited for varies from time to time and is only
>> > partially related to power.status. =A0Instead of using a completion I
>> > suppose we could have used a new "transition_complete" variable
>> > together with a waitqueue. =A0Would you prefer that? =A0It's effective=
ly
>> > the same thing as a completion, but without the nice packaging already
>> > provided by the kernel.
>> No, that doesn't change anything. =A0What I'd prefer to see is a
>> wait_for_condition on the desired state of the parent. =A0As is,
>> power.completion means one thing during suspend (the device has
>> started, but not finished, suspending), and a different thing during
>> resume (the device has not finished resuming, and may not have started
>> resuming). =A0That difference is exactly what caused the bug - the
>> completion has to be set on init so that it is set before the device
>> starts suspend.
>
> Not really. =A0The bug is there, because my analysis of the suspend error=
 code
> path was wrong. =A0Sorry about that, but it has nothing to do with the "d=
ifferent
> meaning" of the completions during suspend and resume.
>
> The completions here are simply used to enforce a specific ordering of
> operations, nothing more. =A0They have no meaning beyond that.
The completion variable maintains state.  It has meaning whether or
not you want it to.  Leaving it as a completion variable requires that
you manage that state, which is difficult considering there is no
documentation and no clear idea in the code of exactly when that state
is set or clear.

It would be much cleaner to use a wait queue, and use
wait_on_condition to wait for the device to be in the desired state.

>> I'll send the complete_all on init patch, as it's the only way to fix
>> the problem given the current implementation of dpm_wait.
>
> Great, thanks.
>
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
