From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [RFC 0/5] device wakeup event support
Date: Tue, 9 Sep 2008 11:54:04 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F3298__25102.9382729486$1220932670$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<200809081941.10546.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809081941.10546.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of David Brownell
>Sent: Tuesday, September 09, 2008 10:41 AM
>To: Li, Shaohua
>Cc: linux-pm@lists.linux-foundation.org; linux-acpi@vger.kernel.org;
>stern@rowland.harvard.edu
>Subject: Re: [RFC 0/5] device wakeup event support
>
>On Monday 08 September 2008, shaohua.li@intel.com wrote:
>> This series add device wakeup event detection support. This is the base
>to
>> implement runtime device suspend/resume, though we don't support it now.
>> But David said USB is approaching to this. See this bugzilla
>> http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.
>
>Glad to see more attention here.  :)
>
>Note that this issue is specific to systems using PCI (at core),
>with additional nuances for PCI systems which use ACPI.
>
>Device wakeup through USB works fine on various non-PCI and
>non-ACPI embedded systems, without needing these patches.
>It's done so for several years now...
>
>
>> The current process to handle wakeup event is:
>> 1. driver enable wakeup event line pme and suspend
>> 2. NPME or ACPI receives wake
>> There are somethings we need discuss:up event
>> 3. NPME or ACPI call .wakeup_event() to clear and disable wakeup
>>    event. Driver can do extra things in .wakeup_event() too.
>> 4. NPME or ACPI call generic wakeup event handler
>(device_receive_wakeup_event())
>> 5. device resumes, and goto 1 for next round of suspend
>>
>> 1. is this generic for other platforms?
>> 2. what should the generic wakeup event handler do?
>>
>> Comments and suggestions are welcome!
>
>My reaction re "generic" is that these mechanisms should
>be specific to the busses and platforms involved; see my
>comments on patch #1.
>
>However this means that for PCI devices, or PCIE, this can
>and should be generic enough to work on non-x86 systems.
>
>It's not quite that generic yet, and there are interactions
>between PCI/PCIE and ACPI that will need work.  But having
>those layers clean is important; and you've got a decent
>start on that.
>
>Plus there are various other wake-capable devices, like
>the PS2 devices and UART in /proc/acpi/wakeup on one of
>my systems:
>
>Device  S-state   Status   Sysfs node
>PCI0      S4     disabled  no-bus:pci0000:00
>PS2M      S4     disabled  pnp:00:05
>PS2K      S4     disabled  pnp:00:06
>UAR1      S4     disabled  pnp:00:08
>USB1      S3     disabled  pci:0000:00:03.0
>USB2      S3     disabled  pci:0000:00:03.1
>USB3      S3     disabled       <-- BIOS bug: no such hardware
>USB4      S3     disabled  pci:0000:00:03.3
>S139      S4     disabled       <-- BIOS bug: no such hardware
>LAN       S4     disabled  pci:0000:00:04.0
>MDM       S4     disabled       <-- MDM and AUD are the same HW??
>AUD       S4     disabled  pci:0000:00:02.7
>SLPB      S4    *enabled
>
>But getting a good start on the PCI and ACPI runtime wake
>framework will help a lot.
The ACPI mechanism works for all devices you mentioned here. It's not just for ACPI device.

Thanks,
Shaohua
