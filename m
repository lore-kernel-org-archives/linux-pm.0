From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] phy: core: Move runtime PM reference counting to
 the parent device
Date: Sat, 23 Dec 2017 02:50:12 +0100
Message-ID: <CAJZ5v0i1o=dWjfMowdiG_ChGJETFaSNRR6OjroOooc0nXhViFw@mail.gmail.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <1513778960-10073-2-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0iwR1MnBokL29_QmUw2F6fgNNwzP7WLhtAL37MkMLd1xQ@mail.gmail.com>
 <CAPDyKFokLc5cQW7RWAsdCY4h_Q8BgHKGQwHVUFX68fWF=BE6_g@mail.gmail.com> <CAJZ5v0gKnHMgN0xokp1twLUCc5MFiXo_4tOORk_-Vxv0iFLLag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gKnHMgN0xokp1twLUCc5MFiXo_4tOORk_-Vxv0iFLLag@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 23, 2017 at 2:35 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Dec 21, 2017 at 11:50 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 21 December 2017 at 02:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Wed, Dec 20, 2017 at 3:09 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> The runtime PM deployment in the phy core is deployed using the phy core
>>>> device, which is created by the phy core and assigned as a child device of
>>>> the phy provider device.

[cut]

>>
>> Also, I have considered how to deal with wakeup paths for phys,
>> although I didn't want to post changes as a part of this series, but
>> maybe I should to give a more complete picture?
>
> Yes, you should.
>
> The point is that without genpd using pm_runtime_force_suspend() the
> phy code could very well stay the way it is.  And it is logical,
> because having a parent with enabled runtime PM without enabling
> runtime PM for its children is at least conceptually questionable.

Actually, I sort of agree that the phy's usage of runtime PM is too
convoluted.  For example, it uses pm_runtime_enabled() unnecessarily
at least in some places, but that doesn't seem to be fixed by your
patches.

Thanks,
Rafael
