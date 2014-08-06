From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 6/7] drivers: cpuidle: initialize big.LITTLE driver
 through DT
Date: Wed, 6 Aug 2014 10:02:20 +0100
Message-ID: <20140806090220.GA24431@e102568-lin.cambridge.arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140723162626.GE20966@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140723162626.GE20966@arm.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Bartlomi
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 23, 2014 at 05:26:26PM +0100, Catalin Marinas wrote:
> On Mon, Jul 21, 2014 at 05:06:25PM +0100, Lorenzo Pieralisi wrote:
> > With the introduction of DT based idle states, CPUidle drivers for ARM
> > can now initialize idle states data through properties in the device tree.
> > 
> > This patch adds code to the big.LITTLE CPUidle driver to dynamically
> > initialize idle states data through the updated device tree source file.
> > 
> > Cc: Chander Kashyap <chander.kashyap@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> I think for this patch (and the exynos one) we should still allow the
> driver to work fine with old DT. Basically if the information is not in
> DT, fall back to the original static definitions.

Yes, this makes sense, I will implement the fall-back mechanism on v7,
that should be final. If in the meanwhile Samsung guys have time to
test the Exynos patch that would be very appreciated.

Thanks,
Lorenzo
