From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Mon, 18 Aug 2014 15:21:00 +0100
Message-ID: <20140818142100.GD20043@localhost>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1408131223501.1133@knanqh.ubzr>
 <20140813170440.GA30822@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1408131319210.1133@knanqh.ubzr>
 <20140814112911.GA5039@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140814112911.GA5039@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvi>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 14, 2014 at 12:29:11PM +0100, Lorenzo Pieralisi wrote:
> Here the refreshed patch is:
> 
> -- >8 --
> Subject: [PATCH] drivers: cpuidle: implement DT based idle states
>  infrastructure
> 
> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
> 
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.
> 
> The parsing API accepts a start index that defines the first idle state
> that should be initialized by the parsing code in order to give new and
> legacy driver flexibility over which states should be parsed using the
> new DT mechanism.
> 
> The idle states list is obtained from the first cpu in the driver
> cpumask, which implicitly means the parsing code expects idle states
> (and related list of phandles) to be the same for all CPUs in the
> CPUidle driver mask. The kernel does not check this assumption, it must
> be enforced by the bootloader to ensure correct system behaviour.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig          |   3 +
>  drivers/cpuidle/Makefile         |   1 +
>  drivers/cpuidle/dt_idle_states.c | 175 +++++++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/dt_idle_states.h |   5 ++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/cpuidle/dt_idle_states.c
>  create mode 100644 drivers/cpuidle/dt_idle_states.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
