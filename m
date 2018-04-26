From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
Date: Thu, 26 Apr 2018 15:42:42 +0530
Message-ID: <20180426101242.vaqdclizsnohoqr7@vireshk-i7>
References: <e98965068836e673ea826e8a03fd01e168fce3ed.1524561482.git.viresh.kumar@linaro.org>
 <201804261439.n2Ff25A0%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201804261439.n2Ff25A0%fengguang.wu@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kbuild test robot <lkp@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Rafael Wysocki <rjw@rjwysocki.net>, kbuild-all@01.org, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 26-04-18, 17:32, kbuild test robot wrote:
> Hi Miquel,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.17-rc2 next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Viresh-Kumar/cpufreq-dt-Allow-platforms-to-provide-suspend-resume-hooks/20180426-101030
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cpufreq/armada-37xx-cpufreq.c: In function 'armada37xx_cpufreq_driver_init':
> >> drivers/cpufreq/armada-37xx-cpufreq.c:268:3: error: label 'put_clk' used but not defined
>       goto put_clk;
>       ^~~~

Fixed, thanks.

-- 
viresh
