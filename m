From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] PM: fix oops in suspend/hibernate code
Date: Thu, 06 Jan 2011 17:31:06 +0100
Message-ID: <4D25EE4A.9010602__22256.1551760466$1294331734$gmane$org@gmail.com>
References: <201101060028.43342.rjw@sisk.pl>
	<1294305504-5787-1-git-send-email-jslaby@suse.cz>
	<201101061657.39723.rjw@sisk.pl> <4D25E943.804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D25E943.804@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, akpm@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 01/06/2011 05:09 PM, Jiri Slaby wrote:
>>> --- a/kernel/power/nvs.c
>>> +++ b/kernel/power/nvs.c
>>> @@ -105,7 +105,7 @@ int suspend_nvs_alloc(void)
>>>  /**
>>>   *	suspend_nvs_save - save NVS memory regions
>>>   */
>>> -void suspend_nvs_save(void)
>>> +int suspend_nvs_save(void)
>>>  {
>>>  	struct nvs_page *entry;
>>>  
>>> @@ -114,8 +114,14 @@ void suspend_nvs_save(void)
>>>  	list_for_each_entry(entry, &nvs_list, node)
>>>  		if (entry->data) {
>>>  			entry->kaddr = ioremap(entry->phys_start, entry->size);
>>
>> I wonder what happens if you simply change the ioremap() here to
>> ioremap_nocache() without any other modifications?
> 
> ioremap *is* ioremap_nocache on x86. And that's the conflict it
> complains about I guess? Don't you mean ioremap_cache?

Using ioremap_cache indeed fixes the problem...

thanks,
-- 
js
