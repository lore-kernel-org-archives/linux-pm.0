From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: Re: [PATCH v3 4/5] PM: Add visible HIBERNATION_INTERFACE
	and hide HIBERNATION
Date: Tue, 15 Mar 2011 15:16:09 -0700
Message-ID: <AANLkTimyDVG7YjNmQGjo7pnKyZE1cXSZyVNx_rekNgNC@mail.gmail.com>
References: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
	<201103152238.29405.rjw@sisk.pl>
Reply-To: rshriram@cs.ubc.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103152238.29405.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

2011/3/15 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> Sorry, I didn't have the time to review the patch in detail before.
>
> On Saturday, March 12, 2011, Shriram Rajagopalan wrote:
>> HIBERNATION covers the main hibernation control code and freeze-thaw
>> pm events, that xen's save/restore also uses. Explicitly enabling
>> an independant hibernation functionality to enable xen's save/restore
>> is a bit ugly. Define a new user visible symbol HIBERNATION_INTERFACE
>> that "selects" HIBERNATION and covers the main hibernation control code
>> instead of HIBERNATION. This way, we can also make XEN_SAVE_RESTORE
>> "select" HIBERNATION, enabling only the freeze-thaw code.
>>
>> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
>> ---
>> =A0kernel/power/Kconfig =A0 =A0 | =A0 =A09 +++++++--
>> =A0kernel/power/hibernate.c | =A0 =A04 ++++
>> =A0kernel/power/main.c =A0 =A0 =A0| =A0 =A02 +-
>> =A0kernel/power/user.c =A0 =A0 =A0| =A0 =A02 ++
>> =A04 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> index 4603f08..493c678 100644
>> --- a/kernel/power/Kconfig
>> +++ b/kernel/power/Kconfig
>> @@ -19,10 +19,15 @@ config SUSPEND_FREEZER
>> =A0 =A0 =A0 =A0 Turning OFF this setting is NOT recommended! If in doubt=
, say Y.
>>
>> =A0config HIBERNATION
>> - =A0 =A0 bool "Hibernation (aka 'suspend to disk')"
>> - =A0 =A0 depends on SWAP && ARCH_HIBERNATION_POSSIBLE
>> + =A0 =A0 def_bool n
>
> You don't need that. =A0Simply use "bool"
>
>> + =A0 =A0 depends on ARCH_HIBERNATION_POSSIBLE
>
> That need not depend on it, HIBERNATION_INTERFACE should instead.
>
Does that mean the pm_ops interface does not depend on the ARCH_HIB.. ?
>> =A0 =A0 =A0 select LZO_COMPRESS
>> =A0 =A0 =A0 select LZO_DECOMPRESS
>
> These two selects may be moved to HIBERNATION_INTERFACE too.
>
>> +
>> +config HIBERNATION_INTERFACE
>> + =A0 =A0 bool "Hibernation (aka 'suspend to disk')"
>> + =A0 =A0 depends on SWAP
>> + =A0 =A0 select HIBERNATION
>> =A0 =A0 =A0 ---help---
>> =A0 =A0 =A0 =A0 Enable the suspend to disk (STD) functionality, which is=
 usually
>> =A0 =A0 =A0 =A0 called "hibernation" in user interfaces. =A0STD checkpoi=
nts the
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index 1832bd2..13bcf69 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -592,6 +592,7 @@ static int prepare_processes(void)
>> =A0 * =A0 hibernate - The granpappy of the built-in hibernation manageme=
nt
>> =A0 */
>>
>> +#ifdef CONFIG_HIBERNATION_INTERFACE
>
> Please don't do that. =A0Please make the whole hibernate.c depend on
> CONFIG_HIBERNATION_INTERFACE.
>
This #if only wraps the hibernate() function. There is a whole lot of code
(global functions too) before the hibernate() function.

As i mentioned in the first email 0/5, simply making
hibernate.c and user.c depend on HIBERNATION_INTERFACE does not work.

I got the following linker errors.

