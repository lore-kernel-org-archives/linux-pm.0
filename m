From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
Date: Wed, 13 Jun 2018 09:58:55 +0200
Message-ID: <CAJZ5v0gYpceS_zpmOqowu3_Pn2qVo=H4r__67qv-Ybyy-ijFZQ@mail.gmail.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
 <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
 <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 9:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 June 2018 at 14:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

[cut]

>>
>> Is there any way to keep old behavior?
>
> I think the old behavior is sub-optimal. I am sure there are users
> that really don't want the driver core to runtime resume the supplier
> unconditionally.

I agree.

That said, the existing behavior has been there for quite a while and
the callers of device_link_add() that have grown a dependency on it
should be given a chance to change before it goes away.

> I would rather go and fix the few users of device_link_add(), to use
> DL_FLAG_RPM_ACTIVE, in cases when they need it.

Which BTW was the original idea. :-)

> Of course I am fine if we do these changes in a step by step basis as well.

OK, because that's what I'd prefer to do.
