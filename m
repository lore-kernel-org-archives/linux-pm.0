From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ARM: dts: exynos: Use thermal fuse value for thermal
 zone 0 on Exynos5420
Date: Sat, 4 Mar 2017 10:01:09 +0200
Message-ID: <20170304080109.j2kuwmqj7mgfx3ky@kozik-lap>
References: <20170211201456.27974-1-krzk@kernel.org>
 <252f9e32-ff2c-a1ce-3c98-6383a1148e02@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <252f9e32-ff2c-a1ce-3c98-6383a1148e02@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, Willy WOLFF <willy.mh.wolff@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 03, 2017 at 06:50:06PM -0300, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 02/11/2017 05:14 PM, Krzysztof Kozlowski wrote:
> > In Odroid XU3 Lite board, the temperature levels reported for thermal
> > zone 0 were weird. In warm room:
> > 	/sys/class/thermal/thermal_zone0/temp:32000
> > 	/sys/class/thermal/thermal_zone1/temp:51000
> > 	/sys/class/thermal/thermal_zone2/temp:55000
> > 	/sys/class/thermal/thermal_zone3/temp:54000
> > 	/sys/class/thermal/thermal_zone4/temp:51000
> > 
> > Sometimes after booting the value was even equal to ambient temperature
> > which is highly unlikely to be a real temperature of sensor in SoC.
> > 
> > The thermal sensor's calibration (trimming) is based on fused values.
> > In case of the board above, the fused values are: 35, 52, 43, 58 and 43
> > (corresponding to each TMU device).  However driver defined a minimum value
> > for fused data as 40 and for smaller values it was using a hard-coded 55
> > instead.  This lead to mapping data from sensor to wrong temperatures
> > for thermal zone 0.
> > 
> > Various vendor 3.10 trees (Hardkernel's based on Samsung LSI, Artik 10)
> > do not impose any limits on fused values.  Since we do not have any
> > knowledge about these limits, use 0 as a minimum accepted fused value.
> > This should essentially allow accepting any reasonable fused value thus
> > behaving like vendor driver.
> > 
> > The exynos5420-tmu-sensor-conf.dtsi is copied directly from existing
> > exynso4412 with one change - the samsung,tmu_min_efuse_value.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Testing on other Exynos542x boards is much appreciated. Especially I
> > wonder what efuse values are there.
> 
> I tested on both Exynos5422 Odroid XU4 and Exynos5800 Peach Pi boards.
> 
> The temperatures levels reported for these two boards on a warm room are:
> 
> Odroid XU4
> 
> # cat /sys/class/thermal/thermal_zone*/temp
> 50000
> 50000
> 54000
> 51000
> 48000
> 
> Peach Pi
> 
> # cat /sys/class/thermal/thermal_zone*/temp
> 42000
> 44000
> 27000 <-- weird value for thermal zone 2 like zone 0 in your XU3 lite
> 45000
> 45000
> 
> And the efuse values for the TMU devices are:
> 
> Odroid XU4
> 
> TMU0 = 45
> TMU1 = 44
> TMU2 = 44
> TMU3 = 46
> TMU3 = 46
> 
> Peach Pi
> 
> TMU0 = 44
> TMU1 = 46
> TMU2 = 36
> TMU3 = 53
> TMU3 = 46
> 
> The fused value for TMU2 is < 40 so that explains the weird temperature
> level for thermal zone 2 in Peach. So after your patch, makes more sense:
> 
> # cat /sys/class/thermal/thermal_zone*/temp
> 41000
> 42000
> 45000
> 43000
> 43000

Great! Thanks for testing!


> I wonder though if 0 is the best value or if we should just lower more
> to cover the used e-fuse values in Exynos5 boards. But as you said,
> we have no knowledge about these limits...

Yeah... we could set value of 10 or 20... but that would be blind shot.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Thanks,
Krzysztof
