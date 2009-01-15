From: "=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=" <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Wed, 14 Jan 2009 20:42:54 -0800
Message-ID: <d6200be20901142042n5aa6384al936e49f5bce8256e@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231923681.7229.244.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1231923681.7229.244.camel@nigel-laptop>
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

On Wed, Jan 14, 2009 at 1:01 AM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
> Would you be able to provide some more documentation?

Would something like this help:
Documentation/power/wakelocks.txt

Wakelocks
=3D=3D=3D=3D=3D=3D=3D=3D=3D

A wake_lock prevents the system from entering suspend or other low power
states when active. If the type is set to WAKE_LOCK_SUSPEND, the wake_lock
prevents a full system suspend. If the type is WAKE_LOCK_IDLE, low power
states that cause large interrupt latencies or that disable a set of
interrupts will not entered from idle until the wake_locks are released.


Driver API
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A driver can use the wakelock api by adding a wakelock variable to its state
and calling wake_lock_init. For instance:
struct state {
        struct wakelock wakelock;
}

init() {
        wake_lock_init(&state->wakelock, WAKE_LOCK_SUSPEND, "wakelockname");
}

Before freeing the memory wake_lock_destroy must be called:

uninit() {
        wake_lock_destroy(&state->wakelock);
}

When the driver determines that it needs to run (usually in an interrupt
handler) it calls wake_lock:
        wake_lock(&state->wakelock);

When it no longer needs to run it calls wake_unlock:
        wake_unlock(&state->wakelock);

It can also call wake_lock_timeout to release the wakelock after a delay:
        wake_lock_timeout(&state->wakelock, HZ);

This works whether the wake_lock is already held or not. It is useful if the
driver woke up other parts of the system that does not use wakelocks but
still need to run. Avoid this when possible, since it will waste power
if the timeout is long or may fail to finish needed work if the timeout is
short.


User-space API
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Write "lockname" or "lockname timeout" to /sys/power/wake_lock lock and if
needed create a wake lock. The timeout here is specified nanoseconds.
Write "lockname" to /sys/power/wake_unlock to unlock a user wake lock.

Do not use randomly generated wakelock names as there is no api to free
a userspace wakelock.



-- =

Arve Hj=F8nnev=E5g
