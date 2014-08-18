From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 2/8] Documentation: arm: define DT idle states bindings
Date: Mon, 18 Aug 2014 15:20:41 +0100
Message-ID: <20140818142041.GC20043@localhost>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
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

On Wed, Aug 13, 2014 at 04:52:01PM +0100, Lorenzo Pieralisi wrote:
> ARM based platforms implement a variety of power management schemes that
> allow processors to enter idle states at run-time.
> The parameters defining these idle states vary on a per-platform basis forcing
> the OS to hardcode the state parameters in platform specific static tables
> whose size grows as the number of platforms supported in the kernel increases
> and hampers device drivers standardization.
> 
> Therefore, this patch aims at standardizing idle state device tree bindings
> for ARM platforms. Bindings define idle state parameters inclusive of entry
> methods and state latencies, to allow operating systems to retrieve the
> configuration entries from the device tree and initialize the related power
> management drivers, paving the way for common code in the kernel to deal with
> idle states and removing the need for static data in current and previous
> kernel versions.
> 
> ARM64 platforms require the DT to define an entry-method property
> for idle states.
> 
> On system implementing PSCI as an enable-method to enter low-power
> states the PSCI CPU suspend method requires the power_state parameter to
> be passed to the PSCI CPU suspend function.
> 
> This parameter is specific to a power state and platform specific,
> therefore must be provided by firmware to the OS in order to enable
> proper call sequence.
> 
> Thus, this patch also adds a property in the PSCI bindings that
> describes how the PSCI CPU suspend power_state parameter should be
> defined in DT in all device nodes that rely on PSCI CPU suspend method usage.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
>  .../devicetree/bindings/arm/idle-states.txt        | 679 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/psci.txt     |  14 +-
>  3 files changed, 700 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
