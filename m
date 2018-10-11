From: Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
Date: Thu, 11 Oct 2018 10:04:31 +0000
Message-ID: <VI1PR0402MB34852BFA7E8E44E9B867D76F98E10@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
 <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
 <1dd3074eabb496155c4d1abb83c82c52529a656a.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Scott Wood <oss@buserror.net>, Rob Herring <robh+dt@kernel.org>, Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Will Deacon <will.deacon@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sriram Dash <sriram.dash@nxp.com>, linux-clk <linux-clk@vger.kernel.org>, Udit Kumar <udit.kumar@nxp.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "open
 list:THERMAL" <linux-pm@vger.kernel.org>, Varun Sethi <V.Sethi@nxp.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>, Priyanka Jain <priyanka.jain@nxp.com>, "Rafael J. Wysocki" <rjw@rjwy>
List-Id: linux-pm@vger.kernel.org

On 8/29/2018 3:31 AM, Scott Wood wrote:
> On Tue, 2018-08-21 at 15:45 -0500, Rob Herring wrote:
>> On Mon, Aug 20, 2018 at 1:52 PM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>>> +/ {
>>> +       model = "NXP Layerscape LX2160ARDB";
>>> +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
>>> +
>>> +       aliases {
>>> +               crypto = &crypto;
>>
>> Drop this. Aliases should be numbered, and this is not a standard
>> alias name either.
> 
> Is this a new rule?  In any case, U-Boot looks for a "crypto" alias.
> 
(Replying here, I did not see a follow-up).

Indeed, U-boot relies on the "crypto" alias.
This is true for all SoCs with CAAM crypto engine, a pretty lengthy list.

Could you please clarify?
Also: Is numbering needed even when there is a single instance of the block?

Looking at a recent discussion
https://lore.kernel.org/patchwork/patch/991718
I see the proposal is for the ID to be optional:
> Alias names are often suffixed with a numeric ID, especially when there may
> be multiple instances of the same type. The ID typically corresponds to the
[...]

Thanks,
Horia
