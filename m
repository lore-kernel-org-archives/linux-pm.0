From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] base: power: Add generic OF-based power domain
 look-up
Date: Tue, 6 May 2014 19:52:47 +0200
Message-ID: <CAPDyKFqtW1pV3xv1E8fhtPS99eVezGJqKq_JM4Mrq2ewJyTpog@mail.gmail.com>
References: <1398271618-28932-1-git-send-email-t.figa@samsung.com>
 <1398271618-28932-2-git-send-email-t.figa@samsung.com>
 <CAPDyKFpvtRpgg-Ohv2Yi--_5mnp3ghpj7_4xyM7SjJvYCFzS6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpvtRpgg-Ohv2Yi--_5mnp3ghpj7_4xyM7SjJvYCFzS6Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Philipp Zabel <philipp.zabel@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Len Brown <len.brown@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <tomasz.figa@gmail.com>, Pavel Machek <pavel@ucw.cz>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J. Wyso
List-Id: linux-pm@vger.kernel.org

On 24 April 2014 11:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 April 2014 18:46, Tomasz Figa <t.figa@samsung.com> wrote:
>> This patch introduces generic code to perform power domain look-up using
>> device tree and automatically bind devices to their power domains.
>> Generic device tree binding is introduced to specify power domains of
>> devices in their device tree nodes.
>>
>> Backwards compatibility with legacy Samsung-specific power domain
>> bindings is provided, but for now the new code is not compiled when
>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
>> will change as soon as Exynos power domain code gets converted to use
>> the generic framework in further patch.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Reviewed-by: Mark Brown <broonie@linaro.org>
>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
>> [on i.MX6 GK802]
>> Tested-by: Philipp Zabel <philipp.zabel@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

I also implemented some test-support for genpd for a ux500 SOC as well
- tested passed successfully. :-)

[snip]

>> +
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>
> I remember we discussed this earlier, but I don't think we should add
> another Kconfig for this. CONFIG_OF should be enough.
>
> I realize that we need to handle "Samsung-specific bindings", to not
> break the Exynos pm domain. Maybe adding the parsing of them into the
> generic power domain in the same patch as when we switch Exynos to the
> new API would do the trick?

I realized that there already exists CONFIG_PM_GENERIC_DOMAINS_SLEEP
and CONFIG_PM_GENERIC_DOMAINS_RUNTIME, which serves similar purpose as
CONFIG_PM_GENERIC_DOMAINS_OF would.

So, let's ignore my previous comment and move on.

Kind regards
Ulf Hansson
