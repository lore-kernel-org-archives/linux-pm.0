From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 20 Apr 2009 21:44:54 -0700
Message-ID: <d6200be20904202144u4c7d199fq9c0bb20f67c94d38@mail.gmail.com>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<1239759692-28617-2-git-send-email-arve@android.com>
	<20090420092905.GB8873@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090420092905.GB8873@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 20, 2009 at 2:29 AM, Pavel Machek <pavel@ucw.cz> wrote:

>> +When the driver determines that it needs to run (usually in an interrupt
>> +handler) it calls suspend_block:
>> + =A0 =A0 suspend_block(&state->suspend_blocker);
>> +
>> +When it no longer needs to run it calls suspend_unblock:
>> + =A0 =A0 suspend_unblock(&state->suspend_blocker);
>
> Sounds reasonably sane. Maybe it should be block_suspend(), because
> suspend_block() sounds like... something that builds suspend, but I
> guess it is good enough.
>

I was trying to keep a common prefix.

>> +/* A suspend_blocker prevents the system from entering suspend when act=
ive.
>> + */
>> +
>
> linuxdoc?
>
>> +struct suspend_blocker {
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> + =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0flags;
>> + =A0 =A0 const char =A0 =A0 =A0 =A0 *name;
>> +#endif
>> +};
>> +
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> +
>> +void suspend_blocker_init(struct suspend_blocker *blocker, const char *=
name);
>> +void suspend_blocker_destroy(struct suspend_blocker *blocker);
>> +void suspend_block(struct suspend_blocker *blocker);
>> +void suspend_unblock(struct suspend_blocker *blocker);
>> +
>> +/* is_blocking_suspend returns true if the suspend_blocker is currently=
 active.
>> + */
>> +bool is_blocking_suspend(struct suspend_blocker *blocker);
>
> Same here?

I moved this to the c file, see diff below.

>
>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> index 23bd4da..9d1df13 100644
>> --- a/kernel/power/Kconfig
>> +++ b/kernel/power/Kconfig
>> @@ -116,6 +116,16 @@ config SUSPEND_FREEZER
>>
>> =A0 =A0 =A0 =A0 Turning OFF this setting is NOT recommended! If in doubt=
, say Y.
>>
>> +config SUSPEND_BLOCK
>> + =A0 =A0 bool "Suspend block"
>> + =A0 =A0 depends on PM
>> + =A0 =A0 select RTC_LIB
>
> Is RTC_LIB okay to select?

It should be. It cannot be enabled manually.

>> @@ -392,6 +393,9 @@ static void suspend_finish(void)
>>
>>
>> =A0static const char * const pm_states[PM_SUSPEND_MAX] =3D {
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> + =A0 =A0 [PM_SUSPEND_ON] =A0 =A0 =A0 =A0 =3D "on",
>> +#endif
>> =A0 =A0 =A0 [PM_SUSPEND_STANDBY] =A0 =A0=3D "standby",
>> =A0 =A0 =A0 [PM_SUSPEND_MEM] =A0 =A0 =A0 =A0=3D "mem",
>> =A0};
>
> This allows you to write "on" to the other interfaces where that makes
> no sense.... right?

state_store starts iterating at PM_SUSPEND_STANDBY, so don't think so.

>
>> +static bool enable_suspend_blockers;
>
> Uhuh... What is this good for... except debugging?

It prevents suspend blockers from affecting existing suspend and
freezing interfaces (while auto suspend is not active).

