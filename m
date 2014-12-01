From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH V2] PM / Domains: Add pm_genpd_lookup() API to lookup
 domain by firmware node
Date: Mon, 1 Dec 2014 17:27:39 +0530
Message-ID: <CADGdYn5aLr69PrqO5RvU4q6HU9pPZ+1tWL27cc=cVazAvSVFpQ@mail.gmail.com>
References: <1417171115-5789-1-git-send-email-ulf.hansson@linaro.org>
	<5765394.eQjV2VvkSL@vostro.rjw.lan>
	<CAPDyKFpX5nXR18pKdLrtDrPK60p1y2CEqq+--3z3jczRRmKrqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpX5nXR18pKdLrtDrPK60p1y2CEqq+--3z3jczRRmKrqA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 1, 2014 at 3:56 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 29 November 2014 at 01:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, November 28, 2014 11:38:35 AM Ulf Hansson wrote:
>>> In a step to move away from using genpd's name based APIs, such as the
>>> pm_genpd_add_subdomain_names(), provide an API to lookup an already
>>> initialized generic PM domain by its firmware node.
>>>
>>> This API would typically be a called from SOC specific code, to fetch a
>>> handle to the domain. Especially convenient to configure subdomains and
>>> when the hierarchy of the domains are described in DT.
>>>
>>> Do note, before pm_genpd_init() is invoked to initialize a generic PM
>>> domain, it's the callers responsibility to assign the new ->fwnode
>>> pointer in the struct generic_pm_domain, to enable pm_genpd_lookup() to
>>> find the domain.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> I have no problems with that, but do you have a user for it?
>
> Amit Daniel Kachhap, posted a patchset which is adding subdomains
> configured from DT for Exynos. It's from there the idea to this patch
> comes from. Amit is about to post a new version, based on this patch.

Hi Ulf,

I was trying to use this API but i felt there is a better way of just exporting
of_genpd_get_from_provider as a similar API is used to register the
power domain.

Check if this make sense www.spinics.net/lists/arm-kernel/msg382665.html.

Regards,
Amit


>
> https://lkml.org/lkml/2014/11/24/290
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
