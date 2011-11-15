From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 1/3 v3] ARM: EXYNOS4: Support for generic I/O
 power domains on EXYNOS4210/4212
Date: Tue, 15 Nov 2011 18:21:55 +0900
Message-ID: <005801cca378$0488d0e0$0d9a72a0$%kim__14662.7990682193$1321348933$gmane$org@samsung.com>
References: <4EA690EF.4000703@samsung.com>
	<013301cc99cd$8d5a6a00$a80f3e00$%kim@samsung.com>
	<4EB26BE2.2060508@samsung.com>
	<CAGTfZH0xOh=EDRhb3gxOZhV-KQZNY_-o=miBOEne_S5-YsQ_Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <CAGTfZH0xOh=EDRhb3gxOZhV-KQZNY_-o=miBOEne_S5-YsQ_Vg@mail.gmail.com>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: cw00.choi@samsung.com
Cc: 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Sylwester Nawrocki' <snjw23@gmail.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, 'linux-arm-kernel' <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Chanwoo Choi wrote:
> Hi Kukjin Kim,
> =

> Please reply about=A0Sylwester Nawrocki and me.
> 2011/11/3 Sylwester Nawrocki <s.nawrocki@samsung.com>
> Hi Kgene,
>
> On 11/03/2011 03:09 AM, Kukjin Kim wrote:
> > As I said, I don't think we should control/gate the clocks with
regarding power domain.
> As far as I know there is a plan to let the drivers override
start/stop_device callbacks,
> moreover the clock control can be disabled globally by not implementing
start/stop_device
> callbacks or per device by not adding clkdev entities to the device clock
list at runtime
> PM core. So IMHO, there is/going to be enough flexibility.
>
> > It should be controlled by each regarding device driver and in addition,
as I know,
> > to handle block of clock is not recommended on EXYNOS4 now.
> What do you mean by this ? I couldn't find such information in any
documentation.
> Shouldn't "clock gate block" registers be touched by boot loader and the
kernel?
> Our boot loaders disable all clocks, and if the global clock gate is not
enabled
> by the kernel there is no chance any multimedia device will work.
>
> Should the global clock block gate be always enabled then ? I'm afraid it
is not
> optimal form power management POV.
>
Sylwester, let me check again before replying.

> To Kukjin Kim,
>
Hi Chanwoo,

Firstly, please use text-typed e-mail when you reply.

> > It should be controlled by each regarding device driver and in addition,
as I know,
> > to handle block of clock is not recommended on EXYNOS4 now.
>
> As you said, should we separately control power and clock of power domain?

If you ask my opinion, yes, I mean when it is required, it would be
controlled independent.

> or Have to turn on the clock of power domain always?

I didn't say like that.

> I think that it is to happen unnecessary power consumption.

I don't think, when the power of block/domain is downed, does it happen
_really_ meaningful power consumption?

> If we have to maintain=A0on state of power domain clock, please let me kn=
ow
guide about this.
>
> Also,=A0
> For example, fimg2d and framebuffer use LCD0 power domain as parent
device.I
> If fimg2d and framebuffer is disabled state due to not using their,
> I think that we should turn off the clock of LCD0 power domain to reduce
power leakage.

I think, probably it doesn't matter. If any useful data, please let me know.

> Which each regarding device driver control the clock of power domain?
>
> I will expect for your reply.
>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
