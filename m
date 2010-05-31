From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 02:43:01 -0700
Message-ID: <AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc__23907.7317681678$1275299053$gmane$org@mail.gmail.com>
References: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
	<Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

2010/5/29 Alan Stern <stern@rowland.harvard.edu>:
> On Sat, 29 May 2010, Arve Hj=F8nnev=E5g wrote:
>
>> > In place of in-kernel suspend blockers, there will be a new type of QoS
>> > constraint -- call it QOS_EVENTUALLY. =A0It's a very weak constraint,
>> > compatible with all cpuidle modes in which runnable threads are allowed
>> > to run (which is all of them), but not compatible with suspend.
>> >
>> This sound just like another API rename. It will work, but given that
>> suspend blockers was the name least objectionable last time around,
>> I'm not sure what this would solve.
>
> It's not just a rename. =A0By changing this into a QoS constraint, we
> make it more generally useful. =A0Instead of standing on its own, it
> becomes part of the PM-QOS framework.
>

We cannot use the existing pm-qos framework. It is not safe to call
from atomic context. Also, it does not have any state constraints, so
it iterates over every registered constraint each time one of them
changes. Nor does is currently provide any stats for debugging.

The original wakelock patchset supported a wakelock type so it could
be used to block more then suspend, but I had to remove this because
it "overlapped" with pm-qos. So, yes I do consider this just another
rename.

>> > There is no /sys/power/policy file. =A0In place of opportunistic suspe=
nd,
>> > we have "QoS-based suspend". =A0This is initiated by userspace writing
>> > "qos" to /sys/power/state, and it is very much like suspend-to-RAM.
>>
>> Why do you want to tie it to a specific state?
>
> I don't. =A0I suggested making it a veriant of suspend-to-RAM merely
> because that's what you were using. =A0But Nigel's suggestion of having
> "qos" variants of all the different suspend states makes sense.
>
>> > However a QoS-based suspend fails immediately if there are any active
>>
>> Fail or block? Your next paragraph said that it blocks for
>> QOS_EVENTUALLY, but if normal constraints fail, you are still stuck in
>> a retry loop.
>
> Normal (i.e., non QOS_EVENTUALLY) constraints aren't part of the
> Android use case, so it wasn't clear how they should be treated. =A0On
> further thought, it probably makes more sense to block for them too
> instead of failing immediately.
>
>> > normal QoS constraints incompatible with system suspend, in other
>> > words, any constraints requiring a throughput > 0 or an interrupt
>> > latency shorter than the time required for a suspend-to-RAM/resume
>> > cycle.
>> >
>> > If no such constraints are active, the QoS-based suspend blocks in an
>> > interruptible wait until the number of active QOS_EVENTUALLY
>>
>> How do you implement this?
>
> I'm not sure what you mean. =A0The same way you implement any
> interruptible wait.
>

I mean what should it wait on so that it gets interrupted by a
userspace ipc call. I guess you want to send a signal in addition to
the ipc. I still don't know why you want to do it this way though. It
seems much simpler to just return immedeately and allow the same
thread to cancel the request with another write.

>> > =A0 =A0 =A0 =A0for (;;) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (any IPC requests remain)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handle them;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (any processes need to prevent suspe=
nd)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write "qos" to /sys/pow=
er/state;
>> > =A0 =A0 =A0 =A0}
>> >
>> > The idea is that receipt of a new IPC request will cause a signal to be
>> > sent, interrupting the sleep or the "qos" write.
>>
>> What happen if the signal is right before (or even right after)
>> calling write "qos". How does the signal handler stop the write?
>
> You're right, this is a serious problem. =A0The process would have to
> give the kernel a signal mask to be used during the wait, as in ppoll
> or pselect. =A0There ought to be a way to do this or something
> equivalent.
>
> Alan Stern
>
>



-- =

Arve Hj=F8nnev=E5g
