From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/4] ARM: dts: pxa: add pxa25x cpu operating points
Date: Wed, 19 Oct 2016 19:21:17 +0530
Message-ID: <20161019135117.GF11471@vireshk-i7>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-3-git-send-email-robert.jarzmik@free.fr>
 <20161018113944.GC11471@vireshk-i7> <87vawp4qv0.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87vawp4qv0.fsf@belgarion.home>
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

On 18-10-16, 17:30, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 15-10-16, 21:57, Robert Jarzmik wrote:
> >> Add the relevant data taken from the PXA 25x Electrical, Mechanical, and
> >> Thermal Specfication. This will be input data for cpufreq-dt driver.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >>  arch/arm/boot/dts/pxa25x.dtsi | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
> >> index 0d1e012178c4..16b4e8bad4a5 100644
> >> --- a/arch/arm/boot/dts/pxa25x.dtsi
> >> +++ b/arch/arm/boot/dts/pxa25x.dtsi
> >> @@ -89,4 +89,29 @@
> >>  		clocks = <&clktimer>;
> >>  		status = "okay";
> >>  	};
> >> +
> >> +	pxa250_opp_table: opp_table0 {
> >> +		compatible = "operating-points-v2";
> >> +
> >> +		opp@99500 {
> >
> > We have been keeping the values in ^^^ same as the values present
> > below. Any specific reason for making it different here ?
> No, that's a good comment, I'll change that.
> 
> I wrote this incrementaly, first the node, then the opp-hz. Then I realized that
> the source crystal, at 3.8684 MHz didn't provide a round 99.5 MHz core clock,
> but a 99.5328 MHz clock.
> 
> Anyway, I'll change that ... let's say into opp@99533 in this case ?

Just write the whole value 99532800.

-- 
viresh
