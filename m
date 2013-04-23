From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [V3 patch 06/19] cpuidle: make a single register function for all
Date: Tue, 23 Apr 2013 19:26:38 +0530
Message-ID: <51769316.9090309@ti.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org>
 <516FB35D.7000303@ti.com> <51769011.7030608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51769011.7030608@linaro.org>
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
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, linus.walleij@linaro.org, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 April 2013 07:13 PM, Daniel Lezcano wrote:
> On 04/18/2013 10:48 AM, Santosh Shilimkar wrote:
>> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>>
>>> 	cpuidle_register_driver(drv);
>>> 	for_each_possible_cpu(cpu) {
>>> 		device = &per_cpu(cpuidle_dev, cpu);
>>> 		cpuidle_register_device(device);
>>> 	}
>>>
>> Not exactly related to $subject patch but the driver should
>> be registered after all devices has been registered to avoid
>> devices start using the idle state data as soon as it is
>> registered. In multi CPU system, this race can easily happen.
> 
> Could you elaborate what problems the system will be facing if a cpu
> starts using the idle state data as soon as it is registered ?
> 
> Is there a bug related to this ?
>
Ofcouse. In multi-CPU scenario, where CPU C-states needs co-ordination
can just lead into unknown issues if all the CPUs are not already part
registered.
 
>> Current CPUIDLE core layer is also written with the assumption
>> that driver will be registered first and then the devices which
>> is not mandatory as per typical drive/device model.
> 
> Yes, that's true. The framework assumes cpuidle_register_driver is
> called before cpuidle_register_device.
> 
>> May be you can fix that part while you are creating this common
>> wrapper.
> 
> Personally, as that will modify the cpuidle core layer and the changes
> are not obvious (because of the design of the code) I prefer to do that
> in a separate patchset if it is worth to do it - if there is a bug
> related to it, then there is no discussion, we have to do it :)
> 
Sure. It would have been nice if you would have clarified that before
posting the next version.

You still need to fix the kernel doc in your v4 though.

Regards,
Santosh
