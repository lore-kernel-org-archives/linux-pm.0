From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 4/8] arm64: kernel: introduce cpu_init_idle CPU
 operation
Date: Mon, 18 Aug 2014 15:21:06 +0100
Message-ID: <20140818142106.GE20043@localhost>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1407945127-27554-5-git-send-email-lorenzo.pieralisi@arm.com>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.ku>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 13, 2014 at 04:52:03PM +0100, Lorenzo Pieralisi wrote:
> The CPUidle subsystem on ARM64 machines requires the idle states
> implementation back-end to initialize idle states parameter upon
> boot. This patch adds a hook in the CPU operations structure that
> should be initialized by the CPU operations back-end in order to
> provide a function that initializes cpu idle states.
> 
> This patch also adds the infrastructure to arm64 kernel required
> to export the CPU operations based initialization interface, so
> that drivers (ie CPUidle) can use it when they are initialized
> at probe time.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/cpu_ops.h |  3 +++
>  arch/arm64/include/asm/cpuidle.h | 13 +++++++++++++
>  arch/arm64/kernel/Makefile       |  1 +
>  arch/arm64/kernel/cpuidle.c      | 29 +++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+)
>  create mode 100644 arch/arm64/include/asm/cpuidle.h
>  create mode 100644 arch/arm64/kernel/cpuidle.c

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
