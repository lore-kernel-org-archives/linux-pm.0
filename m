From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] PM / Domains: Add pm_genpd_lookup() API to lookup
 domain by firmware node
Date: Mon, 1 Dec 2014 11:26:10 +0100
Message-ID: <CAPDyKFpX5nXR18pKdLrtDrPK60p1y2CEqq+--3z3jczRRmKrqA@mail.gmail.com>
References: <1417171115-5789-1-git-send-email-ulf.hansson@linaro.org>
	<5765394.eQjV2VvkSL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5765394.eQjV2VvkSL@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29 November 2014 at 01:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, November 28, 2014 11:38:35 AM Ulf Hansson wrote:
>> In a step to move away from using genpd's name based APIs, such as the
>> pm_genpd_add_subdomain_names(), provide an API to lookup an already
>> initialized generic PM domain by its firmware node.
>>
>> This API would typically be a called from SOC specific code, to fetch a
>> handle to the domain. Especially convenient to configure subdomains and
>> when the hierarchy of the domains are described in DT.
>>
>> Do note, before pm_genpd_init() is invoked to initialize a generic PM
>> domain, it's the callers responsibility to assign the new ->fwnode
>> pointer in the struct generic_pm_domain, to enable pm_genpd_lookup() to
>> find the domain.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> I have no problems with that, but do you have a user for it?

Amit Daniel Kachhap, posted a patchset which is adding subdomains
configured from DT for Exynos. It's from there the idea to this patch
comes from. Amit is about to post a new version, based on this patch.

https://lkml.org/lkml/2014/11/24/290

Kind regards
Uffe
