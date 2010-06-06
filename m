From: david@lang.hm
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 04:14:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1006060410050.17462__39143.0774856873$1275823039$gmane$org@asgard.lang.hm>
References: <20100603193045.GA7188@elte.hu> <20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
	<AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg_@mail.gmail.com>
	<AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
	<AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com>
	<AANLkTilQ1k78dDCYadOa1Wiyjm2nsBcRpxwdpGvYcf8z@mail.gmail.com>
	<AANLkTin7oM3gVwHbIHWqYV8yeC6bbQ4q2jDDxAgz3DwQ@mail.gmail.com>
	<alpine.DEB.2.01.1006060305060.17462@asgard.lang.hm>
	<AANLkTinW-X5m85rUcqP-lrEdfBikVclJWgqiWDkpxnAc@mail.gmail.com>
	<20100606124949.539fa636@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100606124949.539fa636@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Jun 2010, Florian Mickler wrote:

> On Sun, 6 Jun 2010 12:19:08 +0200
> Vitaly Wool <vitalywool@gmail.com> wrote:
>
>> 2010/6/6  <david@lang.hm>:
>>
>>> as an example (taken from this thread).
>>>
>>> system A needs to wake up to get a battery reading, store it and go back to
>>> sleep, It does so every 10 seconds. But when it does so it only runs the one
>>> process and then goes back to sleep.
>>>
>>> system B has the same need, but wakes up every 10 minutes. but when it does
>>> so it fully wakes up and this allows the mail app to power up the radio,
>>> connect to the Internet and start checking for new mail before oppurtunistic
>>> sleep shuts things down (causing the mail check to fail)
>>>
>>> System A will last considerably longer on a battery than System B.
>>
>> Exactly, thanks for pointing out the specific example :)
>>
>> ~Vitaly
>
> This does not affect suspend_blockers nor does suspend_blockers
> interfere with that.
>
> Suspend_blockers allow the system to suspend ("mem">/sys/power/state
> suspend), when the userspace decides that the device is not in use.
>
> So implementing suspend_blockers support does not impact any
> optimizations done to either system A nor system B.

Actually, it does.

system A is what's being proposed by kernel developers, where the 
untrusted stuff is in a different cgroup and what puts the system to sleep 
is 'normal' power management. It doesn't sleep as long, but when it wakes 
up the untrusted stuff is still frozen, so it doesn't stay awake long, or 
do very much.

System B is suspend blockers where you are either awake or asleep, and 
when you wake up you wake up fully, but oppertunistic sleep can interrupt 
untrusted processes at any time. The system sleeps longer (as fewer things 
can wake it), but when it wakes up it's fully awake.

David Lang
