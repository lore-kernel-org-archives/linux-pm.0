From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [RFC] w1: regression, remove need for ida and use
 PLATFORM_DEVID_AUTO
Date: Thu, 2 Feb 2017 08:23:03 -0600
Message-ID: <308e185e-26eb-39ee-d82f-a0d210a41743@ti.com>
References: <d0b52b94-0c87-61f8-32ff-99f2a354e500@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d0b52b94-0c87-61f8-32ff-99f2a354e500@tul.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Cvek <petr.cvek@tul.cz>, zbr@ioremap.net, Sebastian Reichel <sre@kernel.org>, philipp.zabel@gmail.com, lost.distance@yahoo.com, daniel@caiaq.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/01/2017 07:05 PM, Petr Cvek wrote:
> Patch 
> 	w1: remove need for ida and use PLATFORM_DEVID_AUTO
> 	098f9fb0c962eb2fdba5f9d34f4cf7a938237184 
> 
> causes a regression in the w1_ds2760 driver. Initialization creates a name "ds2760-battery.0.auto". It seems that name of that size will cause checking code in __thermal_cooling_device_register() from thermal_core.c to fail as it checks for names shorter than 20 chars:
> 
> 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> 		return ERR_PTR(-EINVAL);
> 
> A second problem seems to be with magician_supplicants list as "ds2760-battery.0" does not match in a test power_supply_am_i_supplied() in ds2760_battery_update_status() from drivers/power/supply/ds2760_battery.c . This causes status flag to be forever in POWER_SUPPLY_STATUS_DISCHARGING state.
> 
> Functionality returned after I hotfix changed (drivers/w1/slaves/w1_ds2760.c)
> 
> 	pdev = platform_device_alloc("ds2760-battery", PLATFORM_DEVID_AUTO);
> 
> to
> 
> 	pdev = platform_device_alloc("ds2760-battery", 0);
> 
> Which solution do you advise. Shortening the name let's say just to "ds2760" (with changes to arch files, w1 files and supply files), increasing THERMAL_NAME_LENGTH to let's say 32 (I don't know if this doesn't break something other) or just reverting to the old behavior?
> 

If 20 is no longer the max thermal name then THERMAL_NAME_LENGTH should
be changed.

As for the couple boards hard-coding "ds2760-battery.0", this is a
problem that should be fix regardless of any fix we chose here as IDA is
not guaranteed to return 0, so the battery could just as easily be
called ds2760-battery.7. (I've had this discussion before as the N900
user-space also make this mistake).

Andrew

> Best regards,
> Petr
> 
