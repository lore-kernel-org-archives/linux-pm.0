From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 29 Apr 2009 16:45:04 -0700
Message-ID: <d6200be20904291645p22d76371ne960dfb34a23b32d@mail.gmail.com>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<1239759692-28617-2-git-send-email-arve@android.com>
	<200904300034.09837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904300034.09837.rjw@sisk.pl>
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

2009/4/29 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 15 April 2009, Arve Hj=F8nnev=E5g wrote:
>> diff --git a/Documentation/power/suspend-blockers.txt b/Documentation/po=
wer/suspend-blockers.txt
>> new file mode 100644
>> index 0000000..743b870
>> --- /dev/null
>> +++ b/Documentation/power/suspend-blockers.txt
>> @@ -0,0 +1,76 @@
>> +Suspend blockers
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +A suspend_blocker prevents the system from entering suspend.
>
> I'd say "suspend blocker", without the underscore.
>
> Also, I'd try to provide a general explanation of how this is supposed to
> work here, as an introduction. =A0Something like:
>
> "Suspend blockers provide a mechanism allowing device drivers and user
> space processes to prevent the system from entering a sleep state, such as
> the ACPI S3 state.
>
> To use a suspend blocker, a device driver needs a struct suspend_blocker =
object
> that has to be initialized with the help of suspend_blocker_init(). =A0Wh=
en no
> longer needed, the suspend blocker must be garbage collected with the help
> of suspend_blocker_destroy().
>
> A suspend blocker is activated using suspend_block(), which prevents the
> system from entering any sleep state until the suspend blocker is deactiv=
ated
> with suspend_unblock(). =A0Many suspend blockers may be used simultaneous=
ly
> and the system is prevented from entering sleep states as long as at leas=
t one
> of them is active."
>

I added most of this, see new text below.

> BTW, I don't really like the names "suspend_block" and "suspend_unblock".
> See below for possible alternatives.
>
>> +If the suspend operation has already started when calling suspend_block=
 on a
>> +suspend_blocker, it will abort the suspend operation as long it has not=
 already
>> +reached the sysdev suspend stage. This means that calling suspend_block=
 from an
>> +interrupt handler or a freezeable thread always works, but if you call
>> +block_suspend
>
> Surely suspend_block() ?

Yes.

>
>> from a sysdev suspend handler you must also return an error from
>> +that handler to abort suspend.
>
> Well, if a sysdev suspend handler returns an error code, suspend will be
> aborted anyway, so I'm not sure what the point in using suspend blockers =
from
> sysdev suspend handlers really is. =A0Perhaps it's better to say "don't u=
se
> suspend blockers from withing sysdev suspend handlers"?

You still need the suspend blocker to prevent the system from trying
to enter suspend again. I changed the text to "to abort a suspend
sequence that was already started".

>
>> +
>
> I'd say "For example" here.
>
>> +Suspend blockers can be used to allow user-space to decide which keys s=
hould
>> +wake the full system up and turn the screen on. Use set_irq_wake or a p=
latform
>> +specific api to make sure the keypad interrupt wakes up the cpu. Once t=
he keypad
>> +driver has resumed, the sequence of events can look like this:
>> +- The Keypad driver gets an interrupt. It then calls suspend_block on t=
he
>> + =A0keypad-scan suspend_blocker and starts scanning the keypad matrix.
>> +- The keypad-scan code detects a key change and reports it to the input=
-event
>> + =A0driver.
>> +- The input-event driver sees the key change, enqueues an event, and ca=
lls
>> + =A0suspend_block on the input-event-queue suspend_blocker.
>> +- The keypad-scan code detects that no keys are held and calls suspend_=
unblock
>> + =A0on the keypad-scan suspend_blocker.
>> +- The user-space input-event thread returns from select/poll, calls
>> + =A0suspend_block on the process-input-events suspend_blocker and then =
calls read
>> + =A0on the input-event device.
>> +- The input-event driver dequeues the key-event and, since the queue is=
 now
