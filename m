From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4] cpufreq: add imx6q-cpufreq driver
Date: Thu, 31 Jan 2013 11:41:50 +0800
Message-ID: <20130131034148.GB17607@S2101-09.ap.freescale.net>
References: <1359214303-3319-1-git-send-email-shawn.guo@linaro.org>
 <20130129025652.GB11546@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130129025652.GB11546@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Eric Nelson <eric.nelson@boundarydevices.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 29, 2013 at 10:56:54AM +0800, Shawn Guo wrote:
> On Sat, Jan 26, 2013 at 11:31:43PM +0800, Shawn Guo wrote:
> > Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> > hardware specific frequency and voltage scaling requirements.
> > 
> > The driver supports module build and is instantiated by the platform
> > device/driver mechanism, so that it will not be instantiated on other
> > platforms, as IMX is built with multiplatform support.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Rafael,
> 
> I think the patch needs to go via cpufreq tree, as it has dependency
> on Nishanth's "PM / OPP : export symbol consolidation" series.

Rafael,

Please hold off this one.  I plan to send v5 to handle regulator
latency through regulator API, since my colleague is pushing patches
to take care of voltage ramping time in anatop regulator driver.

Shawn
