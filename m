From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 6/6] thermal:exynos4: Add documentation for Exynos SoC
 thermal bindings
Date: Tue, 23 Apr 2013 12:39:32 +0530
Message-ID: <CAK9yfHwrYA5_fw=nc7cEFdbFoVccmqDxLBQ74N6NcsxjtMEU3w@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366389493-8239-7-git-send-email-l.majewski@samsung.com>
	<CAK9yfHz8GH90LO8gzVah_KLezZ=bNc3+pgX6O5QGt2+xJZsUqw@mail.gmail.com>
	<20130423082533.369a580f@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130423082533.369a580f@amdc308.digital.local>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 23 April 2013 11:55, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Sachin,
>
>> Hi Lukasz,
>>
>> Thanks for adding this. Some comments inline.
>>
>> On 19 April 2013 22:08, Lukasz Majewski <l.majewski@samsung.com>
>> wrote:
>> > Proper description for Exynos4 bindings added to
>> > Documentation/devicetree/ bindings
>> >
>> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > ---
>> >  .../devicetree/bindings/thermal/exynos-thermal.txt |   22
>> > ++++++++++++++++++++ 1 file changed, 22 insertions(+)
>> >  create mode 100644
>> > Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>> > b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt new
>> > file mode 100644 index 0000000..e994e1e --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>> > @@ -0,0 +1,22 @@
>> > +* Exynos Thermal
>>
>> How about "Exynos Thermal Management Unit (TMU)"?
>>
>> > +
>> > +Required properties:
>> > +- compatible : "samsung,exynos4412-tmu"
>> Should be one of the following:
>> "samsung,exynos4210-tmu"
>> "samsung,exynos4412-tmu"
>
> So all thee names shall be added? Right?

Yes, you need to add all supported compatible strings.

---
With warm regards,
Sachin
