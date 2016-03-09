From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] PM / clk: Add support for obtaining clocks from device-tree
Date: Wed, 9 Mar 2016 21:32:44 +0100
Message-ID: <CAJZ5v0hsRDP1O0_WtFicRnF7UCxtANE_ZaSpa8QNV7O5HNZfsQ@mail.gmail.com>
References: <1457529213-2581-1-git-send-email-jonathanh@nvidia.com>
	<CAJZ5v0iEo=jj+T-0bQypxs8VTb7kPpczSRu+8-+F7oyRMk9nSA@mail.gmail.com>
	<56E05612.702@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56E05612.702-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 9, 2016 at 5:57 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 09/03/16 14:04, Rafael J. Wysocki wrote:
>> On Wed, Mar 9, 2016 at 2:13 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> The PM clocks framework requires clients to pass either a con-id or a
>>> valid clk pointer in order to add a clock to a device. Add a new
>>> function of_pm_clk_add_clks() to allows device clocks to be retrieved
>>> from device-tree and populated for a given device. Note that
>>> of_clk_get_from_provider() is not defined if CONFIG_OF and
>>> CONFIG_COMMON_CLK are not selected. Therefore, make of_pm_clk_add_clks()
>>> dependent on these options.
>>>
>>> An optional function pointer may be passed to of_pm_clk_add_clks() that
>>> can be used to filter the clocks that are added for a device when
>>> calling of_pm_clk_add_clks().
>>>
>>> In order to handle errors encountered when adding clocks from
>>> device-tree, add a function pm_clk_remove_clk() to remove any clocks
>>> (using a pointer to the clk structure) that have been added
>>> successfully before the error occurred.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>
>>> Changes v1-v2:
>>> - Added support for optional filter function as suggested by Geert U.
>>
>> I'd like to get an ACK on this from someone more familiar with the DT
>> stuff than I am.
>
> No problem. Is Geert's ACK sufficient or is there someone else I should add?

It would do.

Thanks,
Rafael
