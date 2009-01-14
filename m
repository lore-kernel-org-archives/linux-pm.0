From: "=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=" <arve@android.com>
Subject: Re: [PATCH 01/11] PM: Add wake lock api.
Date: Wed, 14 Jan 2009 15:07:32 -0800
Message-ID: <d6200be20901141507y4b230262i3c4c946c41b0c7db@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231924178.7229.261.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1231924178.7229.261.camel@nigel-laptop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 14, 2009 at 1:09 AM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
>> +/* A wake_lock prevents the system from entering suspend or other low p=
ower
>> + * states when active. If the type is set to WAKE_LOCK_SUSPEND, the wak=
e_lock
>> + * prevents a full system suspend. If the type is WAKE_LOCK_IDLE, low p=
ower
>
> Does this include hibernation? If so, you might like to say 'sleep'
> instead of suspend.
>

Not as it is currently implemented, but it probably should. The main
reason I avoid saying 'sleep' is that we enter cpu sleep modes from
idle as well.

>> + * states that cause large interrupt latencies or that disable a set of
>> + * interrupts will not entered from idle until the wake_locks are relea=
sed.
>
> This makes me wonder if 'wake_locks' is an appropriate name - you're
> locking against sleeping rather than waking.
>

It depends on how you look at it. We lock the system in the wake
state, or we lock against the suspend/sleep state. I have also seen
the term sleep vote used for a very similar mechanism, but I don't
like this either as a sleep vote is a veto against sleep.
I initially called it a suspend lock, then wake lock in user space.
Wake lock is the term that stuck so I changed the kernel api to use
it.

>
> If CONFIG_HAS_WAKELOCK and CONFIG_WAKELOCK_STAT are both off, you've got
> an empty struct wake_lock definition. It wouldn't have any users, would
> it? (And therefore doesn't need to be defined at all).
>

I do this to avoid #ifdefs on CONFIG_HAS_WAKELOCK in the drivers.

>> +/* wake_lock_active returns a non-zero value if the wake_lock is curren=
tly
>> + * locked. If the wake_lock has a timeout, it does not check the timeout
>> + * but if the timeout had aready been checked it will return 0.
>
> s/aready/already/
>
> What does it mean for the timeout to already have been checked? Is that
> the same as the timeout having already expired?
>

What I meant was that the wake lock had been checked and deactivated
from another code-path, after the timeout expired.


-- =

Arve Hj=F8nnev=E5g
