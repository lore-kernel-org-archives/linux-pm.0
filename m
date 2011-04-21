From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [TuxOnIce-devel] [RFC PATCH] Current status,
 suspend-to-disk support on ARM
Date: Thu, 21 Apr 2011 13:55:58 +0900
Message-ID: <BANLkTinXOR+AhsTtgLdnnmT=1Q4M5Q5LWA__27434.7377046526$1303361910$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412183208.GC26916@elf.ucw.cz>
	<alpine.DEB.2.00.1104131020080.29883@localhost6.localdomain6>
	<201104132338.03003.rjw@sisk.pl>
	<alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
	<BANLkTinroLCypX-iG0xGpnyxBk=P5TVtJQ@mail.gmail.com>
	<alpine.DEB.2.00.1104191859260.4937@localhost6.localdomain6>
	<BANLkTinp1+6Ocmy5LAUEiPwAje+VnrTo9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinp1+6Ocmy5LAUEiPwAje+VnrTo9Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Hsu <matt@0xlab.org>
Cc: frank.hofmann@tomtom.com, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hello Matt,

On Wed, Apr 20, 2011 at 4:14 PM, Matt Hsu <matt@0xlab.org> wrote:
>
>>
>> Also, I'd like to investigate whether ARM will require a set of
>> platform_hibernation_ops - Samsung's patch from last December,
>>
>> http://www.spinics.net/lists/arm-kernel/msg108565.html
>
> =A0=A0=A0 Hi FrankH,
>
> =A0=A0=A0=A0 The patch seems has connection with this
>
> =A0=A0=A0=A0 www.kernel.org/doc/ols/2010/ols2010-pages-9-18.pdf

Actually, those patches had no direct connections with that anyway. :)

>
> =A0 =A0 You can see the section 4.3 fast device reactivation.
> =A0 =A0 It does the similar thing=A0 as STR, but drivers status are kept =
in
> hibernation image instead of main memory.
> =A0=A0=A0 I guess this is why this patch comes out.

Yes, this SoC has registers that require STR/Hibernation to save the
status. They include power, clock, memory-control, gpio, uart related
registers.

>
> =A0=A0=A0 In the current device driver model, there are no appropriate ha=
ndling
> specific to
> =A0=A0=A0 hibernation_suspend/hibernation_resume ops.
>
> =A0=A0=A0 So they make their own interface/platform drivers.

Correct.

If the interface looks like dev_pm_ops, it would be virtually perfect. :)

>
>>
>> seems to indicate that they believe it's necessary at least on some ARM
>> hardware. OMAP has similar functions to that, it'd be great to unify.
>>
>>
>> FrankH.
>>
> --
> - Matt
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>



-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
