From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 1/3] base: power: Add generic OF-based power domain
 look-up
Date: Tue, 06 May 2014 19:59:10 +0200
Message-ID: <536922EE.6080000@gmail.com>
References: <1398271618-28932-1-git-send-email-t.figa@samsung.com>	<1398271618-28932-2-git-send-email-t.figa@samsung.com>	<535E9163.3070305@wwwdotorg.org>
 <CAPDyKFoGOcScsaGWkw9bVh=gpGTApRK48AczaMiSmLah+YOSXQ@mail.gmail.com>
 <53690D21.8080807@wwwdotorg.org> <536918A9.6050502@gmail.com>
 <53691AE4.10206@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53691AE4.10206@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Philipp Zabel <philipp.zabel@gmail.com>, Len Brown <len.brown@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Pavel Machek <pavel@ucw.cz>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vg
List-Id: linux-pm@vger.kernel.org

On 06.05.2014 19:24, Stephen Warren wrote:
> On 05/06/2014 11:15 AM, Tomasz Figa wrote:
>>
>>
>> On 06.05.2014 18:26, Stephen Warren wrote:
>>> On 05/06/2014 02:22 AM, Ulf Hansson wrote:
>>>> On 28 April 2014 19:35, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>>> On 04/23/2014 10:46 AM, Tomasz Figa wrote:
>>>>>> This patch introduces generic code to perform power domain look-up
>>>>>> using
>>>>>> device tree and automatically bind devices to their power domains.
>>>>>> Generic device tree binding is introduced to specify power domains of
>>>>>> devices in their device tree nodes.
>>>>>>
>>>>>> Backwards compatibility with legacy Samsung-specific power domain
>>>>>> bindings is provided, but for now the new code is not compiled when
>>>>>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code.
>>>>>> This
>>>>>> will change as soon as Exynos power domain code gets converted to use
>>>>>> the generic framework in further patch.
>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/power/power_domain.txt
>>>>>> b/Documentation/devicetree/bindings/power/power_domain.txt
>>>>>
>>>>>> +==Power domain consumers==
>>>>>> +
>>>>>> +Required properties:
>>>>>> + - power-domain : A phandle and power domain specifier as defined
>>>>>> by bindings
>>>>>> +                  of power controller specified by phandle.
>>>>>
>>>>> It seems quite likely that a single logical device could have
>>>>> components
>>>>> in multiple power domains. Consider an HDMI controller with different
>>>>> power domains for the HDMI core, CEC communication, DDC/I2C
>>>>> communication, and the I/O pads, with no clear separation between those
>>>>> two components of the module (no separate register spaces, but the
>>>>> bits/registers are interleaved all together).
>>>>>
>>>>> As such, I think that rather than a "power-domain" property, we need a
>>>>> pair of "power-domains", and "power-domain-names" properties, and
>>>>> preferably with mandatory usage of name-based lookups, rather than
>>>>> allowing a random mix of name-based and index-based lookups like we
>>>>> have
>>>>> with some existing resource bindings.
>>>>
>>>> Each struct device have only one dev_pm_domain pointer, thus a device
>>>> are not able to reside in more than one power domain.
>>>>
>>>> Therefore I doubt this will be very useful, unless I missed your
>>>> point. :-)
>>>
>>> A struct device is a Linux-internal concept. DT is supposed to represent
>>> the HW in an OS-agnostic fashion, not according to the limitations of
>>> any one OS's driver model.
>>>
>>> It's certainly true that a single logical HW module (represented by a
>>> single DT node) can have parts in multiple power domains.
>>
>> AFAIK a single DT node is supposed to represent a single _physical_ HW
>> module. It all depends on description granularity, though. A physical
>> chip (or IP block) might be further divided into multiple blocks, so I
>> can imagine some of them being in different power domains than another.
>
> Physical-vs-logical probably means different things to different people.
> What I mean is that DT should represent the HW modules at the
> granularity that the HW documentation or designers describe the HW.
>
>> Still, based on the fact that in Linux we never needed to specify
>> multiple power domains for a device, is this really a real use case?
>
> a) Linux has absolutely nothing to do with this. Again, DT is purely a
> HW description that should not be influenced by OS limitations.
>
> b) Linux does have to deal with this. HW exists which uses multiple
> power domains per DT device node.
>
> The fact that Linux forces the driver internals to create a separate
> struct device for each part of the actual device that's in a different
> power domain should not force us into representing the HW incorrectly in DT.
>
>> Anyway, the binding is defined in a way that lets you simply turn the
>> single phandle+specifier into a list of them, if such need ever shows up.
>
> In my opinion, for all new resource bindings, we need to *exclusively*
> support named-based lookup. That's the only way to ensure a simple
> forward-compatible path to extensible DT bindings in the face of
> multiple instances of a certain type of resource, where some are
> optional. If resource lookups start out by index, and then later
> (missing information when the DT binding was written, extending the DT
> binding to a new HW revision/model) we find we need to add more
> instances of that resource, some of which are optional, then anything
> but purely name-based lookup makes the situation very complex.
>
> We should solve this by simply using named-based lookup from the start
> in all cases. That's my point here. Hence, we need to addm and enforce
> usage of, a power-domain-names property.

Majority of use cases will need just a single power domain. Until a real 
user of multiple power domains shows up along with a developer willing 
to extend Linux PM code to account for this, I'd keep this as is.

The one thing to make the binding more future-proof would be probably 
changing name of the property to "power-domains" for consistency with 
other bindings using *-names.

For now, the Linux power domain implementation would simply use the 
first available entry in "power-domains" property, but it could be 
extended in future with code to perform name-based look-up.

Best regards,
Tomasz
