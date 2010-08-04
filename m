From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
 bits returned by a query (v2)
Date: Wed, 04 Aug 2010 17:41:47 +0900
Message-ID: <4C5927CB.4070705__14914.4681905911$1280911516$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <4C57C182.7060407@jp.fujitsu.com>
	<201008031133.37471.rjw@sisk.pl> <201008032302.33778.rjw@sisk.pl>
	<4C58FE9A.1040607@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C58FE9A.1040607@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(2010/08/04 14:46), Kenji Kaneshige wrote:
> (2010/08/04 6:02), Rafael J. Wysocki wrote:
>> On Tuesday, August 03, 2010, Rafael J. Wysocki wrote:
>>> On Tuesday, August 03, 2010, Hidetoshi Seto wrote:
>>>> (2010/08/03 13:52), Kenji Kaneshige wrote:
>>>>> (2010/08/03 6:59), Rafael J. Wysocki wrote:
>>>>>> @@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
>>>>>>        if ((root->osc_control_set&   control_req) == control_req)
>>>>>>            goto out;
>>>>>>
>>>>>> -    /* Need to query controls first before requesting them */
>>>>>> -    if (!root->osc_queried) {
>>>>>> -        status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
>>>>>> -        if (ACPI_FAILURE(status))
>>>>>> -            goto out;
>>>>>> -    }
>>>>>> -    if ((root->osc_control_qry&   control_req) != control_req) {
>>>>>> -        printk(KERN_DEBUG
>>>>>> -               "Firmware did not grant requested _OSC control\n");
>>>>>> -        status = AE_SUPPORT;
>>>>>> -        goto out;
>>>>>> -    }
>>>>>
>>>>> I think acpi_pci_osc_control_set() still need to query before commit
>>>>> to ensure all the requested controls are granted to OS.
>>>>>
>>>>> So the code needs to be
>>>>>
>>>>>      status = acpi_pci_query_osc(root, root->osc_support_set,&control_req);
>>>>>      if (ACPI_FAILURE(status))
>>>>>          goto out;
>>>>
> 
> Sorry, that should have been
> 
>     query = control_req;
>     status = acpi_pci_query_osc(root, root->osc_support_set, &query);
>     if (ACPI_FAILURE(status))
>         goto out;
>     if ((query & control_req) != control_req) {
>         printk_(KERN_DEBUG
>             "Firmware did not grant requested _OSC control\n");
>         status = AE_SUPPORT;
>         goto out;
>     }
> 
> I know current pcie_port_acpi_setup() queries the requesting controls
> before acpi_pci_osc_control_set() and only one control is requested
> in the other code. However, I think acpi_pci_osc_control_set() still
> need to query the requested controls to ensure all the requested
> controls, in case someone calls this function without querying the
> requesting controls. In other words, I think it must be ensured that
> any controls are never granted to OS when acpi_pci_osc_control_set()
> returns error.

I think the following patch is what you mean.

And... (Continue to next post)

Thanks,
H.Seto

=====

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / PCI: Do not preserve _OSC control bits returned by a query (v3)

All of the remaining callers of acpi_pci_osc_control_set() either
use acpi_pci_root_osc_query() right before it, like
pcie_port_acpi_setup(), or ask for control of one feature only,
like acpi_get_hp_hw_control_from_firmware().  Thus there is no
reason to preserve the _OSC control bits returned by an _OSC query
and the osc_control_qry and osc_queried fields of struct
acpi_pci_root are not necessary any more.  Remove them and modify the
code that uses them accordingly.

[v3: HS: keep query in acpi_pci_osc_control_set]

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   13 +++++--------
 include/acpi/acpi_bus.h |    3 ---
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d3110d6..ec03c19 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -248,10 +248,8 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
 	if (ACPI_SUCCESS(status)) {
 		root->osc_support_set = support;
-		root->osc_control_qry = result;
 		if (control)
 			*control = result;
-		root->osc_queried = 1;
 	}
 	return status;
 }
@@ -438,12 +436,11 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
 		goto out;
 
 	/* Need to query controls first before requesting them */
-	if (!root->osc_queried) {
-		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
-		if (ACPI_FAILURE(status))
-			goto out;
-	}
-	if ((root->osc_control_qry & control_req) != control_req) {
+	result = control_req;
+	status = acpi_pci_query_osc(root, root->osc_support_set, &result);
+	if (ACPI_FAILURE(status))
+		goto out;
+	if ((result & control_req) != control_req) {
 		printk(KERN_DEBUG
 		       "Firmware did not grant requested _OSC control\n");
 		status = AE_SUPPORT;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index baacd98..4de84ce 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -377,9 +377,6 @@ struct acpi_pci_root {
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
-	u32 osc_control_qry;	/* the latest _OSC query result */
-
-	u32 osc_queried:1;	/* has _OSC control been queried? */
 };
 
 /* helper */
-- 
1.7.2
