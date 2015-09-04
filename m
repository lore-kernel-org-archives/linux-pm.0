From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 5/7] staging: board: Add support for devices with
 complex dependencies
Date: Fri, 4 Sep 2015 10:30:34 +0200
Message-ID: <CAPDyKFriANthZbDcAQT8WXM2Z857p9+-UZB+woss04ZwM-97ZA@mail.gmail.com>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
 <1434530336-15073-6-git-send-email-geert+renesas@glider.be>
 <CAPDyKFqouMeTKuXyyohH-VDmWXH+TiLNDT-7MKFa_-TqeF2WSw@mail.gmail.com>
 <CAMuHMdUiH+WZnPtnM-HNs-SpZ8ZxULiKeAiTC1ONTJoP3YMXKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAMuHMdUiH+WZnPtnM-HNs-SpZ8ZxULiKeAiTC1ONTJoP3YMXKg@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: driverdevel <devel@driverdev.osuosl.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Magnus Damm <damm+renesas@opensource.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 3 September 2015 at 15:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Thu, Sep 3, 2015 at 2:53 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 17 June 2015 at 10:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>> Add support for easy registering of one ore more platform devices that
>>> may:
>>>   - need clocks that are described in DT,
>>>   - be part of a PM Domain.
>
>>> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
>>> index 8712f566b31196e0..29d456e29f38feac 100644
>>> --- a/drivers/staging/board/board.c
>>> +++ b/drivers/staging/board/board.c
>
>>> +int __init board_staging_register_device(const struct board_staging_dev *dev)
>>> +{
>>> +       struct platform_device *pdev = dev->pdev;
>>> +       unsigned int i;
>>> +       int error;
>>> +
>>> +       pr_debug("Trying to register device %s\n", pdev->name);
>>> +       if (board_staging_dt_node_available(pdev->resource,
>>> +                                           pdev->num_resources)) {
>>> +               pr_warn("Skipping %s, already in DT\n", pdev->name);
>>> +               return -EEXIST;
>>> +       }
>>> +
>>> +       board_staging_gic_fixup_resources(pdev->resource, pdev->num_resources);
>>> +
>>> +       for (i = 0; i < dev->nclocks; i++)
>>> +               board_staging_register_clock(&dev->clocks[i]);
>>> +
>>> +       error = platform_device_register(pdev);
>>> +       if (error) {
>>> +               pr_err("Failed to register device %s (%d)\n", pdev->name,
>>> +                      error);
>>> +               return error;
>>> +       }
>>> +
>>> +       if (dev->domain)
>>> +               __pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
>>
>> Urgh, this managed to slip through my filters.
>>
>> It seems like we almost managed to remove all users of the
>> "..._name_add..." APIs for genpd. If hasn't been for $subject patch.
>> :-)
>>
>> Now, I realize this is already too late here, but let's try to fix
>> this before it turns into a bigger issue.
>>
>> Geert, do you think it's possible to convert into using the non-named
>> bases APIs?
>
> That will be difficult. This code is meant to use drivers that are not yet
> DT-aware on DT-based systems. Hence it uses platform devices with named PM
> domains, while the PM domains are described in DT.
> I don't think there's another way to look up a PM domain by name, is there?

As a matter of fact there are, especially for those genpds that has
been created through DT as in this case. The API to use is
of_genpd_get_from_provider() to find the struct generic_pm_domain.

Yes, I do realize that you need to manage the parsing of the domain
name to make sure it's the one you want, but I would rather keep that
"hack" in this driver than in the generic API.

>
> This code is meant to go away, once all drivers are converted to DT, or
> considered obsolete.

Well, who knows *when* that is going to happen. :-)

Kind regards
Uffe
