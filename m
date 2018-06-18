From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] power: vexpress: fix corruption in notifier registration
Date: Mon, 18 Jun 2018 16:51:12 +0100
Message-ID: <5b5cb752-2128-4eaf-c477-877b32ac266e@arm.com>
References: <1529322007-4637-1-git-send-email-sudeep.holla@arm.com>
 <20180618145608.GA26780@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180618145608.GA26780@e107981-ln.cambridge.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pm@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>, Sebastian Reichel <sre@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 18/06/18 15:56, Lorenzo Pieralisi wrote:
> On Mon, Jun 18, 2018 at 12:40:07PM +0100, Sudeep Holla wrote:
>> Vexpress platforms provide two different restart handlers: SYS_REBOOT
>> that restart the entire system, while DB_RESET only restarts the
>> daughter board containing the CPU. DB_RESET is overridden by SYS_REBOOT
>> if it exists.
>>
>> notifier_chain_register used in register_restart_handler by design
>> allows notifier to be registered once only, however vexpress restart
>> notifier can get registered twice.
> 
> Nit: I would say "notifier_chain_register() relies on notifiers to be
> registered only once to work properly"; put it differently, it allows
> notifiers to be registered twice (ie it does nothing to prevent it),
> that's why we have this issue.
> 

Indeed. I saw there's notifier_chain_cond_register too, not sure why
that's not used everywhere. I will change from allows to relies in the
wording.

>> When this happen it corrupts list of notifiers, as result some
>> notifiers can be not called on proper event, traverse on list can be
>> cycled forever, and second unregister can access already freed memory.
>>
>> So far, since this was the only restart handler in the system, no issue
>> was observed even if the same notifier was registered twice. However
>> commit 6c5c0d48b686 ("watchdog: sp805: add restart handler") added
>> support for SP805 restart handlers and since the system under test
>> contains two vexpress restart and two SP805 watchdog instances, it was
>> observed that during the boot traversing the restart handler list looped
>> forever as there's a cycle in that list resulting in boot hang.
>>
>> This patch fixes the issues by ensuring that the notifier is installed
>> only once.
>>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/power/reset/vexpress-poweroff.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
>> index 102f95a09460..cdc68eb06a91 100644
>> --- a/drivers/power/reset/vexpress-poweroff.c
>> +++ b/drivers/power/reset/vexpress-poweroff.c
>> @@ -35,6 +35,7 @@ static void vexpress_reset_do(struct device *dev, const char *what)
>>  }
>>  
>>  static struct device *vexpress_power_off_device;
>> +static atomic_t vexpress_restart_nb_refcnt = ATOMIC_INIT(0);
>>  
>>  static void vexpress_power_off(void)
>>  {
>> @@ -96,13 +97,16 @@ static const struct of_device_id vexpress_reset_of_match[] = {
>>  
>>  static int _vexpress_register_restart_handler(struct device *dev)
>>  {
>> -	int err;
>> +	int err = 0;
> 
> Nit: I do not not see why you need to initialize err.
> 

Yes, I did notice this just after I sent it out. Left over from my
debugging, will remove it.

>>  	vexpress_restart_device = dev;
> 
> It is unclear to me how the !vexpress_restart_device sentinel is
> used while registering FUNC_RESET. It is unrelated to this patch
> but if the registration below fails for FUNC_REBOOT can we end
> up in a situation where vexpress_restart_device is initialized
> with no restart handler registered ?
> 

Yes, it took sometime for me to understand that. IIUC, FUNC_RESET is
optional, so it's probed first then !vexpress_restart_device will be
used. FUNC_REBOOT will override FUNC_RESET but not other way around.

> By looking at it I am not a big fan of the vexpress_restart_device
> global variable it has been there since we merged this code but
> its usage is a bit obscure.
> 

Yes, I was thinking of making access to it locked via mutex or some lock
but that won't fix the issue seen as it won't prevent FUNC_RESET being
probed first and then FUNC_REBOOT which will attempt to register
notifier again anyways.

-- 
Regards,
Sudeep
