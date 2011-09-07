From: "Cihula, Joseph" <joseph.cihula@intel.com>
Subject: Re: [Xen-devel] RE: [PATCH 5/7] xen/acpi: Domain0 acpi
 parser related platform hypercall
Date: Wed, 7 Sep 2011 17:43:38 +0000
Message-ID: <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F40F0B__9381.29393985054$1315417483$gmane$org@ORSMSX101.amr.corp.intel.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
	<1314815484-4668-6-git-send-email-konrad.wilk@oracle.com>
	<9F57BF860713DF4BA3EFA4F8C6DFEDAC16F3F665@ORSMSX101.amr.corp.intel.com>
	<4E67A9E7.2020802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E67A9E7.2020802@goop.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Brown, Len" <len.brown@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "hpa@zytor.com" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "x86@kernel.org" <x86@kernel.org>, Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "keir@xen.org" <keir@xen.org>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

> From: Jeremy Fitzhardinge [mailto:jeremy@goop.org]
> Sent: Wednesday, September 07, 2011 10:29 AM
> 
> On 09/06/2011 10:50 PM, Cihula, Joseph wrote:
> >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> >> Sent: Wednesday, August 31, 2011 11:31 AM
> >>
> >> From: Yu Ke <ke.yu@intel.com>
> >>
> >> This patches implements the xen_platform_op hypercall, to pass the parsed ACPI info to
> hypervisor.
> >>
> >> Signed-off-by: Yu Ke <ke.yu@intel.com>
> >> Signed-off-by: Tian Kevin <kevin.tian@intel.com>
> >> Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> >> [v1: Added DEFINE_GUEST.. in appropiate headers]
> >> [v2: Ripped out typedefs]
> >> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >> ---
> >>  arch/ia64/include/asm/xen/interface.h |    1 +
> >>  arch/x86/include/asm/xen/interface.h  |    1 +
> >>  include/xen/interface/platform.h      |  320 +++++++++++++++++++++++++++++++++
> >>  include/xen/interface/xen.h           |    1 +
> >>  4 files changed, 323 insertions(+), 0 deletions(-)  create mode
> >> 100644 include/xen/interface/platform.h
> >>
> >> diff --git a/arch/ia64/include/asm/xen/interface.h
> >> b/arch/ia64/include/asm/xen/interface.h
> >> index e951e74..1d2427d 100644
> >> --- a/arch/ia64/include/asm/xen/interface.h
> >> +++ b/arch/ia64/include/asm/xen/interface.h
> >> @@ -76,6 +76,7 @@ DEFINE_GUEST_HANDLE(char);
> >> DEFINE_GUEST_HANDLE(int); DEFINE_GUEST_HANDLE(long);
> >> DEFINE_GUEST_HANDLE(void);
> >> +DEFINE_GUEST_HANDLE(uint64_t);
> >>
> >>  typedef unsigned long xen_pfn_t;
> >>  DEFINE_GUEST_HANDLE(xen_pfn_t);
> >> diff --git a/arch/x86/include/asm/xen/interface.h
> >> b/arch/x86/include/asm/xen/interface.h
> >> index 5d4922a..a1f2db5 100644
> >> --- a/arch/x86/include/asm/xen/interface.h
> >> +++ b/arch/x86/include/asm/xen/interface.h
> >> @@ -55,6 +55,7 @@ DEFINE_GUEST_HANDLE(char);
> >> DEFINE_GUEST_HANDLE(int); DEFINE_GUEST_HANDLE(long);
> >> DEFINE_GUEST_HANDLE(void);
> >> +DEFINE_GUEST_HANDLE(uint64_t);
> >>  #endif
> >>
> >>  #ifndef HYPERVISOR_VIRT_START
> >> diff --git a/include/xen/interface/platform.h
> >> b/include/xen/interface/platform.h
> >> new file mode 100644
> >> index 0000000..c168468
> >> --- /dev/null
> >> +++ b/include/xen/interface/platform.h
> > Why are you adding so many new hypercalls that aren't being used in this patchset?
> 
> May as well bring in all the platform-related hypercall definitions at once rather than be
> piecemeal.
> 
> >> @@ -0,0 +1,320 @@
> >> +/*******************************************************************
> >> +***
> >> +********
> >> + * platform.h
> >> + *
> >> + * Hardware platform operations. Intended for use by domain-0 kernel.
> >> + *
> >> + * Permission is hereby granted, free of charge, to any person
> >> +obtaining a copy
> >> + * of this software and associated documentation files (the
> >> +"Software"), to
> >> + * deal in the Software without restriction, including without
> >> +limitation the
> >> + * rights to use, copy, modify, merge, publish, distribute,
> >> +sublicense, and/or
> >> + * sell copies of the Software, and to permit persons to whom the
> >> +Software is
> >> + * furnished to do so, subject to the following conditions:
> >> + *
> >> + * The above copyright notice and this permission notice shall be
> >> +included in
> >> + * all copies or substantial portions of the Software.
> >> + *
> >> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >> +EXPRESS OR
> >> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >> +MERCHANTABILITY,
> >> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> >> +SHALL THE
> >> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> >> +OTHER
> >> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> >> +ARISING
> >> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >> +OTHER
> >> + * DEALINGS IN THE SOFTWARE.
> >> + *
> >> + * Copyright (c) 2002-2006, K Fraser  */
> >> +
> >> +#ifndef __XEN_PUBLIC_PLATFORM_H__
> >> +#define __XEN_PUBLIC_PLATFORM_H__
> >> +
> >> +#include "xen.h"
> >> +
> >> +#define XENPF_INTERFACE_VERSION 0x03000001
> >> +
> >> +/*
> >> + * Set clock such that it would read <secs,nsecs> after 00:00:00
> >> +UTC,
> >> + * 1 January, 1970 if the current system time was <system_time>.
> >> + */
> >> +#define XENPF_settime             17
> >> +struct xenpf_settime {
> >> +	/* IN variables. */
> >> +	uint32_t secs;
> >> +	uint32_t nsecs;
> >> +	uint64_t system_time;
> >> +};
> >> +DEFINE_GUEST_HANDLE_STRUCT(xenpf_settime_t);
> >> +
> >> +/*
> >> + * Request memory range (@mfn, @mfn+@nr_mfns-1) to have type @type.
> >> + * On x86, @type is an architecture-defined MTRR memory type.
> >> + * On success, returns the MTRR that was used (@reg) and a handle
> >> +that can
> >> + * be passed to XENPF_DEL_MEMTYPE to accurately tear down the new setting.
> >> + * (x86-specific).
> >> + */
> >> +#define XENPF_add_memtype         31
> >> +struct xenpf_add_memtype {
> >> +	/* IN variables. */
> >> +	unsigned long mfn;
> >> +	uint64_t nr_mfns;
> >> +	uint32_t type;
> >> +	/* OUT variables. */
> >> +	uint32_t handle;
> >> +	uint32_t reg;
> >> +};
> >> +DEFINE_GUEST_HANDLE_STRUCT(xenpf_add_memtype_t);
> >> +
> >> +/*
> >> + * Tear down an existing memory-range type. If @handle is remembered
> >> +then it
> >> + * should be passed in to accurately tear down the correct setting
> >> +(in case
> >> + * of overlapping memory regions with differing types). If it is not
> >> +known
> >> + * then @handle should be set to zero. In all cases @reg must be set.
> >> + * (x86-specific).
> >> + */
> >> +#define XENPF_del_memtype         32
> >> +struct xenpf_del_memtype {
> >> +	/* IN variables. */
> >> +	uint32_t handle;
> >> +	uint32_t reg;
> >> +};
> >> +DEFINE_GUEST_HANDLE_STRUCT(xenpf_del_memtype_t);
> >> +
> >> +/* Read current type of an MTRR (x86-specific). */
> >> +#define XENPF_read_memtype        33
> >> +struct xenpf_read_memtype {
> >> +	/* IN variables. */
> >> +	uint32_t reg;
> >> +	/* OUT variables. */
> >> +	unsigned long mfn;
> >> +	uint64_t nr_mfns;
> >> +	uint32_t type;
> >> +};
> >> +DEFINE_GUEST_HANDLE_STRUCT(xenpf_read_memtype_t);
> >> +
> >> +#define XENPF_microcode_update    35
> >> +struct xenpf_microcode_update {
> >> +	/* IN variables. */
> >> +	GUEST_HANDLE(void) data;          /* Pointer to microcode data */
> >> +	uint32_t length;                  /* Length of microcode data. */
> >> +};
> >> +DEFINE_GUEST_HANDLE_STRUCT(xenpf_microcode_update_t);
> >> +
> >> +#define XENPF_platform_quirk      39
> >> +#define QUIRK_NOIRQBALANCING      1 /* Do not restrict IO-APIC RTE targets */
> >> +#define QUIRK_IOAPIC_BAD_REGSEL   2 /* IO-APIC REGSEL forgets its value    */
> >> +#define QUIRK_IOAPIC_GOOD_REGSEL  3 /* IO-APIC REGSEL behaves properly     */
> >> +struct xenpf_platform_quirk {
> >> +	/* IN variables. */
> >> +	uint32_t quirk_id;
> >> +};
> >> +DEFINE_GUEST_HANDLE_STRUCT(xenpf_platform_quirk_t);
> >> +
> >> +#define XENPF_firmware_info       50
> >> +#define XEN_FW_DISK_INFO          1 /* from int 13 AH=08/41/48 */
> >> +#define XEN_FW_DISK_MBR_SIGNATURE 2 /* from MBR offset 0x1b8 */
> >> +#define XEN_FW_VBEDDC_INFO        3 /* from int 10 AX=4f15 */
> >> +struct xenpf_firmware_info {
> >> +	/* IN variables. */
> >> +	uint32_t type;
> >> +	uint32_t index;
> >> +	/* OUT variables. */
> >> +	union {
> >> +		struct {
> >> +			/* Int13, Fn48: Check Extensions Present. */
> >> +			uint8_t device;                   /* %dl: bios device number */
> >> +			uint8_t version;                  /* %ah: major version      */
> >> +			uint16_t interface_support;       /* %cx: support bitmap     */
> >> +			/* Int13, Fn08: Legacy Get Device Parameters. */
> >> +			uint16_t legacy_max_cylinder;     /* %cl[7:6]:%ch: max cyl # */
> >> +			uint8_t legacy_max_head;          /* %dh: max head #         */
> >> +			uint8_t legacy_sectors_per_track; /* %cl[5:0]: max sector #  */
> >> +			/* Int13, Fn41: Get Device Parameters (as filled into %ds:%esi). */
> >> +			/* NB. First uint16_t of buffer must be set to buffer size.      */
> >> +			GUEST_HANDLE(void) edd_params;
> >> +		} disk_info; /* XEN_FW_DISK_INFO */
> >> +		struct {
> >> +			uint8_t device;                   /* bios device number  */
> >> +			uint32_t mbr_signature;           /* offset 0x1b8 in mbr */
> >> +		} disk_mbr_signature; /* XEN_FW_DISK_MBR_SIGNATURE */
> >> +		struct {
> >> +			/* Int10, AX=4F15: Get EDID info. */
> >> +			uint8_t capabilities;
> >> +			uint8_t edid_transfer_time;
> >> +			/* must refer to 128-byte buffer */
> >> +			GUEST_HANDLE(uchar) edid;
> >> +		} vbeddc_info; /* XEN_FW_VBEDDC_INFO */
> >> +	} u;
> >> +};
> >> +DEFINE_GUEST_HANDLE_STRUCT(xenpf_firmware_info_t);
> >> +
> >> +#define XENPF_enter_acpi_sleep    51
> >> +struct xenpf_enter_acpi_sleep {
> >> +	/* IN variables */
> >> +	uint16_t pm1a_cnt_val;      /* PM1a control value. */
> >> +	uint16_t pm1b_cnt_val;      /* PM1b control value. */
> > These are uint32_t in native Linux--why truncate in the API and not at use?
> 
> Does ACPI define them as 32 or 16 bit?

The spec indicates that the length is variable and could be up to 32 bits (AFAICT).  And Linux uses 32b, which your other patch is truncating for this call.

Joe
