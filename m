From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] PM / Domains: Restrict "samsung,power-domain" checks to
 ARCH_EXYNOS
Date: Fri, 21 Oct 2016 11:18:07 -0300
Message-ID: <cb15013d-9694-b27c-dd5e-8c916c2e9fb7@osg.samsung.com>
References: <1477049656-27535-1-git-send-email-geert+renesas@glider.be>
 <CAJZ5v0iOQyCwCuMBVcJjX1mMHFb=NkfXFf6yBNdswRw1HMYC=Q@mail.gmail.com>
 <CGME20161021135818eucas1p265318ff4b1c4c83b52162ee5e59e40a3@eucas1p2.samsung.com>
 <20161021135803.GB3289@kozik-lap>
 <96efd5b7-5f62-8146-13de-44b5ff7dd496@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <96efd5b7-5f62-8146-13de-44b5ff7dd496@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, q@kozik-lap.samsung.com, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Sylwester,

On 10/21/2016 11:14 AM, Sylwester Nawrocki wrote:
> On 10/21/2016 03:58 PM, Krzysztof Kozlowski wrote:
>> The samsung,power-domain was made deprecated (although not explicitly)
>> in January 2015 (0da658704136 ("ARM: dts: convert to generic power
>> domain bindings for exynos DT")) so how about:
>> 1. Printing a dev_warn() about usage of deprecated bindings.
>> 2. Complete removal in January 2017?
> 
> I doubt anyone will ever use new mainline kernel with older dts/dtb
> so IMHO it makes sense to queue a patch removing support for the
> deprecated compatible just now and don't bother with a warning.
> 

FWIW I agree with you. I don't know of any Exynos machine that ships a DT
as read-only. Even consumer devices like the Exynos Chromebooks use a FIT
image (kernel + FDT bundled), so the DT can always be updated.

Removing the support for the deprecated property sound sensible to me.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
