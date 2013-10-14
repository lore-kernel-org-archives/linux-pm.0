From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Mon, 14 Oct 2013 16:01:36 +0200
Message-ID: <525BF940.2010403@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
 <52333112.2050003@linaro.org> <5235C587.4030802@free-electrons.com>
 <5235EEE1.8020501@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5235EEE1.8020501@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Atsushi Yamagata <yamagata@plathome.co.jp>, Nadav Haklai <nadavh@marvell.com>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Dan Frazier <dann.frazier@canonical.com>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <leif.lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tomonori Kimura <kimura@plathome.co.jp>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Hironobu Shibata <h-shibata@plathome.co.jp>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Chris Van Hoof <van>
List-Id: linux-pm@vger.kernel.org

On 15/09/2013 19:31, Daniel Lezcano wrote:
Hi Daniel,

>>>> +	.state_count = ARMADA_370_XP_MAX_STATES,
>>>> +};
>>>
>>> What about the local timers ? Are they shutdown ?
>>
>> I need to chekc it.
> 
> Ok, if it is the case, there is the flag CPUIDLE_FLAG_TIMER_STOP to tell
> the cpuidle framework to switch to the broadcast timer with this state.

I have just sent a new version taking into account all your remarks, expect
this one. The timers used on Armada 370/XP are only the locale timer then
they are not shutdown when the CPUs go to idle.

Regards,

Gregory

> 
>>>> +static int __init armada_370_xp_cpuidle_init(void)
>>>> +{
>>>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	pr_info("Initializing Armada-XP CPU power management ");
>>>> +
>>>> +	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
>>>> +
>>>> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
>>>> +}
>>>> +
>>>> +module_init(armada_370_xp_cpuidle_init);
>>>
>>> Isn't it possible to replace it by module_platform_driver ? like ux500
>>> or kirkwood ?
>>
>> It should be possible indeed, I will check it.
> 
> That would be great. It is a nicer approach for the single zImage IMHO.
> 
> Thanks !
>   -- Daniel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
