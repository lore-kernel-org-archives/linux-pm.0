From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [PATCH V2 0/3] PNP: Allow PNP resources to be disabled (interface)
Date: Sun, 03 Jun 2012 19:47:06 +0200
Message-ID: <4FCBA31A.2060901@gmx.net>
References: <4F85ED86.8010002@gmx.net> <CAErSpo7ynK9wWBRTfXSSSp3JtThs7_eTttKVfsHMJbKh7JSK1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo7ynK9wWBRTfXSSSp3JtThs7_eTttKVfsHMJbKh7JSK1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, len.brown@intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-thinkpad@linux-thinkpad.org
List-Id: linux-pm@vger.kernel.org

On 23/04/12 18:42, Bjorn Helgaas wrote:

> On Wed, Apr 11, 2012 at 2:45 PM, Witold Szczeponik
> <Witold.Szczeponik@gmx.net>  wrote:
>> Hello everybody,
>>
>> this simple patch series continues the work begun in commit
>> 18fd470a48396c8795ba7256c5973e92ffa25cb3 where ACPI PNP resource templates
>> with empty/disabled resources are handled.
> 
> For all three patches:
> 
> Reviewed-by: Bjorn Helgaas<bhelgaas@google.com>
> 

Hi Len, 

I noticed that none of the patches made it into 3.5-rc1.  These patches are important to support some (vintage) IBM ThinkPads, hence my interest in getting them included in the kernel.  But they are also of general value and should not introduce any regressions. 

If there is anything I still need to do, like providing better documentation, etc., just let me know. 

NB: I am sending this mail to both the ...@intel.com and ...@kernel.org addresses, for I received mails from you from either account.  I apologize for any inconvenience caused by this. 


Thanks.  --- Witold
