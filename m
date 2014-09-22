From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Mon, 22 Sep 2014 21:04:28 +0200
Message-ID: <CAPDyKFqT1A=N6=CFHVMq-u+zkYK9zp_Ztmm8OWpftmHY2w68DA@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<20140919184849.GA14832@core.coreip.homeip.net>
	<2161168.GXttgFlE1X@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2161168.GXttgFlE1X@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark
List-Id: linux-pm@vger.kernel.org

On 22 September 2014 16:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, September 19, 2014 11:48:49 AM Dmitry Torokhov wrote:
>> Hi Ulf,
>>
>> On Fri, Sep 19, 2014 at 08:27:33PM +0200, Ulf Hansson wrote:
>> > Changes in v5:
>> >     - Converted dev_pm_domain_detach() to a void function
>> >     - Added a ->detach() callback to the PM domain struct, invoked from the
>> >       dev_pm_domain_detach().
>> >     - Make ACPI and genpd both assign the ->detach() callback at successfull
>> >       attachment.
>> >     - The above changes made it possible to make acpi_pm_domain_detach() to
>> >       be static, added a separate patch for that.
>>
>> Thank you for making these changes. For the series:
>>
>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> I've queued up this patchset for 3.18 (I fixed up the two minor issues pointed
> to by Geert in the process).

Thanks Rafael!

Feel free to apply Wolfram's comment on patch 6 as well.

Kind regards
Uffe
