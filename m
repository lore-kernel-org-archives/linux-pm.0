From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] PM / OPP: optimize dev_pm_opp_set_rate() a bit
Date: Mon, 25 Jul 2016 14:05:11 +0800
Message-ID: <20160725140511.1639552d@xhacker>
References: <1469191370-1285-1-git-send-email-jszhang@marvell.com>
	<201607222230.DZObarhu%fengguang.wu@intel.com>
	<20160725131947.644e6166@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160725131947.644e6166@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Jul 2016 13:19:47 +0800 Jisheng Zhang wrote:

> Dear all,
> 
> On Fri, 22 Jul 2016 22:30:53 +0800 kbuild test robot wrote:
> 
> > Hi,
> > 
> > [auto build test WARNING on pm/linux-next]
> > [also build test WARNING on v4.7-rc7 next-20160722]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/PM-OPP-optimize-dev_pm_opp_set_rate-a-bit/20160722-205339
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> > config: x86_64-allmodconfig (attached as .config)
> > compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> > http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/base/power/opp/core.c: In function 'dev_pm_opp_set_rate':  
> > >> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt_max' may be used uninitialized in this function [-Wmaybe-uninitialized]    
> >       _set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> > >> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt_min' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt' may be used uninitialized in this function [-Wmaybe-uninitialized]    
> 
> These warnings seem weired. We only use them when !IS_ERR(old_opp), and we
> should already set them if !IS_ERR(old_opp). Another weired thing is if
> we add something, printk e.g in _find_freq_ceil(), then these warnings disappear

Hmm, it looks that gcc will inline _find_freq_ceil(), then gcc can't
detect that ou_volt* are already set. Mark _find_freq_ceil() noinline would fix
the warnings

Thanks,
Jisheng

> 
> Could you please kindly give some suggestions about how to fix these warnings?
> 