>> + =A0empty, it calls suspend_unblock on the input-event-queue suspend_bl=
ocker.
>> +- The user-space input-event thread returns from read. It determines th=
at the
>> + =A0key should not wake up the full system, calls suspend_unblock on the
>> + =A0process-input-events suspend_blocker and calls select or poll.
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Key pressed =A0 Key released
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 |
>> +keypad-scan =A0 =A0 =A0 =A0 =A0++++++++++++++++++
>> +input-event-queue =A0 =A0 =A0 =A0+++ =A0 =A0 =A0 =A0 =A0+++
>> +process-input-events =A0 =A0 =A0 +++ =A0 =A0 =A0 =A0 =A0+++
>> +
>> +
>> +Driver API
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +A driver can use the suspend block api by adding a suspend_blocker vari=
able to
>> +its state and calling suspend_blocker_init. For instance:
>> +struct state {
>> + =A0 =A0 struct suspend_blocker suspend_blocker;
>> +}
>> +
>> +init() {
>> + =A0 =A0 suspend_blocker_init(&state->suspend_blocker, "suspend-blocker=
-name");
>> +}
>> +
>> +Before freeing the memory, suspend_blocker_destroy must be called:
>> +
>> +uninit() {
>> + =A0 =A0 suspend_blocker_destroy(&state->suspend_blocker);
>> +}
>> +
>> +When the driver determines that it needs to run (usually in an interrupt
>> +handler) it calls suspend_block:
>> + =A0 =A0 suspend_block(&state->suspend_blocker);
>
> suspend_blocker_activate() ?
> suspend_blocker_enable() ?
> suspend_blocker_start() ?
>

I don't like any of those better than suspend_block, but if there is
some agreement on what it should be changed to, I'll change it.

>> +
>> +When it no longer needs to run it calls suspend_unblock:
>> + =A0 =A0 suspend_unblock(&state->suspend_blocker);
>
> suspend_blocker_deactivate() ?
> suspend_blocker_disable() ?
> suspend_blocker_finish() ?
>
>> +
>> +Calling suspend_block when the suspend blocker is active or suspend_unb=
lock when
>> +it is not active has no effect. This allows drivers to update their sta=
te and
>> +call suspend suspend_block or suspend_unblock based on the result.
>> +For instance:
>> +
>> +if (list_empty(&state->pending_work))
>> + =A0 =A0 suspend_unblock(&state->suspend_blocker);
>> +else
>> + =A0 =A0 suspend_block(&state->suspend_blocker);
>> +


-- =

Arve Hj=F8nnev=E5g


----

Suspend blockers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Suspend blockers provide a mechanism for device drivers and user-space proc=
esses
to prevent the system from entering suspend. Only suspend states requested
through /sys/power/request_state are prevented. Writing to /sys/power/state
will ignore suspend blockers, and sleep states entered from idle are unaffe=
cted.

To use a suspend blocker, a device driver needs a struct suspend_blocker ob=
ject
that has to be initialized with suspend_blocker_init. When no longer needed,
the suspend blocker must be destroyed with suspend_blocker_destroy.

A suspend blocker is activated using suspend_block, which prevents the syst=
em
from entering suspend until the suspend blocker is deactivated with
suspend_unblock. Many suspend blockers may be used simultaneously, and the
system is prevented from entering suspend as long as at least one of them is
active.

If the suspend operation has already started when calling suspend_block on a
suspend_blocker, it will abort the suspend operation as long it has not alr=
eady
reached the sysdev suspend stage. This means that calling suspend_block fro=
m an
interrupt handler or a freezeable thread always works, but if you call
suspend_block from a sysdev suspend handler you must also return an error f=
rom
that handler to abort a suspend sequence that was already started.

In cell phones or other embedded systems where powering the screen is a
significant drain on the battery, suspend blockers can be used to allow
user-space to decide whether a keystroke received while the system is suspe=
nded
should cause the screen to be turned back on or allow the system to go back=
 into
suspend. Use set_irq_wake or a platform specific api to make sure the keypad
interrupt wakes up the cpu. Once the keypad driver has resumed, the sequenc=
e of
events can look like this:

- The Keypad driver gets an interrupt. It then calls suspend_block on the
  keypad-scan suspend_blocker and starts scanning the keypad matrix.
- The keypad-scan code detects a key change and reports it to the input-eve=
nt
  driver.
- The input-event driver sees the key change, enqueues an event, and calls
  suspend_block on the input-event-queue suspend_blocker.
- The keypad-scan code detects that no keys are held and calls suspend_unbl=
ock
  on the keypad-scan suspend_blocker.
- The user-space input-event thread returns from select/poll, calls
  suspend_block on the process-input-events suspend_blocker and then calls =
read
  on the input-event device.
- The input-event driver dequeues the key-event and, since the queue is now
  empty, it calls suspend_unblock on the input-event-queue suspend_blocker.
- The user-space input-event thread returns from read. If it determines that
  the key should leave the screen off, it calls suspend_unblock on the
  process_input_events suspend_blocker and then calls select or poll. The
  system will automatically suspend again, since now no suspend blockers are
  active.

                 Key pressed   Key released
                     |             |
keypad-scan          ++++++++++++++++++
input-event-queue        +++          +++
process-input-events       +++          +++


Driver API
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A driver can use the suspend block api by adding a suspend_blocker variable=
 to
its state and calling suspend_blocker_init. For instance:
struct state {
        struct suspend_blocker suspend_blocker;
}

init() {
        suspend_blocker_init(&state->suspend_blocker, "suspend-blocker-name=
");
}

Before freeing the memory, suspend_blocker_destroy must be called:

uninit() {
        suspend_blocker_destroy(&state->suspend_blocker);
}

When the driver determines that it needs to run (usually in an interrupt
handler) it calls suspend_block:
        suspend_block(&state->suspend_blocker);

When it no longer needs to run it calls suspend_unblock:
        suspend_unblock(&state->suspend_blocker);

Calling suspend_block when the suspend blocker is active or suspend_unblock=
 when
it is not active has no effect. This allows drivers to update their state a=
nd
call suspend suspend_block or suspend_unblock based on the result.
For instance:

if (list_empty(&state->pending_work))
        suspend_unblock(&state->suspend_blocker);
else
        suspend_block(&state->suspend_blocker);
