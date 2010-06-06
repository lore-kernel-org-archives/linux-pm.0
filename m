From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 17:47:10 +0200
Message-ID: <AANLkTilOq_5yUW1AIMH1qSE699gyRUTlzGPUVc4CrReY__45081.9798782051$1275839295$gmane$org@mail.gmail.com>
References: <1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
	<AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg_@mail.gmail.com>
	<AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
	<AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com>
	<AANLkTilQ1k78dDCYadOa1Wiyjm2nsBcRpxwdpGvYcf8z@mail.gmail.com>
	<AANLkTin7oM3gVwHbIHWqYV8yeC6bbQ4q2jDDxAgz3DwQ@mail.gmail.com>
	<20100606133130.GA8513@srcf.ucam.org>
	<AANLkTimXTgZS_fZQa8hjIptJrCn756gF_xakT1IQiLWa@mail.gmail.com>
	<20100606152946.GA11351@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100606152946.GA11351@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/6/6 Matthew Garrett <mjg59@srcf.ucam.org>:
> On Sun, Jun 06, 2010 at 05:26:09PM +0200, Vitaly Wool wrote:
>> 2010/6/6 Matthew Garrett <mjg59@srcf.ucam.org>:
>> > Holding a suspend blocker is entirely orthogonal to runtime pm. The
>> > "whole kernel" will not be "active" - it can continue to hit the same
>> > low power state in the idle loop, and any runtime pm implementation in
>> > the drivers will continue to be active.
>>
>> Yeah, that might also be the case, But then again, what's the use of
>> suspend blockers in this situation?
>
> The difference between idle-based suspend and opportunistic suspend is
> that the former will continue to wake up for timers and will never be
> entered if something is using CPU, whereas the latter will be entered
> whenever no suspend blocks are held. The problem with opportunistic
> suspend is that you might make the decision to suspend simultaneusly
> with a wakeup event being received. Suspend blocks facilitate
> synchronisation between the kernel and userspace to ensure that all such
> events have been consumed and handld appropriately.

Right, and then you start taking suspend blockers in kernel here and
there which eventually interferes with runtime PM.
So I don't buy the "orthogonality" point. Generally speaking, it's not true.

~Vitaly
