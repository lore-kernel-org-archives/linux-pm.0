From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 21:36:07 +0400
Message-ID: <461E6E07.5020408@gmail.com>
References: <1175810054.3489.34.camel@johannes.berg>	
	<1176306867.19348.4.camel@johannes.berg>
	<461D494D.3080808@gmail.com>	
	<1176367352.5764.2.camel@localhost.localdomain>	
	<20070412101653.GB26473@elf.ucw.cz>
	<1176377017.5764.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176377017.5764.15.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Thu, 2007-04-12 at 12:16 +0200, Pavel Machek wrote:
>
>> Adding platform hook to disable interrupts just because we need one
>> platform device last is not nice, either. (And does decrementer even
>> need to come last?)
>>
>> Anyway, platform devices may need specific ordering on more than power
>> pc, so perhaps we should just make ordering more stable so that
>> relying on it is no longer a hack?
>
> It would be pretty hard to do cleanly without raping the core driver
> suspend/resume core.
>
> I have experience implementing suspend/resume in all sorts of
> environments, and I do strongly beleive that an arch hook right at this
> point will be useful to more than that anyway.
>
> There are actions the arch code might need to take after drivers and
> before going to "atomic" mode (irqs off mean you can no longer sleep or
> take semaphores etc...), and in a similar vein, actions to take on
> resume just after interrupts are back and before all the drivers get
> woken up.
>
> The decrementer is one example, there might be other processor specific
> bits or arch specific bits that are better done at that stage.

It'd be nice adding some examples to patch header, and accurate
explanation what is possible to do at this new level, this would
sign to other people that they don't have to invent theirs own hacks
anymore.

>
> I think the way to go for 2.6.22 is to have that hook unless you can
> propose me a way to cleanly provide a platform device that is guaranteed
> to suspend last and resume first in all cases (and even then, I wouldn't
> be that happy since the proper decrementer stop procedure involves
> really wrapping the "irqs off" operation).
>
> Why not give this added flexibility ? Archs who don't care don't need to
> bother and it will make us happy... it's not like we are about to -add-
> burden to other architectures.
>
>

Actually, I personally two hands up for  adding the flexibility,
but you should define what is supposed to do on this level and
what is don't, or not desirable.

For example, I'd like to enter back to suspend mode
right from "activate" stage, because I've woken up just
to update some data and I do not want to resume all devices
for that, is it ok for "activate"?


Thanks,
Dmitry
