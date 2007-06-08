From: Oleg Kechin <okechin@gmail.com>
Subject: Standby/resume and MTD driver in OMAP5910 CPU
Date: Fri, 08 Jun 2007 15:38:43 +0300
Message-ID: <46694DD3.8070606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi
I run 2.6.20-rt8 kernel on board like innovator1510 (OMAP5910 cpu ARM925 
v4)
In  case to enter in standby mode board enter Deep Sleep mode cleanly, 
and it is OK,
but in resume there is a problem.
(I use echo -n standby > /sys/power/state command)
When it wakes up,  some times I get string:

omapflash.0: Waiting for chip to be ready timed out. Status 3068
Write of 68 bytes at 0x00945628 failed. returned -5, retlen 0
Not marking the space at 0x00945628 as dirty because the flash driver 
returned retlen zero
Matter here is flash go to standby in one state, but return in another. 
Mtd driver has functions
for such cases  - suspend and resume (cfi_intelext_suspend() & 
cfi_intelext_resume()),
but both of this functions are not calling in suspend/resume process.
I notice, that suspend/resume command are executed on elements that have 
node state in /sys file system,
but mtd doesn't.

Can anyone help me?
PS. flash added like that:
static struct flash_platform_data innovator_flash_data = {
        .map_name       = "cfi_probe",
        .width          = 2,
        .parts          = innovator_partitions,
        .nr_parts       = ARRAY_SIZE(innovator_partitions),
};
static struct resource innovator_flash_resource = {
        .start          = OMAP_CS0_PHYS,
        .end            = OMAP_CS0_PHYS + SZ_32M - 1,
        .flags          = IORESOURCE_MEM,
};
static struct platform_device innovator_flash_device = {
        .name           = "omapflash",
        .id             = 0,
        .dev            = {
                .platform_data  = &innovator_flash_data,
        },
        .num_resources  = 1,
        .resource       = &innovator_flash_resource,
}

Oleg Kechin
