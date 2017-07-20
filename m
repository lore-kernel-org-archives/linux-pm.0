From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH v8 3/9] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Thu, 20 Jul 2017 12:44:52 +0800
Message-ID: <c6e4dce0-853f-a4d4-be64-ef4bb0f68162@electromag.com.au>
References: <201707200255.SHskJrcM%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201707200255.SHskJrcM%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-AU
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 20/07/2017 02:30, kbuild test robot wrote:
> Hi Phil,
> 
> [auto build test ERROR on wsa/i2c/for-next]
> [also build test ERROR on v4.13-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Phil-Reid/i2c-i2c-smbus-Use-threaded-irq-for-smbalert/20170719-095934
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> config: powerpc-ppc6xx_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/i2c/i2c-core-base.o: In function `i2c_register_adapter':
>>> drivers/i2c/i2c-core-base.c:1262: undefined reference to `of_i2c_setup_smbus_alert'
> 

I understand how this is occurring.
I2C=y, OF=y and I2C_PARPORT=m
I2C_PARPORT selects I2C_SMBUS setting it to m

Calling a function in i2c-smbus (module) from i2c-core (builtin) is then a problem.

However there doesn't seem to be a way (that I can see) to have select statement force I2C_SMBUS=y if I2C=y

Can I get a hint on what the correct course of action is.



-- 
Regards
Phil Reid

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
