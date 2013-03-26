From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
Date: Tue, 26 Mar 2013 20:40:10 +0800
Message-ID: <CAAQ0ZWQ-zex62SKNREK+fuRSg-djpu6dF-qN1Me+8ZEJ=E3F9w@mail.gmail.com>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
 <20130326072458.GA7141@S2101-09.ap.freescale.net>
 <51516DC1.1000807@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51516DC1.1000807@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, linus.walleij@linaro.org, nsekhar@ti.com, kgene.kim@samsung.com, linux@arm.linux.org.uk, patches@linaro.org, magnus.damm@gmail.com, kevin.hilman@linaro.org, plagnioj@jcrosoft.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, ben-linux@fluff.org, tglx@linutronix.de, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 26, 2013 at 10:43:29AM +0100, Daniel Lezcano wrote:
> Hi Shawn,
>
> actually this is because the patch applies on top of:
>
Ah, ok. It will be helpful for people who want to test the series on
their platform, if you can publish a branch for that.

Shawn

> commit 12e849504b861470e5bf991f79c0be71b97c8dac
> Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> Date:   Thu Mar 21 12:21:33 2013 +0000
>
>     cpuidle / imx6 : use CPUIDLE_FLAG_TIMER_STOP flag
>
>     Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
>     to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
>     this state.
>
>     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>     Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
