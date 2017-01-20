From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v11 2/8] power: add power sequence library
Date: Fri, 20 Jan 2017 15:52:39 +0800
Message-ID: <20170120075239.GC21013@b29397-desktop>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
 <1483596119-27508-3-git-send-email-peter.chen@nxp.com>
 <20170107085456.w5dhm7qadqa6tc7v@kozik-lap>
 <20170110070240.GA29454@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170110070240.GA29454@b29397-desktop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net
Cc: mark.rutland@arm.com, Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, sre@kernel.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 10, 2017 at 03:02:41PM +0800, Peter Chen wrote:
> On Sat, Jan 07, 2017 at 10:54:56AM +0200, Krzysztof Kozlowski wrote:
> > On Thu, Jan 05, 2017 at 02:01:53PM +0800, Peter Chen wrote:
> > > We have an well-known problem that the device needs to do some power
> > > sequence before it can be recognized by related host, the typical
> > > example like hard-wired mmc devices and usb devices.
> > > 
> > > This power sequence is hard to be described at device tree and handled by
> > > related host driver, so we have created a common power sequence
> > > library to cover this requirement. The core code has supplied
> > > some common helpers for host driver, and individual power sequence
> > > libraries handle kinds of power sequence for devices. The pwrseq
> > > librares always need to allocate extra instance for compatible
> > > string match.
> > > 
> > > pwrseq_generic is intended for general purpose of power sequence, which
> > > handles gpios and clocks currently, and can cover other controls in
> > > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > if only one power sequence is needed, else call of_pwrseq_on_list
> > > /of_pwrseq_off_list instead (eg, USB hub driver).
> > > 
> > > For new power sequence library, it can add its compatible string
> > > to pwrseq_of_match_table, then the pwrseq core will match it with
> > > DT's, and choose this library at runtime.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Tested on Odroid U3 (reset sequence for LAN9730):
> > Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> 
> A nice ping...
> 

Rafael, would you please review it? This series was discussed about
half a year, and many people need it, I hope it can be in v4.11-rc1,
thanks.

-- 

Best Regards,
Peter Chen