kernel/built-in.o: In function `sys_reboot':
kernel/sys.c:440: undefined reference to `hibernate'
kernel/built-in.o: In function `state_store':
kernel/power/main.c:185: undefined reference to `hibernate'
kernel/built-in.o: In function `hibernate_preallocate_memory':
kernel/power/snapshot.c:1411: undefined reference to `swsusp_show_speed'
kernel/built-in.o: In function `swsusp_check':
kernel/power/swap.c:933: undefined reference to `swsusp_resume_device'
kernel/power/swap.c:938: undefined reference to `swsusp_resume_block'
kernel/power/swap.c:946: undefined reference to `swsusp_resume_block'
kernel/built-in.o: In function `load_image_lzo':
kernel/power/swap.c:878: undefined reference to `swsusp_show_speed'
kernel/built-in.o: In function `load_image':
kernel/power/swap.c:741: undefined reference to `swsusp_show_speed'
kernel/built-in.o: In function `save_image_lzo':
kernel/power/swap.c:502: undefined reference to `lzo1x_1_compress'
kernel/power/swap.c:543: undefined reference to `swsusp_show_speed'
kernel/built-in.o: In function `swsusp_swap_check':
kernel/power/swap.c:221: undefined reference to `swsusp_resume_block'
kernel/power/swap.c:221: undefined reference to `swsusp_resume_device'
kernel/built-in.o: In function `mark_swapfiles':
kernel/power/swap.c:195: undefined reference to `swsusp_resume_block'
kernel/power/swap.c:202: undefined reference to `swsusp_resume_block'
kernel/built-in.o: In function `save_image':
kernel/power/swap.c:418: undefined reference to `swsusp_show_speed'
drivers/built-in.o: In function `acpi_suspend':
drivers/acpi/sleep.c:584: undefined reference to `hibernate'
drivers/built-in.o: In function `ata_scsi_start_stop_xlat':
drivers/ata/libata-scsi.c:1331: undefined reference to
`system_entering_hibernation'
drivers/built-in.o: In function `acpi_sleep_init':
drivers/acpi/sleep.c:782: undefined reference to `hibernation_set_ops'
arch/x86/power/built-in.o: In function `restore_registers':
arch/x86/power/hibernate_asm_64.S:145: undefined reference to `in_suspend'

Seeing errors from arch/.. was also the reason why I made HIBERNATE depend =
on
ARCH_HIBERNATION_POSSIBLE

>> =A0int hibernate(void)
>> =A0{
>> =A0 =A0 =A0 int error;
>> @@ -667,6 +668,8 @@ int hibernate(void)
>> =A0 =A0 =A0 return error;
>> =A0}
>>
>> +#else /* !CONFIG_HIBERNATION_INTERFACE */
>> +int hibernate(void) { return -ENOSYS; }
>
> And move that to a header.
was done for the same reason as above. linux/suspend.h
has a similar definition but it encompasses a whole set of
swsusp_* functions, register_nosave stuff. But defining alternate
versions there means hibernate.c, snapshot.c etc have to depend on
HIBERNATION_INTERFACE - which causes errors stated above.

>
>> =A0/**
>> =A0 * =A0 software_resume - Resume from a saved image.
>> @@ -1029,3 +1032,4 @@ __setup("noresume", noresume_setup);
>> =A0__setup("resume_offset=3D", resume_offset_setup);
>> =A0__setup("resume=3D", resume_setup);
>> =A0__setup("hibernate=3D", hibernate_setup);
>> +#endif /* !CONFIG_HIBERNATION_INTERFACE */
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index 8eaba5f..686a130 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject *kobj, stru=
ct kobj_attribute *attr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s +=3D sprintf(s,"%s ", pm_s=
tates[i]);
>> =A0 =A0 =A0 }
>> =A0#endif
>> -#ifdef CONFIG_HIBERNATION
>> +#ifdef CONFIG_HIBERNATION_INTERFACE
>> =A0 =A0 =A0 s +=3D sprintf(s, "%s\n", "disk");
>> =A0#else
>> =A0 =A0 =A0 if (s !=3D buf)
>> diff --git a/kernel/power/user.c b/kernel/power/user.c
>> index c36c3b9..5f36ee7 100644
>> --- a/kernel/power/user.c
>> +++ b/kernel/power/user.c
>> @@ -458,6 +458,7 @@ static long snapshot_ioctl(struct file *filp, unsign=
ed int cmd,
>> =A0 =A0 =A0 return error;
>> =A0}
>>
>> +#ifdef CONFIG_HIBERNATION_INTERFACE
>> =A0static const struct file_operations snapshot_fops =3D {
>> =A0 =A0 =A0 .open =3D snapshot_open,
>> =A0 =A0 =A0 .release =3D snapshot_release,
>> @@ -479,3 +480,4 @@ static int __init snapshot_device_init(void)
>> =A0};
>>
>> =A0device_initcall(snapshot_device_init);
>> +#endif /* CONFIG_HIBERNATION_INTERFACE */
>>
>
> Again, please make the entire user.c depend on CONFIG_HIBERNATION_INTERFA=
CE
> instead of adding #ifdefs to the file.
>
As above.

> Thanks,
> Rafael
>
>
