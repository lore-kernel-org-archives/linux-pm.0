From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Wed, 13 Aug 2014 13:29:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1408131319210.1133@knanqh.ubzr>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1408131223501.1133@knanqh.ubzr>
 <20140813170440.GA30822@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140813170440.GA30822@e102568-lin.cambridge.arm.com>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2014, Lorenzo Pieralisi wrote:

> On Wed, Aug 13, 2014 at 05:31:11PM +0100, Nicolas Pitre wrote:
> > On Wed, 13 Aug 2014, Lorenzo Pieralisi wrote:
> > 
> > > On most common ARM systems, the low-power states a CPU can be put into are
> > > not discoverable in HW and require device tree bindings to describe
> > > power down suspend operations and idle states parameters.
> > > 
> > > In order to enable DT based idle states and configure idle drivers, this
> > > patch implements the bulk infrastructure required to parse the device tree
> > > idle states bindings and initialize the corresponding CPUidle driver states
> > > data.
> > > 
> > > The parsing API accepts a start index that defines the first idle state
> > > that should be initialized by the parsing code in order to give new and
> > > legacy driver flexibility over which states should be parsed using the
> > > new DT mechanism.
> > > 
> > > The idle states list is obtained from the first cpu in the driver
> > > cpumask, which implicitly means the parsing code expects idle states
> > > (and related list of phandles) to be the same for all CPUs in the
> > > CPUidle driver mask. The kernel does not check this assumption, it must
> > > be enforced by the bootloader to ensure correct system behaviour.
> > 
> > Can we make the kernel a little less reliant on bootloader to ensure 
> > correct system behaviour please?  If assumptions are assumed by the 
> > kernel, it should at least print a warning and simply ignore the 
> > information when such assumption are not respected.
> 
> I think the check adds complexity (it means stashing the idle states
> phandles for the first cpu, loop through the cpus in the mask and compare
> the phandles to the ones stashed for the first cpu for all cpus in the
> driver mask) for not much.
> 
> I was told that it is not up to the kernel to validate the DT, but if
> you want I can implement the check even though I really think it is
> overkill.

DT validation is not the same as resiliance against messed-up DT 
content.  If the kernel is going to boot regardless then this is fine.  
If the kernel is going to crash, or work suboptimally without returning 
a clue because some implicit assumptions are not respected then this is 
bad.

And people _will_ mess up their DT from time to time.

So if you tell me a messed-up DT won't bear much consequences then I'm 
fine with that.


Nicolas
