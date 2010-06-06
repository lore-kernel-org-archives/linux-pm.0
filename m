From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 09:52:08 +0200
Message-ID: <AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg___43535.7806309641$1275810793$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/6/5 Arve Hj=F8nnev=E5g <arve@android.com>:
> On Sat, Jun 5, 2010 at 9:28 AM, Arjan van de Ven <arjan@infradead.org> wr=
ote:
>> On Sat, 05 Jun 2010 11:54:13 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Fri, 2010-06-04 at 17:10 -0700, Arve Hj=F8nnev=E5g wrote:
>>> > > Trusted processes are assumed to be sane and idle when there is
>>> > > nothing for them to do, allowing the machine to go into deep idle
>>> > > states.
>>> > >
>>> >
>>> > Neither the kernel nor our trusted user-space code currently meets
>>> > this criteria.
>>>
>>> Then both need fixing. Really, that's the only sane approach.
>>
>> fwiw... in MeeGo we're seeing quite good idle times (> 1 seconds)
>> without really bad hacks.
>>
>
> We clearly have different standards for what we consider good. We
> measure time suspended in minutes or hours, not seconds, and waking up
> every second or two causes a noticeable decrease in battery life on
> the hardware we have today.

Are you stating that the existing Android implementation enters the
suspended state for hours for any of the existing designs?

~Vitaly
