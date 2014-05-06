From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/3] base: power: Add generic OF-based power domain
 look-up
Date: Tue, 06 May 2014 10:26:09 -0600
Message-ID: <53690D21.8080807@wwwdotorg.org>
References: <1398271618-28932-1-git-send-email-t.figa@samsung.com>	<1398271618-28932-2-git-send-email-t.figa@samsung.com>	<535E9163.3070305@wwwdotorg.org>
 <CAPDyKFoGOcScsaGWkw9bVh=gpGTApRK48AczaMiSmLah+YOSXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoGOcScsaGWkw9bVh=gpGTApRK48AczaMiSmLah+YOSXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Philipp Zabel <philipp.zabel@gmail.com>, Len Brown <len.brown@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Pavel Machek <pavel@ucw.cz>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J. Wysocki
List-Id: linux-pm@vger.kernel.org

On 05/06/2014 02:22 AM, Ulf Hansson wrote:
> On 28 April 2014 19:35, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/23/2014 10:46 AM, Tomasz Figa wrote:
>>> This patch introduces generic code to perform power domain look-up using
>>> device tree and automatically bind devices to their power domains.
>>> Generic device tree binding is introduced to specify power domains of
>>> devices in their device tree nodes.
>>>
>>> Backwards compatibility with legacy Samsung-specific power domain
>>> bindings is provided, but for now the new code is not compiled when
>>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
>>> will change as soon as Exynos power domain code gets converted to use
>>> the generic framework in further patch.
>>
>>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>>
>>> +==Power domain consumers==
>>> +
>>> +Required properties:
>>> + - power-domain : A phandle and power domain specifier as defined by bindings
>>> +                  of power controller specified by phandle.
>>
>> It seems quite likely that a single logical device could have components
>> in multiple power domains. Consider an HDMI controller with different
>> power domains for the HDMI core, CEC communication, DDC/I2C
>> communication, and the I/O pads, with no clear separation between those
>> two components of the module (no separate register spaces, but the
>> bits/registers are interleaved all together).
>>
>> As such, I think that rather than a "power-domain" property, we need a
>> pair of "power-domains", and "power-domain-names" properties, and
>> preferably with mandatory usage of name-based lookups, rather than
>> allowing a random mix of name-based and index-based lookups like we have
>> with some existing resource bindings.
> 
> Each struct device have only one dev_pm_domain pointer, thus a device
> are not able to reside in more than one power domain.
> 
> Therefore I doubt this will be very useful, unless I missed your point. :-)

A struct device is a Linux-internal concept. DT is supposed to represent
the HW in an OS-agnostic fashion, not according to the limitations of
any one OS's driver model.

It's certainly true that a single logical HW module (represented by a
single DT node) can have parts in multiple power domains.
