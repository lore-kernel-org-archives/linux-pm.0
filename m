From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sat, 7 Feb 2009 14:51:03 -0800
Message-ID: <d6200be20902071451k48dc7a13ybb8251b014a091b0@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<200902071956.32964.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902071956.32964.rjw@sisk.pl>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 7, 2009 at 10:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> If my understanding is correct, a wakelock is a mechanism that, if held, =
will
> prevent the system from (automatically) entering a sleep state, but why d=
o we
> need a number of such wakelocks instead of just one reference counter wit=
h the
> rule that (automatic) suspend can only happen if the counter is zero?

Using wakelocks instead of a global reference count ensures that your
request cannot be cleared by someone else. It means that you can,
without knowing the current state of the lock, safely call wake_lock
when you know that you need the wakelock, and wake_unlock when you are
done. It allows wakelocks with timeouts and detailed stats.

> Then, code paths wanting to prevent the suspend from happening would only=
 need
> to increase the counter and it shouldn't be difficult to provide a user s=
pace
> interface for that.

No, but you would also need to provide way to decrement it, which
would allow user-space to override a request to stay awake in the
kernel or from another client.

>> +This works whether the wakelock is already held or not. It is useful if=
 the
>> +driver woke up other parts of the system that do not use wakelocks but
>> +still need to run. Avoid this when possible, since it will waste power
>> +if the timeout is long or may fail to finish needed work if the timeout=
 is
>> +short.
>
> And what's this call needed for?

It is needed to give code that do not use wakelocks a chance to run.
For instance we have not added wakelocks to the network stack. We also
use it in some places when passing data to untrusted userspace code.

> Is there a mechanism allowing us to see what wakelocks have been created =
by
> the user land?  Something like this would be useful for debugging.

/proc/wakelocks shows all wakelocks. It does not currently indicate if
a wakelock is from userspace, but if you are looking for a specific
lock it is easy to find. I can add a prefix to the name of all user
space wakelocks of you want.

>> +Do not use randomly generated wakelock names as there is no api to free
>> +a user-space wakelock.
>
> This appears to be very fragile.  Please rethink it.

I'm adding a /dev interface which removes this limitation.

>> +/* wake_lock_active returns a non-zero value if the wake_lock is curren=
tly
>> + * locked. If the wake_lock has a timeout, it does not check the timeou=
t,
>> + * but if the timeout had already expired when it was checked elsewhere
>> + * this function will return 0.
>> + */
>> +int wake_lock_active(struct wake_lock *lock);
>
> What's the purpose of this function?

It is used by our alarm driver to abort suspend.

>> +/* has_wake_lock returns 0 if no wake locks of the specified type are a=
ctive,
>> + * and non-zero if one or more wake locks are held. Specifically it ret=
urns
>> + * -1 if one or more wake locks with no timeout are active or the
>> + * number of jiffies until all active wake locks time out.
>> + */
>> +long has_wake_lock(int type);
>
> And this?

It is used to abort suspend. Currently when freezing processes, but it
could also be called between each driver suspend call to improve
wakeup latency when a wakelock is locked while suspending.

We also use it (with WAKE_LOCK_IDLE) to select the idle sleep mode.

-- =

Arve Hj=F8nnev=E5g
