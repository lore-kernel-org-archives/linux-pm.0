From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/8] ACPI / PCI: Introduce
	acpi_pci_osc_control_query()
Date: Wed, 04 Aug 2010 13:28:29 +0900
Message-ID: <4C58EC6D.4050902__3023.29669143564$1280896369$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <4C57A346.6020003@jp.fujitsu.com>
	<201008031127.12117.rjw@sisk.pl> <201008032258.40838.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008032258.40838.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(2010/08/04 5:58), Rafael J. Wysocki wrote:
> On Tuesday, August 03, 2010, Rafael J. Wysocki wrote:
>> On Tuesday, August 03, 2010, Kenji Kaneshige wrote:
>>> (2010/08/03 6:53), Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki<rjw@sisk.pl>
>>>
>>> <snip.>
>>>
>>>> +	mutex_lock(&osc_lock);
>>>> +	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
>>>> +	mutex_unlock(&osc_lock);
>>>> +
>>>
>>> One more comment here.
>>>
>>> I think we can skip acpi_pci_query_osc() if all of queried controls are
>>> already granted to OS. Please see below
>>>
>>> 	mutex_lock(&osc_lock);
>>> 	if ((root->osc_control_set&  *ctrl_mask) == *ctrl_mask) {
>>> 		*ctrl_mask = root->osc_control_set;
>>> 		goto out;
>>> 	}
>>> 	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
>>> 	mutex_unlock(&osc_lock);
>>> out:
>>
>> Well I guess you mean:
>>
>>   	mutex_lock(&osc_lock);
>>   	if ((root->osc_control_set&  *ctrl_mask) != *ctrl_mask)
>>   		status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
>>   	mutex_unlock(&osc_lock);
>>
>> Otherwise we would return with the mutex held. :-)
>

Oops... sorry...

> Updated patch is appended, please tell me what you think.

Looks good to me. The below (in your updated patch) was what I wanted to mean

> +	mutex_lock(&osc_lock);
> +	if ((*mask & root->osc_control_set) == *mask)
> +		*mask = root->osc_control_set;
> +	else
> +		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
> +	mutex_unlock(&osc_lock);

Thanks,
Kenji Kaneshige
