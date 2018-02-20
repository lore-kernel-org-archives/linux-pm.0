From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 06/13] power: supply: axp20x_battery: use data struct
 for variant specific code
Date: Tue, 20 Feb 2018 17:12:25 +0800
Message-ID: <201802201606.lLg38XZv%fengguang.wu@intel.com>
References: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, lars@metafoo.de, thomas.petazzoni@bootlin.com, linux-pm@vger.kernel.org, maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, linux@armlinux.org.uk, sre@kernel.org, linux-iio@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, kbuild-all@01.org, pmeerw@pmeerw.net, knaack.h@gmx.de, lee.jones@linaro.org, jic23@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-support-for-AXP813-ADC-and-battery-power-supply/20180220-051138
base:    
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/power/supply/axp20x_battery.c:479:23: sparse: symbol 'axp209_data' was not declared. Should it be
>> drivers/power/supply/axp20x_battery.c:486:23: sparse: symbol 'axp221_data' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
