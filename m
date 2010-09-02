From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Thu, 2 Sep 2010 15:45:19 -0700
Message-ID: <AANLkTin_-y2nsXhH+mXv=bku=WXO7VhfvknYwtLhURfv__2522.56725584648$1283552275$gmane$org@mail.gmail.com>
References: <AANLkTim7UM80MrwKoAz3hUFrqL2Fbyw6XS=X89PXRc2Q@mail.gmail.com>
	<Pine.LNX.4.44L0.1009021723460.1311-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009021723460.1311-100000@iolanthe.rowland.org>
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

On Thu, Sep 2, 2010 at 2:34 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Thu, 2 Sep 2010, Colin Cross wrote:
>
>> That would work, but I still don't see why it's better. =A0With either
>> of your changes, the power.completion variable is storing state, and
>> not just used for notification. =A0However, the exact meaning of that
>> state is unclear, especially during the transition from an aborted
>> suspend to resume, and the state is duplicating power.status. =A0Setting
>> it to complete in dpm_prepare is especially confusing, because at that
>> point nothing is completed, it hasn't even been started.
>
> The state being waited for varies from time to time and is only
> partially related to power.status. =A0Instead of using a completion I
> suppose we could have used a new "transition_complete" variable
> together with a waitqueue. =A0Would you prefer that? =A0It's effectively
> the same thing as a completion, but without the nice packaging already
> provided by the kernel.
No, that doesn't change anything.  What I'd prefer to see is a
wait_for_condition on the desired state of the parent.  As is,
power.completion means one thing during suspend (the device has
started, but not finished, suspending), and a different thing during
resume (the device has not finished resuming, and may not have started
resuming).  That difference is exactly what caused the bug - the
completion has to be set on init so that it is set before the device
starts suspend.

I'll send the complete_all on init patch, as it's the only way to fix
the problem given the current implementation of dpm_wait.
