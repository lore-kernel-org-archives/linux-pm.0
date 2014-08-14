From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Thu, 14 Aug 2014 17:02:12 +0100
Message-ID: <20140814160212.GA5328@red-moon>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1408131223501.1133@knanqh.ubzr>
 <20140813170440.GA30822@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1408131319210.1133@knanqh.ubzr>
 <20140814112911.GA5039@red-moon>
 <alpine.LFD.2.11.1408141142530.29347@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.11.1408141142530.29347@knanqh.ubzr>
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
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nv>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 14, 2014 at 04:47:57PM +0100, Nicolas Pitre wrote:
> On Thu, 14 Aug 2014, Lorenzo Pieralisi wrote:
> 
> > On Wed, Aug 13, 2014 at 06:29:49PM +0100, Nicolas Pitre wrote:
> > > So if you tell me a messed-up DT won't bear much consequences then I'm 
> > > fine with that.
> > 
> > Nico, on second thoughts, since Ashwin raised the point too and I think
> > that at these early stages it might turn out useful, I gave coding
> > the check a go. I tried to make the check self contained so that we can
> > yank it out if we do not want it in the final version or we will want
> > to remove it later.
> > 
> > Here the refreshed patch is:
> > 
> > -- >8 --
> > Subject: [PATCH] drivers: cpuidle: implement DT based idle states
> >  infrastructure
> > 
> > On most common ARM systems, the low-power states a CPU can be put into are
> > not discoverable in HW and require device tree bindings to describe
> > power down suspend operations and idle states parameters.
> > 
> > In order to enable DT based idle states and configure idle drivers, this
> > patch implements the bulk infrastructure required to parse the device tree
> > idle states bindings and initialize the corresponding CPUidle driver states
> > data.
> > 
> > The parsing API accepts a start index that defines the first idle state
> > that should be initialized by the parsing code in order to give new and
> > legacy driver flexibility over which states should be parsed using the
> > new DT mechanism.
> > 
> > The idle states list is obtained from the first cpu in the driver
> > cpumask, which implicitly means the parsing code expects idle states
> > (and related list of phandles) to be the same for all CPUs in the
> > CPUidle driver mask. The kernel does not check this assumption, it must
> > be enforced by the bootloader to ensure correct system behaviour.
> 
> Is this last sentence still true?

Nope, you are right. Fixed the commit log, a stale comment in the code
and dt nodes ref counting, if I get no additional comments I will post
this patch with v8, that should be final.

Thank you !!!
Lorenzo
