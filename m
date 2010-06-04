From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 01:56:33 -0700
Message-ID: <AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd__8796.0665034645$1275641866$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100604083423.GD15181@elte.hu>
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

On Fri, Jun 4, 2010 at 1:34 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Arve Hj?nnev?g <arve@android.com> wrote:
>
>> > [...]
>> >
>> > Why do you need to track input wakeups? It's rather fragile and rather
>> > unnecessary [...]
>>
>> Because we have keys that should always turn the screen on, but the prob=
lem
>> is not specific to input events. If we enabled a wakeup event it usually
>> means we need this event to always work, not just when the system is ful=
ly
>> awake or fully suspended.
>
> Hm, i cannot follow that generic claim. Could you please point out the pr=
oblem
> to me via a specific example? Which task does what, what undesirable thing
> happens where, etc.
>

We have many wakeup events, and some of them are invisible to the
user. For instance on the Nexus One wake up every 10 minutes monitor
the battery health. If the user presses a key right after this work
has finished and we did not block suspend until userspace could
process this key event, we risk suspending before we could turn the
screen on, which to the user looks like the key did not work. Another
example, the user pressed the power key which turns the screen off and
allows suspend. We initiate suspend and a phone call comes in. If we
don't block suspend until we processed the incoming phone call
notification, the phone may never ring (some devices will send a new
message every few seconds for this, so on those devices it would just
delay the ringing).

-- =

Arve Hj=F8nnev=E5g
