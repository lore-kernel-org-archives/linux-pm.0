From: Joe Perches <joe@perches.com>
Subject: usleep_range without a range
Date: Mon, 12 Feb 2018 14:03:48 -0800
Message-ID: <1518473028.22190.20.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: UlfHansson <ulf.hansson@linaro.org>, MichaelTurquette <mturquette@baylibre.com>, StephenBoyd <sboyd@kernel.org>, "RafaelJ.Wysocki" <rjw@rjwysocki.net>, VireshKumar <viresh.kumar@linaro.org>, BenjaminHerrenschmidt <benh@kernel.crashing.org>, PaulMackerras <paulus@samba.org>, MichaelEllerman <mpe@ellerman.id.au>, SakariAilus <sakari.ailus@iki.fi>, MauroCarvalhoChehab <mchehab@kernel.org>, SebastianReichel <sre@kernel.org>, GregKroah-Hartman <gregkh@linuxfoundation.org>, LiamGirdwood <lgirdwood@gmail.com>, MarkBrown <broonie@kernel.org>, JaroslavKysela <perex@perex.cz>, TakashiIwai <tiwai@suse.com>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

scheduling can generally be better when these values are
not identical.  Perhaps these ranges should be expanded.

$ git grep -P -n "usleep_range\s*\(\s*([\w\.\>\-]+)\s*,\s*\1\s*\)"
drivers/clk/ux500/clk-sysctrl.c:45:             usleep_range(clk->enable_delay_us, clk->enable_delay_us);
drivers/cpufreq/pmac64-cpufreq.c:140:           usleep_range(1000, 1000);
drivers/cpufreq/pmac64-cpufreq.c:239:   usleep_range(10000, 10000); /* should be faster , to fix */
drivers/cpufreq/pmac64-cpufreq.c:284:           usleep_range(500, 500);
drivers/media/i2c/smiapp/smiapp-core.c:1228:    usleep_range(1000, 1000);
drivers/media/i2c/smiapp/smiapp-core.c:1235:    usleep_range(1000, 1000);
drivers/media/i2c/smiapp/smiapp-core.c:1240:    usleep_range(sleep, sleep);
drivers/media/i2c/smiapp/smiapp-core.c:1387:    usleep_range(5000, 5000);
drivers/media/i2c/smiapp/smiapp-quirk.c:205:    usleep_range(2000, 2000);
drivers/media/i2c/smiapp/smiapp-regs.c:279:             usleep_range(2000, 2000);
drivers/power/supply/ab8500_fg.c:643:   usleep_range(100, 100);
drivers/staging/rtl8192u/r819xU_phy.c:180:      usleep_range(1000, 1000);
drivers/staging/rtl8192u/r819xU_phy.c:736:                      usleep_range(1000, 1000);
drivers/staging/rtl8192u/r819xU_phy.c:740:                      usleep_range(1000, 1000);
sound/soc/codecs/ab8500-codec.c:1065:                   usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
sound/soc/codecs/ab8500-codec.c:1068:                   usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
