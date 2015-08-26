From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Wed, 26 Aug 2015 13:43:09 +0100
Message-ID: <55DDB45D.2030901@arm.com>
References: <20150802134014.380415cd@arm.com> <1438626365-23709-1-git-send-email-lukasz.anaczkowski@intel.com> <1438626365-23709-2-git-send-email-lukasz.anaczkowski@intel.com> <C1C2579D7BE026428F81F41198ADB17237863E88@irsmsx110.ger.corp.intel.com> <55DD9838.20505@arm.com> <20150826114250.GA11863@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150826114250.GA11863@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26/08/15 12:42, Lorenzo Pieralisi wrote:
> Hi Lukasz,
> 
> On Wed, Aug 26, 2015 at 11:43:04AM +0100, Marc Zyngier wrote:
>> Hi Lukasz,
>>
>> On 26/08/15 08:04, Anaczkowski, Lukasz wrote:
>>> On Monday, August 3, 2015 8:26 PM
>>> Lukasz Anaczkowski <lukasz.anaczkowski@intel.com> wrote:
>>>
>>>> v2: Fixed ARM64 syntax error
>>>
>>> Hi Marc,
>>>
>>> Does this patch look ok now?
> 
> No it does not, it seems to break arm64, I put together a fix
> below. I do not think the way you handle the count increment
> in acpi_parse_entries() is correct anyway, since you increment
> it only if max_entries != 0, which changes mainline behaviour.

Yeah, this is fundamentally flawed:

- count is only incremented when max_entries != 0, as you noticed
- With max_entries != 0, count now represent the sum of all matches
  Is that expected?
- The proc iteration stops after the first match. Why?
- The test for max_entries is done inside the proc loop. Why?

I came up with the following patch that restores arm64 to a booting state.

If the intention was to change the meaning of the acpi_parse_entries
return value, then this should be documented and agreed upon.

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 1217e41..f06327f 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -249,19 +249,24 @@ acpi_parse_entries(char *id, unsigned long table_size,

 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       table_end) {
+		bool match = false;
+
+		if (max_entries && count >= max_entries)
+			break;
 		for (i = 0; i < proc_num; i++) {
 			if (entry->type != proc[i].id)
 				continue;
-			if (max_entries && count++ >= max_entries)
-				continue;
 			if (proc[i].handler(entry, table_end)) {
 				proc[i].count = -EINVAL;
 				return -EINVAL;
 			}
 			proc[i].count++;
-			break;
+			match = true;
 		}

+		if (match)
+			count++;
+
 		/*
 		 * If entry->length is 0, break from this loop to avoid
 		 * infinite loop.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
