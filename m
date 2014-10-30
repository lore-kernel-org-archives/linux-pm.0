From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] PM / Domains: Let the ->attach_dev() callback return
 an error code
Date: Thu, 30 Oct 2014 12:34:19 +0100
Message-ID: <CAPDyKFqaZo1mNNO=HVe-6SiCFVqnfZSpJNf=B0SMw6bm9HpaZA@mail.gmail.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
	<1414507090-516-5-git-send-email-ulf.hansson@linaro.org>
	<CAMuHMdVn2mfk5v8MQshU0gko+dL9xtCT_zBuqyntHHrmxjwfSA@mail.gmail.com>
	<7h1tpq7fba.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <7h1tpq7fba.fsf@deeprootsystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chip>
List-Id: linux-pm@vger.kernel.org

On 29 October 2014 22:10, Kevin Hilman <khilman@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> Hi Ulf, Rafael,
>>
>> On Tue, Oct 28, 2014 at 3:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Typically an ->attach_dev() callback would fetch some PM resourses.
>>>
>>> Those operations, like for example clk_get() may fail with different
>>> errors, including -EPROBE_DEFER. Instead of ignoring these errors and
>>> potentially only print an error message, let's propagate them to give
>>> callers the option to handle them.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Given that several patch series using ->attach_dev() are already floating
>> around and will be in -next soon, what is the plan of getting this in?
>
> Shall we take this as a Reviewed-by or Acked-by for the series?  :)
>
>> Doing it ASAP (in v3.18-rc3)?
>
> IMO, this isn't at all appropriate for -rc since it's not fixing a
> regression. Also, this series includes other cleanups that are not
> really fixes either.  At this point of the -rc cycle, we need to focus
> only on regression fixes.
>
>> Delaying this to v3.19-rc2, which will require an atomic fixing of its users?
>> Any other option?
>
> I don't see any users of this in -next yet, so I think doing a simple
> patch to the prototype and fixing up any users before they hit -next is
> the right approach.  Errors will be ignored, but that's not change from
> today. :)
>
> Then the rest of this cleanup and behavior change stuff can continue to
> be reviewed and get broader testing before merge.

Okay, I will follow your suggestions and send a patch that only change
the prototype, intended as a fix for rc[n].

Kind regards
Uffe
