From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
	for reading & writing a hibernation image.
Date: Sun, 6 Jun 2010 22:55:32 +0100
Message-ID: <AANLkTim9CNFMMVQaghrzK3JnQlGmTewgarT01HP6cEtd__19876.4095585377$1276010176$gmane$org@mail.gmail.com>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<201006061557.20482.rjw@sisk.pl>
	<1275839650.5331.2.camel@maxim-laptop>
	<201006062104.55869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006062104.55869.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <ncunningham@crca.org.au>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 6 June 2010 20:04, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday 06 June 2010, Maxim Levitsky wrote:
>> On Sun, 2010-06-06 at 15:57 +0200, Rafael J. Wysocki wrote:
>> > On Sunday 06 June 2010, Maxim Levitsky wrote:
> ...
>> > So how TuxOnIce helps here?
>> Very simple.
>>
>> With swsusp, I can save 750MB (memory) + 250 Vram (vram)
>> With full memory save I can save (1750 MB of memory) + 250 MB of
>> vram....
>

I am completely unaware of the technical difficulties of saving the
whole memory vs 80% of it, but from my experience with TuxOnIce I
fully agree with Nigel on saving the whole memory.

The fact is that the whole system is much more responsive than when
using swsusp. No doubt about that, I can tell you that TuxOnIce really
changed the way I use my computer. I only used swsusp when I really
needed because of the lagginess starting up, and TuxOnIce changed it.

I have a laptop computer which I have to shutdown every night and open
every morning. It has 4GB of ram and I usually have 3.5 to 3.8 in use
all the time. With TuxOnIce I can restart my work every morning in
under 25 seconds, exactly where I left it, without any delays or
lagginess.

Its kind of hard to express in words, but really, this gave me a
completely different view of how to use a computer. Of course you can
compare it to S2R, but this consumes energy, no matter how little -
this has an environmental and financial cost which will only increase
in the future.

> So what about being able to save 1600 MB total instead of the 2 GB
> (which is what we're talking about in case that's not clear)? =A0Would it
> be _that_ _much_ worse?

No it wouldn't be much worse. But there will still be some lagginess,
some delay, some sort of annoying disk activity compared to NO delay,
NO lagginess, in short, you have your computer _exactly_ the way you
left it when you left it when you hibernated. And the difference is
noticeable.

>
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>


Sorry to jump in the thread, but I just wanted to give my end user perspect=
ive.

Regards,
Pedro
