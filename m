From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] ARM: dts: Add missing CPU frequencies for
 Exynos5422/5800
Date: Wed, 4 Jan 2017 13:05:41 -0800
Message-ID: <CAD=FV=WM_K_f0NQ0mxB55Ksbqg1gYJHs5d66ARYsa1=5hKLjXA@mail.gmail.com>
References: <10512254.nyUcL0zgTP@amdc3058>
 <CAD=FV=Wo273T20fe8D2v5Pn1HYR==7PHtr7WZGwzFPRspAYPzg@mail.gmail.com>
 <20161229141707.qjrtjz7dik6a7l5s@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161229141707.qjrtjz7dik6a7l5s@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ben Gamari <ben@smart-cactus.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Thomas Abraham <thomas.ab@samsung.com>, Arjun K V <arjun.kv@samsung.com>, Andreas Faerber <afaerber@suse.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Dec 29, 2016 at 6:17 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Dec 15, 2016 at 04:54:30PM -0800, Doug Anderson wrote:
>> > Index: b/arch/arm/boot/dts/exynos5800.dtsi
>> > ===================================================================
>> > --- a/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.365955950 +0100
>> > +++ b/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.361955949 +0100
>> > @@ -24,6 +24,16 @@
>> >  };
>> >
>> >  &cluster_a15_opp_table {
>> > +       opp@2000000000 {
>> > +               opp-hz = /bits/ 64 <2000000000>;
>> > +               opp-microvolt = <1250000>;
>> > +               clock-latency-ns = <140000>;
>> > +       };
>> > +       opp@1900000000 {
>> > +               opp-hz = /bits/ 64 <1900000000>;
>> > +               opp-microvolt = <1250000>;
>> > +               clock-latency-ns = <140000>;
>> > +       };
>>
>> I don't think the voltages you listed are high enough for all peach pi
>> boards for A15 at 1.9 GHz and 2.0 GHz, at least based on the research
>> I did.  See my response to v1.
>
> I wanted to apply this but saw this remaining issue. Javier tested it
> on Peach Pi so is this concern still valid?

I'm not sure.  It's been years since I did anything with exynos, so I
won't stand in the way if everyone else agrees that this patch is
good, but I will point out that testing on a single Peach Pi board is
not really enough given the massive difference in voltage needed
between the highest ASV group and the lowest (a whopping 112.5 mV from
looking in the Chrome OS source tree).

-Doug
