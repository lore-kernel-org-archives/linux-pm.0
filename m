From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/10] generic thermal management
Date: Fri, 1 Feb 2008 23:23:16 -0500
Message-ID: <200802012323.16244.lenb__21342.2208013528$1201926339$gmane$org@kernel.org>
References: <1200556238.2935.115.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1200556238.2935.115.camel@acpi-sony.sh.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sujith.thomas@intel.com
List-Id: linux-pm@vger.kernel.org

series applied to acpi-test.

thanks,
-Len

On Thursday 17 January 2008 02:50, Zhang Rui wrote:
> Hi, all,
> 
> This patch series introduces a new generic thermal sysfs driver
> which provides a set of interfaces for thermal zone devices (sensors)
> and thermal cooling devices (fan, processor...) to register with the
> thermal management solution and to be a part of it.
> 
> And it also includes the implementation for ACPI thermal zone.
> Standard sysfs I/F should be available for all ACPI thermal zones
> with this patch series applied.
> 
> Patch 01 creates the new generic thermal sysfs driver.
> 	 It defines two kinds of devices, thermal zone device and
> 	 thermal cooling device.
> 	 A thermal zone device usually contains a sensor to monitor the
> 	 temperature, several trip points and a bunch of cooling devices
> 	 associated with them.
> 	 A thermal cooling device is a device that can be throttled
> 	 to cool the system.
> 	 The generic thermal sysfs driver creates the standard sysfs I/F
> 	 for any registered thermal zone and thermal cooling device.
> 	 And binds the cooling devices to thermal zones if possible.
> 
> Patch 02 registers ACPI thermal zone as thermal zone device.
> 
> Patch 03 is a fix of violations of ACPI spec in ACPI thermal driver.
> 
> Patch 04 registers ACPI Fan as thermal cooling device.
> 
> Patch 05 registers ACPI Processor as thermal cooling device.
> 
> Patch 06 registers ACPI Video LCD as thermal cooling device.
> 	 Because throttling the backlight of LCD can cool the system as well.
> 
> Patch 09 creates a new platform specific driver, intel_menlow.
> 	 which is the thermal enhancement driver for intel menlow platform.
> 	 It programs the sensor of each thermal zone and registers the
> 	 intel memory controller (hardware id INT0002) as thermal cooling device.
> 
> Patch 07 08 and 10 are minor fixes, please refer to the changelog of each patch.
> 
> I've tested them and they work well on several systems.
> I'd like to get some feedbacks from the list. Any comments are appreciated. :)
> 
> Thanks,
> Rui
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
