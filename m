From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for
 device-tree
Date: Wed, 19 Oct 2016 19:22:08 +0530
Message-ID: <20161019135208.GG11471@vireshk-i7>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
 <20161018113835.GB11471@vireshk-i7> <87r37d4qlw.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87r37d4qlw.fsf@belgarion.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

On 18-10-16, 17:35, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 15-10-16, 21:57, Robert Jarzmik wrote:
> >> For device-tree based pxa25x and pxa27x platforms, cpufreq-dt driver is
> >> doing the job as well as pxa2xx-cpufreq, so add these platforms to the
> >> compatibility list.
> >> 
> >> This won't work for legacy non device-tree platforms where
> >> pxa2xx-cpufreq is still required.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> >> index 0bb44d5b5df4..356825b5c9b8 100644
> >> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> >> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> >> @@ -32,6 +32,8 @@ static const struct of_device_id machines[] __initconst = {
> >>  	{ .compatible = "fsl,imx7d", },
> >>  
> >>  	{ .compatible = "marvell,berlin", },
> >> +	{ .compatible = "marvell,pxa250", },
> >> +	{ .compatible = "marvell,pxa270", },
> >>  
> >>  	{ .compatible = "samsung,exynos3250", },
> >>  	{ .compatible = "samsung,exynos4210", },
> >
> > Isn't there a race between cpufreq-dt and the platform driver to
> > register first ?
> Ah, could you be more specific about the race you're talking of ?
> 
> My understanding was that cpufreq-dt-platdev does create the device, and
> cpufreq-dt is a driver for it, so there is no race but a direct relationship
> AFAIU.

I mean that both the driver may try to register to the cpufreq core if
they are both compiled in a single image.

-- 
viresh
