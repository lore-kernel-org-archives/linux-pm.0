From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Change prototype for the ->attach_dev() callback
Date: Wed, 5 Nov 2014 08:43:29 +0100
Message-ID: <CAMuHMdXqZDQPm2uOqP4AtKao=gzy8zkb7ydFVAufnJTnVtsQ-Q@mail.gmail.com>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
	<3981560.mBph1QJkfl@vostro.rjw.lan>
	<7h4mul9ttl.fsf@deeprootsystems.com>
	<20141105013353.GA19238@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141105013353.GA19238@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 5, 2014 at 2:33 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Oct 30, 2014 at 01:38:30PM -0700, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>
>> > On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
>> >> Convert the prototype to return and int. This is just an initial step,
>> >> needed to support error handling.
>> >>
>> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Acked-by: Kevin Hilman <khilman@linaro.org>
>>
>> >>
>> >> This patch is intended as fix for 3.18 rc[n]. Why?
>> >>
>> >> There are other SOC specific patches around that adds genpd support and which
>> >> implements the ->attach_dev() callback. To prevent having an "atomic" patch
>> >> during the next release cycle, let's change the prototype now instead.
>> >>
>> >> Further patches will add the actual error handling in genpd and these can then
>> >> be reviewed and tested thoroughly.
>> >
>> > So we have no users of ->attach_dev at the moment, right?
>>
>> Not in mainline, but there are a couple getting ready to hit -next, so
>> we wanted to fix this before they arrive so that adding the error
>> handling will be easier.
>
> BTW, while we are at it, can we also pass the domain itself to
> attach_dev() and detach_dev()? If anything it helps with debugging (you
> can print domain name from the callbacks).

You can use dev->pm_domain, which is already set.

Note that this is no longer the case after Ulf's "[PATCH 3/4] PM / Domains:
Improve error handling while adding/removing devices"!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
