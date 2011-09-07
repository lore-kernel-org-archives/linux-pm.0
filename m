From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] RE: [PATCH 2/7] x86, acpi,
 tboot: Have a ACPI sleep override instead of calling tboot_sleep.
Date: Wed, 07 Sep 2011 10:27:14 -0700
Message-ID: <4E67A972.6030909__18465.9989936792$1315416509$gmane$org@goop.org>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
	<1314815484-4668-3-git-send-email-konrad.wilk@oracle.com>
	<9F57BF860713DF4BA3EFA4F8C6DFEDAC16F3F524@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F3F524@ORSMSX101.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cihula, Joseph" <joseph.cihula@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "keir@xen.org" <keir@xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Wang,
	Shane" <shane.wang@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 09/06/2011 09:20 PM, Cihula, Joseph wrote:
>> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
>> Sent: Wednesday, August 31, 2011 11:31 AM
>>
>> The ACPI suspend path makes a call to tboot_sleep right before it writes the PM1A, PM1B values. We
>> replace the direct call to tboot via an registration callback similar to __acpi_register_gsi.
>>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: "H. Peter Anvin" <hpa@zytor.com>
>> CC: x86@kernel.org
>> CC: Len Brown <len.brown@intel.com>
>> CC: Joseph Cihula <joseph.cihula@intel.com>
>> CC: Shane Wang <shane.wang@intel.com>
>> CC: xen-devel@lists.xensource.com
>> CC: linux-pm@lists.linux-foundation.org
>> CC: tboot-devel@lists.sourceforge.net
>> CC: linux-acpi@vger.kernel.org
>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> ---
>>  arch/x86/include/asm/acpi.h   |    3 +++
>>  arch/x86/kernel/acpi/boot.c   |    3 +++
>>  arch/x86/kernel/tboot.c       |   13 +++++++++----
>>  drivers/acpi/acpica/hwsleep.c |   12 ++++++++++--
>>  include/linux/tboot.h         |    3 ++-
>>  5 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h index 610001d..49864a1
>> 100644
>> --- a/arch/x86/include/asm/acpi.h
>> +++ b/arch/x86/include/asm/acpi.h
>> @@ -98,6 +98,9 @@ void acpi_pic_sci_set_trigger(unsigned int, u16);  extern int
>> (*__acpi_register_gsi)(struct device *dev, u32 gsi,
>>  				  int trigger, int polarity);
>>
>> +extern int (*__acpi_override_sleep)(u8 sleep_state, u32 pm1a_ctrl,
>> +				    u32 pm1b_ctrl, bool *skip_rest);
>> +
>>  static inline void disable_acpi(void)
>>  {
>>  	acpi_disabled = 1;
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c index 4558f0d..d191b4c
>> 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -552,6 +552,9 @@ static int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,  int
>> (*__acpi_register_gsi)(struct device *dev, u32 gsi,
>>  			   int trigger, int polarity) = acpi_register_gsi_pic;
>>
>> +int (*__acpi_override_sleep)(u8 sleep_state, u32 pm1a_ctrl,
>> +			     u32 pm1b_ctrl, bool *skip_rest) = NULL;
>> +
>>  /*
>>   * success: return IRQ number (>=0)
>>   * failure: return < 0
>> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c index 30ac65d..a18070c 100644
>> --- a/arch/x86/kernel/tboot.c
>> +++ b/arch/x86/kernel/tboot.c
>> @@ -41,7 +41,7 @@
>>  #include <asm/setup.h>
>>  #include <asm/e820.h>
>>  #include <asm/io.h>
>> -
>> +#include <linux/acpi.h>
>>  #include "acpi/realmode/wakeup.h"
>>
>>  /* Global pointer to shared data; NULL means no measured launch. */ @@ -270,7 +270,8 @@ static
>> void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
>>  		offsetof(struct acpi_table_facs, firmware_waking_vector);  }
>>
>> -void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
>> +int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
>> +		 bool *skip_rest)
> Don't you need to use the 'unused' attrib on skip_rest in order to prevent compiler warnings?

No, gcc doesn't warn about unused parameters.

    J
