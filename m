From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 00:37:48 -0700
Message-ID: <AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44__25054.6128642329$1275637181$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100604071354.GA14451@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 4, 2010 at 12:13 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Arve Hj?nnev?g <arve@android.com> wrote:
>
>> On Thu, Jun 3, 2010 at 4:23 PM, Ingo Molnar <mingo@elte.hu> wrote:
>> ...
>> > ?- Controlled auto-suspend: drivers (such as input) could on wakeup
>> > ? automatically set the 'minimum wakeup latency' value of wakee tasks =
to a
>> > ? lower value. This automatically prevents another auto-suspend in the=
 near
>> > ? future: up to the point the wakee task increases its latency (via the
>> > ? scheduler syscall) again and allows suspend again.
>> >
>>
>> How do you clear the latency value in a safe way? If another wakeup event
>> happens right after your wakee task is done processing the last event and
>> decides to increase its latency, auto suspend will be allowed even though
>> you have an unprocessed wakeup event. Also how do you know which task wi=
ll
>> read the event if it is not already waiting for it?
>
> The easiest solution would be to not do any of that initially. (If it's e=
ver a
> concern we could subtract/add without destroying the nesting property)
>
> Why do you need to track input wakeups? It's rather fragile and rather

Because we have keys that should always turn the screen on, but the
problem is not specific to input events. If we enabled a wakeup event
it usually means we need this event to always work, not just when the
system is fully awake or fully suspended.

> unnecessary - the idle drivers know it very well how to not go into the
> deepest idle mode already today. We wont hit C8 on laptops when you are u=
sing
> the desktop.
>

The whole point allow the use of suspend.

>> > ? This means there will be no surprise suspends for a task that may ta=
ke a
>> > ? bit longer than usual to finish its work. [ Detail: this would only =
be done
>> > ? for tasks that have a non-default (non-infinity) task->latency value=
 - to
>> > ? prevent the input driver from lowering latency values (and preventing
>> > ? future suspends) just because some unaware apps are running and usin=
g input
>> > ? drivers. ]
>>
>> Don't you need two inifinity values for this?
>
> Yes - any value above the max idle latency in the system will do.
>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>



-- =

Arve Hj=F8nnev=E5g
