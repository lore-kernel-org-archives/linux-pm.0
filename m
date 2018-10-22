From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
Date: Mon, 22 Oct 2018 09:04:08 +0300
Message-ID: <895fc530-c345-a419-b234-646423e98d83@linux.intel.com>
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
 <20181019152105.0325a663@endymion>
 <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Jean Delvare <jdelvare@suse.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/20/2018 07:19 PM, Bjorn Helgaas wrote:
> On Fri, Oct 19, 2018 at 03:21:05PM +0200, Jean Delvare wrote:
>> Later in this function, pm is dereferenced again. It happens twice in
>> the "if (error)" condition where it is currently safe (error can't be
>> non-zero if pm->runtime_suspend() has not been called, and obviously
>> pm->runtime_suspend() can't have been called if pm was NULL). However
>> it also happens later without the condition:
>>
>> 	if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
>> 	    && pci_dev->current_state != PCI_UNKNOWN) {
>> 		WARN_ONCE(pci_dev->current_state != prev,
>> 			"PCI PM: State of device not saved by %pF\n",
>> 			pm->runtime_suspend);
>> 		return 0;
>> 	}
>>
>> I am no expert of the PM framework but is there no risk to dereference
>> NULL at this point? Or even if pm is non-NULL, pm->runtime_suspend may
>> be NULL, leading to a confusing warning message?
>>
Thanks for spotting this! I don't have any excuse why I was so 
completely blind.

>> More generally, I would feel better if instead of initializing error to
>> 0, we would move under the "if (pm && pm->runtime_suspend)" condition
>> everything that must not be run if pm->runtime_suspend is not defined.
>> That would make the possible code flows a lot clearer.
> 
> I agree, this isn't good.  Even if it's safe (and I don't think that
> second spot is safe), it's too hard to analyze.  I'm going to drop
> this for now.
> 
Thanks. I'll cook a better version.

-- 
Jarkko
