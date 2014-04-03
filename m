From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
Date: Thu, 03 Apr 2014 14:30:50 +0200
Message-ID: <533D547A.7080900@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>	<1393862536-9842-2-git-send-email-tomasz.figa@gmail.com> <CAPDyKFoxTAHyX7SQAMsvt=OttHs22oMSB8XrRUDDJ06qO0Fc2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoxTAHyX7SQAMsvt=OttHs22oMSB8XrRUDDJ06qO0Fc2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Stephen
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 03.04.2014 14:16, Ulf Hansson wrote:
> On 3 March 2014 17:02, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
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
>> Signed-off-by: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   .../devicetree/bindings/power/power_domain.txt     |  51 ++++
>>   drivers/base/power/domain.c                        | 298 +++++++++++++++++++++
>>   include/linux/pm_domain.h                          |  46 ++++
>>   kernel/power/Kconfig                               |   4 +
>>   4 files changed, 399 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>> new file mode 100644
>> index 0000000..93be5d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -0,0 +1,51 @@
>> +* Generic power domains
>> +
>> +System on chip designs are often divided into multiple power domains that
>> +can be used for power gating of selected IP blocks for power saving by
>> +reduced leakage current.
>> +
>> +This device tree binding can be used to bind power domain consumer devices
>> +with their power domains provided by power domain providers. A power domain
>> +provider can be represented by any node in the device tree and can provide
>> +one or more power domains. A consumer node can refer to the provider by
>> +a phandle and a set of phandle arguments (so called power domain specifier)
>> +of length specified by #power-domain-cells property in the power domain
>> +provider node.
>> +
>> +==Power domain providers==
>> +
>> +Required properties:
>> + - #power-domain-cells : Number of cells in a power domain specifier;
>> +   Typically 0 for nodes representing a single power domain and 1 for nodes
>> +   providing multiple power domains (e.g. power controllers), but can be
>> +   any value as specified by device tree binding documentation of particular
>> +   provider.
>
> I am trying to understand if using a value > 1, ever would make sense.
> Wouldn't that mean each consumer (device) would actually be a part of
> more than one power domain? That won't work, right!?

Not exactly. Each phandle + #power-domain-cells cells are used just for 
single power domain.

The cells here are used merely as the identifier used by power domain 
driver to translate a power domain specifier from DT to a kernel 
pointer. It's up to driver bindings to select the number of cells to 
properly identify a power domain.

As an example (from different world, but showing the same mechanism), 
let's see a common pattern of GPIO banks on some SoC:

GPA0
GPA1
GPB0
GPB1
GPC0
GPC1

One might assign a single-cell ID to each bank ending with a namespace 
of integers from 0 to 5 that would be used as follows:

#define GPA0 0
#define GPA1 1
#define GPB0 2
#define GPB1 3
#define GPC0 4
#define GPC1 5

reset-gpios = <&gpio GPA0 4>;

However one might also consider assigning one cell to bank set (e.g. 
GPA) and one cell to identify the bank inside of a set, like on the 
following example:

#define GPA 0
#define GPB 1
#define GPC 2

reset-gpios = <&gpio GPA 0 4>;

Good bindings should allow arbitrary identification schemes to let a 
driver developer use the one that suits the hardware he's working on.

>
> Additionally, there are no corresponding parsing method (like
> of_genpd_xlate_onecell() ) that support more than one cell.

There are two generic xlate helpers provided for the most common cases 
that are likely to be reused by most drivers. For more complex cases 
it's up to the driver to implement its own mapping function. It can be 
promoted to a generic one later if such need shows up.

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
