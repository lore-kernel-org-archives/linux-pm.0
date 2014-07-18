From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH v5 7/8] drivers: cpuidle: initialize Exynos driver through
 DT
Date: Fri, 18 Jul 2014 14:15:01 +0530
Message-ID: <CANuQgHEPocfO8wDPDTJUkBNGEfw6FoLEYAJK-zPPA7kd_L-34Q@mail.gmail.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-8-git-send-email-lorenzo.pieralisi@arm.com>
 <5019714.S4WTdsyrXS@amdc1032>
 <20140717142019.GA21732@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140717142019.GA21732@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Bartlomiej
List-Id: linux-pm@vger.kernel.org

Hi Lorenzo,


On 17 July 2014 19:50, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Wed, Jun 25, 2014 at 04:23:38PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>
>> On Wednesday, June 25, 2014 03:10:20 PM Lorenzo Pieralisi wrote:
>> > With the introduction of DT based idle states, CPUidle drivers for
>> > ARM can now initialize idle states data through properties in the device
>> > tree.
>> >
>> > This patch adds code to the Exynos CPUidle driver to dynamically
>> > initialize idle states data through the updated device tree source
>> > files.
>> >
>> > Cc: Kukjin Kim <kgene.kim@samsung.com>
>> > Cc: Tomasz Figa <t.figa@samsung.com>
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > ---
>> > Compile tested, I am not sure I patched the right dts files, please check.
>>
>> cpuidle-exynos driver is currently working properly in deeper cpuidle
>> mode (AFTR) on Exynos4210 and Exynos5250 (please also see the following
>> patch from Tomasz Figa: [1]).  There is ongoing work to AFTR mode work
>> also on Exynos4x12 and Exynos3250 but it is not complete yet.  Exynos5410
>> OTOH should probably use the generic big little cpuidle driver (this SoC
>> is similar to Exynos5420 one for which Chander Kashyap has developed
>> cpuidle-big_little support [2]).
>>
>> Making long story short, I think that your patch should depend on patch
>> [1] and update only exynos4210.dtsi and exynos5250.dtsi.  Also for your
>> patch #6 there needs to be some coordination with merging of Chander's
>> patchset ([2]).
>>
>> [1] http://www.spinics.net/lists/arm-kernel/msg341023.html
>> [2] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg664470.html
>
>
> exynos4210.dtsi does not even have cpu nodes in it. Should I add them or
> this might trigger regression (ie cpu_logical_map()) ?

Yes that can cause regression.

>
> I will post a new version soon, should I just patch 5250 for now ?
>
> I would need help to test this patch thanks.

I can test the patch for 5250.

>
> Lorenzo
>
>> >  .../devicetree/bindings/arm/exynos/idle-states.txt | 27 ++++++++++++++++++++
>> >  arch/arm/boot/dts/exynos3250.dtsi                  | 16 ++++++++++++
>> >  arch/arm/boot/dts/exynos5250.dtsi                  | 15 +++++++++++
>> >  arch/arm/boot/dts/exynos5410.dtsi                  | 17 +++++++++++++
>> >  drivers/cpuidle/Kconfig.arm                        |  1 +
>> >  drivers/cpuidle/cpuidle-exynos.c                   | 29 +++++++++++++---------
>> >  6 files changed, 93 insertions(+), 12 deletions(-)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/exynos/idle-states.txt
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>



-- 
with warm regards,
Chander Kashyap
