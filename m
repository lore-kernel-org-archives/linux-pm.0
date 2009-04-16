From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 15 Apr 2009 17:34:43 -0700
Message-ID: <d6200be20904151734o738c7a5dx52a800b97ebc2708@mail.gmail.com>
References: <1239759692-28617-2-git-send-email-arve@android.com>
	<Pine.LNX.4.44L0.0904151112400.3072-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0904151112400.3072-100000@iolanthe.rowland.org>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2009/4/15 Alan Stern <stern@rowland.harvard.edu>:
> On Tue, 14 Apr 2009, [utf-8] Arve Hj=F8nnev=E5g wrote:
>
>> +Suspend blockers can be used to allow user-space to decide which keys s=
hould
>> +wake the full system up and turn the screen on.
>
> This sentence still grates on me. =A0For readers not familiar with the
> embedded/phone environment, it won't make any sense. =A0Furthermore the
> rest of the text below doesn't even mention the screen, which will
> cause readers to wonder why it is mentioned here.
>
>> =A0Use set_irq_wake or a platform
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
>
> How about replacing that first sentence with something like this:
>
> =A0 =A0 =A0 =A0In cell phones or other embedded systems where powering the
> =A0 =A0 =A0 =A0screen is a significant drain on the battery, suspend bloc=
kers
> =A0 =A0 =A0 =A0can be used to allow user-space to decide whether a keystr=
oke
> =A0 =A0 =A0 =A0received while the system is suspended should cause the sc=
reen
> =A0 =A0 =A0 =A0to be turned back on or allow the system to go back into
> =A0 =A0 =A0 =A0suspend.
>
> Then in the last section, say this:
>
> =A0 =A0 =A0- The user-space input-event thread returns from read. If it
> =A0 =A0 =A0 =A0determines that the key should leave the screen off, it
> =A0 =A0 =A0 =A0calls suspend_unblock on the process_input_events
> =A0 =A0 =A0 =A0suspend_blocker and then calls select or poll. =A0The syst=
em
> =A0 =A0 =A0 =A0will automatically suspend again, since now no suspend blo=
ckers
> =A0 =A0 =A0 =A0are active.
>

This sounds reasonable too me.

-- =

Arve Hj=F8nnev=E5g
