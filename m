From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
Date: Sun, 16 Aug 2015 11:24:51 +0200
Message-ID: <CAMuHMdV2gDBaPRb3yE=tVPO_pr7PFA6bwhyQE5raumCh_qPXww@mail.gmail.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
 <7hfv3onv5c.fsf@deeprootsystems.com>
 <CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
 <7hwpwylepx.fsf@deeprootsystems.com>
 <CAMuHMdW-T9rUWXsQeffwtXspHbjfGqo_0G4QMB1o0TwTLJAQAg@mail.gmail.com>
 <CAMAWPa-0R42thqBo0omn0KK7y0wyxoyaP+wsfoRvXBmWhBytKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMAWPa-0R42thqBo0omn0KK7y0wyxoyaP+wsfoRvXBmWhBytKg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Andy Gross <agross@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

On Fri, Aug 14, 2015 at 7:19 PM, Kevin Hilman <khilman@kernel.org> wrote:
> On Fri, Aug 14, 2015 at 12:24 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Aug 14, 2015 at 5:40 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>>> On Wed, Aug 12, 2015 at 9:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>>> This check might have made sense before PM domains, but with PM domains,
>>>>> it's entirely possible to have a simple device without a driver and the
>>>>> PM domain handles all the necesary PM, so I think this check
>>>>> could/should be removed.
>>>>>
>>>>> Thoughts?
>>>>
>>>> Simple devices without a driver aren't handled automatically.
>>>> At minimum, the driver should call pm_runtime_enable(), cfr.
>>>> drivers/bus/simple-pm-bus.c.
>>>
>>> That's correct, and in the proof-of-concept stuff I hacked up and in
>>> Lina's series, the CPU "devices" do indeed to this.  Without that, they
>>> wouldn't end up ever taking this codepath through genpd's
>>> runtime_suspend and power_off hooks.
>>>
>>> Also, I'm not sure if your comment was meant to be an objection to the
>>> patch?  or if you're OK with it.
>>
>> My comment was purely meant as a response to "it's entirely possible to have a
>> simple device without a driver and the PM domain handles all the necesary PM".
>
> Right, so if the PM domain does the pm_runtime_enable() for these
> "simple" devices without drivers, they can still exist without a
> driver, and the PM domain doing all the magic.

Is it possible to let the PM Domain do the pm_runtime_enable() itself in
the absence of a driver? If yes, I wouldn't have needed simple-pm-bus.c.
What if a driver is bound later?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