>
>> +bool suspend_is_blocked(void)
>> +{
>> + =A0 =A0 if (WARN_ONCE(!enable_suspend_blockers, "ignoring suspend bloc=
kers\n"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 return !!atomic_read(&suspend_block_count);
>> +}
>
> Yes, if enable_suspend_blockers is one, we are in deep trouble.

It just means that you compiled suspend blocker support into the
kernel, but used an old interface to enter suspend. It warns if
enable_suspend_blockers is 0 not 1.

>
>> +/**
>> + * suspend_blocker_init() - Initialize a suspend blocker
>> + * @blocker: The suspend blocker to initialize.
>> + * @name: =A0 =A0The name of the suspend blocker to show in
>> + * =A0 =A0 =A0 =A0 =A0 /proc/suspend_blockers
>
> I don't think suspend_blockers should go to /proc. They are not process-r=
elated.

I moved that comment to the stats patch. It is still in procfs though,
as it is most similar to other procfs entries. It is not allowed under
the sysfs rules, and we do not want to enable debugfs on a production
system since it exposes some unsafe interfaces.

>
>> +/**
>> + * suspend_block() - Block suspend
>> + * @blocker: The suspend blocker to use
>> + */
>> +void suspend_block(struct suspend_blocker *blocker)
>> +{
>> + =A0 =A0 BUG_ON(!(atomic_read(&blocker->flags) & SB_INITIALIZED));
> As blocker->flags seem to be used mostly for debugging; do they have
> to use "atomic"? Normally, "magic" variable is used, instead. (Single
> bit is probably not enough to guard against using uninitialized
> memory.)

It is mostly used to determine if the suspend blocker is already
active, so yes it has to be atomic. I could add a magic value, but a
single bit is enough to catch uninitialized global and kzalloced
members.

>
>> + * suspend_unblock() - Unblock suspend
>> + * @blocker: The suspend blocker to unblock.
>> + *
>> + * If no other suspend blockers block suspend, the system will suspend.
>> + */
>> +void suspend_unblock(struct suspend_blocker *blocker)
>> +{
>
> ...BUG_ON(!(atomic_read(&blocker->flags) & SB_INITIALIZED)); ?

Perhaps. This function does not do anything unless you have already
called suspend_block though.

>
>> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND_BLOCKER)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend_unblock: %s\n", blocker->name=
);
>> +
>> + =A0 =A0 if (atomic_cmpxchg(&blocker->flags, SB_INITIALIZED | SB_ACTIVE,
>> + =A0 =A0 =A0 =A0 SB_INITIALIZED) =3D=3D (SB_INITIALIZED | SB_ACTIVE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_dec_and_test(&suspend_block_count))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_work(suspend_work_queue,=
 &suspend_work);
>> +}
>> +EXPORT_SYMBOL(suspend_unblock);
>
> Uhuh... can we "loose a oportunity to suspend" here? If someone is
> just updating the flags...? Is it guaranteed that if two people do
> suspend_unblock at the same time, one of them will pass?

What do you mean by just updating the flags? SB_ACTIVE was either
cleared or not, if it was, then atomic_dec_and_test is called.

>
>> +void request_suspend_state(suspend_state_t state)
>> +{
>> + =A0 =A0 unsigned long irqflags;
>> + =A0 =A0 spin_lock_irqsave(&state_lock, irqflags);
>> + =A0 =A0 if (debug_mask & DEBUG_USER_STATE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct timespec ts;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct rtc_time tm;
>> + =A0 =A0 =A0 =A0 =A0 =A0 getnstimeofday(&ts);
>> + =A0 =A0 =A0 =A0 =A0 =A0 rtc_time_to_tm(ts.tv_sec, &tm);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("request_suspend_state: %s (%d->%d) at=
 %lld "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%d-%02d-%02d %02d:%02d:%02d.=
%09lu UTC)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state !=3D PM_SUSPEND_ON ? "sl=
eep" : "wakeup",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 requested_suspend_state, state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ktime_to_ns(ktime_get()),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm.tm_year + 1900, tm.tm_mon +=
 1, tm.tm_mday,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm.tm_hour, tm.tm_min, tm.tm_s=
ec, ts.tv_nsec);
>
> Introduce macro for printing time?

OK.

-- =

Arve Hj=F8nnev=E5g

----
diff --git a/Documentation/power/suspend-blockers.txt
b/Documentation/power/suspend-blockers.txt
index 743b870..e95a507 100644
--- a/Documentation/power/suspend-blockers.txt
+++ b/Documentation/power/suspend-blockers.txt
@@ -10,10 +10,14 @@ interrupt handler or a freezeable thread always
works, but if you call
 block_suspend from a sysdev suspend handler you must also return an error =
from
 that handler to abort suspend.

-Suspend blockers can be used to allow user-space to decide which keys shou=
ld
-wake the full system up and turn the screen on. Use set_irq_wake or a plat=
form
-specific api to make sure the keypad interrupt wakes up the cpu. Once
the keypad
-driver has resumed, the sequence of events can look like this:
+In cell phones or other embedded systems where powering the screen is a
+significant drain on the battery, suspend blockers can be used to allow
+user-space to decide whether a keystroke received while the system is susp=
ended
+should cause the screen to be turned back on or allow the system to
go back into
+suspend. Use set_irq_wake or a platform specific api to make sure the keyp=
ad
+interrupt wakes up the cpu. Once the keypad driver has resumed, the sequen=
ce of
+events can look like this:
+
 - The Keypad driver gets an interrupt. It then calls suspend_block on the
   keypad-scan suspend_blocker and starts scanning the keypad matrix.
 - The keypad-scan code detects a key change and reports it to the input-ev=
ent
@@ -27,9 +31,11 @@ driver has resumed, the sequence of events can look
like this:
   on the input-event device.
 - The input-event driver dequeues the key-event and, since the queue is now
   empty, it calls suspend_unblock on the input-event-queue suspend_blocker.
-- The user-space input-event thread returns from read. It determines that =
the
-  key should not wake up the full system, calls suspend_unblock on the
-  process-input-events suspend_blocker and calls select or poll.
+- The user-space input-event thread returns from read. If it determines th=
at
+  the key should leave the screen off, it calls suspend_unblock on the
+  process_input_events suspend_blocker and then calls select or poll. The
+  system will automatically suspend again, since now no suspend blockers a=
re
+  active.

                  Key pressed   Key released
                      |             |
diff --git a/include/linux/suspend_block.h b/include/linux/suspend_block.h
index 7820c60..54bf9c4 100755
--- a/include/linux/suspend_block.h
+++ b/include/linux/suspend_block.h
@@ -16,7 +16,15 @@
 #ifndef _LINUX_SUSPEND_BLOCK_H
 #define _LINUX_SUSPEND_BLOCK_H

-/* A suspend_blocker prevents the system from entering suspend when active.
+/**
+ * struct suspend_blocker - the basic suspend_blocker structure
+ * @flags:     Tracks initialized and active state.
+ * @name:      Name used for debugging.
+ *
+ * When a suspend_blocker is active it prevents the system from entering
+ * suspend.
+ *
+ * The suspend_blocker structure must be initialized by suspend_blocker_in=
it()
  */

 struct suspend_blocker {
@@ -32,17 +40,7 @@ void suspend_blocker_init(struct suspend_blocker
*blocker, const char *name);
 void suspend_blocker_destroy(struct suspend_blocker *blocker);
 void suspend_block(struct suspend_blocker *blocker);
 void suspend_unblock(struct suspend_blocker *blocker);
-
-/* is_blocking_suspend returns true if the suspend_blocker is currently ac=
tive.
- */
 bool is_blocking_suspend(struct suspend_blocker *blocker);
-
-/* suspend_is_blocked can be used by generic power management code to abort
- * suspend.
- *
- * To preserve backward compatibility suspend_is_blocked returns 0 unless =
it
- * is called during suspend initiated from the suspend_block code.
- */
 bool suspend_is_blocked(void);

 #else
diff --git a/kernel/power/suspend_block.c b/kernel/power/suspend_block.c
index b4f2191..1adf075 100644
--- a/kernel/power/suspend_block.c
+++ b/kernel/power/suspend_block.c
@@ -41,6 +41,27 @@ struct suspend_blocker main_suspend_blocker;
 static suspend_state_t requested_suspend_state =3D PM_SUSPEND_MEM;
 static bool enable_suspend_blockers;

+#define pr_info_time(fmt, args...) \
+       do { \
+               struct timespec ts; \
+               struct rtc_time tm; \
+               getnstimeofday(&ts); \
+               rtc_time_to_tm(ts.tv_sec, &tm); \
+               pr_info(fmt "(%d-%02d-%02d %02d:%02d:%02d.%09lu UTC)\n" , \
+                       args, \
+                       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, \
+                       tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec); \
+       } while (0);
+
+/**
+ * suspend_is_blocked() - Check if suspend should be blocked
+ *
+ * suspend_is_blocked can be used by generic power management code to abort
+ * suspend.
+ *
+ * To preserve backward compatibility suspend_is_blocked returns 0 unless =
it
+ * is called during suspend initiated from the suspend_block code.
+ */
 bool suspend_is_blocked(void)
 {
        if (WARN_ONCE(!enable_suspend_blockers, "ignoring suspend blockers\=
n"))
@@ -66,16 +87,8 @@ retry:
        if (debug_mask & DEBUG_SUSPEND)
                pr_info("suspend: enter suspend\n");
        ret =3D pm_suspend(requested_suspend_state);
-       if (debug_mask & DEBUG_EXIT_SUSPEND) {
-               struct timespec ts;
-               struct rtc_time tm;
-               getnstimeofday(&ts);
-               rtc_time_to_tm(ts.tv_sec, &tm);
-               pr_info("suspend: exit suspend, ret =3D %d "
-                       "(%d-%02d-%02d %02d:%02d:%02d.%09lu UTC)\n", ret,
-                       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-                       tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
-       }
+       if (debug_mask & DEBUG_EXIT_SUSPEND)
+               pr_info_time("suspend: exit suspend, ret =3D %d ", ret);
        if (atomic_read(&current_event_num) =3D=3D entry_event_num) {
                if (debug_mask & DEBUG_SUSPEND)
                        pr_info("suspend: pm_suspend returned with no event=
\n");
@@ -105,8 +118,7 @@ static struct sys_device suspend_block_sysdev =3D {
 /**
  * suspend_blocker_init() - Initialize a suspend blocker
  * @blocker:   The suspend blocker to initialize.
- * @name:      The name of the suspend blocker to show in
- *             /proc/suspend_blockers
+ * @name:      The name of the suspend blocker to show in debug messages.
  */
 void suspend_blocker_init(struct suspend_blocker *blocker, const char *nam=
e)
 {
@@ -178,6 +190,8 @@ EXPORT_SYMBOL(suspend_unblock);
 /**
  * is_blocking_suspend() - Test if a suspend blocker is blocking suspend
  * @blocker:   The suspend blocker to check.
+ *
+ * Returns true if the suspend_blocker is currently active.
  */
 bool is_blocking_suspend(struct suspend_blocker *blocker)
 {
@@ -189,19 +203,11 @@ void request_suspend_state(suspend_state_t state)
 {
        unsigned long irqflags;
        spin_lock_irqsave(&state_lock, irqflags);
-       if (debug_mask & DEBUG_USER_STATE) {
-               struct timespec ts;
-               struct rtc_time tm;
-               getnstimeofday(&ts);
-               rtc_time_to_tm(ts.tv_sec, &tm);
-               pr_info("request_suspend_state: %s (%d->%d) at %lld "
-                       "(%d-%02d-%02d %02d:%02d:%02d.%09lu UTC)\n",
-                       state !=3D PM_SUSPEND_ON ? "sleep" : "wakeup",
-                       requested_suspend_state, state,
-                       ktime_to_ns(ktime_get()),
-                       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-                       tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
-       }
+       if (debug_mask & DEBUG_USER_STATE)
+               pr_info_time("request_suspend_state: %s (%d->%d) at %lld ",
+                            state !=3D PM_SUSPEND_ON ? "sleep" : "wakeup",
+                            requested_suspend_state, state,
+                            ktime_to_ns(ktime_get()));
        requested_suspend_state =3D state;
        if (state =3D=3D PM_SUSPEND_ON)
                suspend_block(&main_suspend_blocker);
