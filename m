From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
Date: Fri, 19 Oct 2018 14:45:54 +0300
Message-ID: <a7d488d6-0700-0666-8b59-d416f6b43df0@linux.intel.com>
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
 <20181018212513.GM5906@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181018212513.GM5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/19/2018 12:25 AM, Bjorn Helgaas wrote:
> On Thu, Oct 18, 2018 at 03:30:38PM +0300, Jarkko Nikula wrote:
>> Allow PCI core to do runtime PM to devices without needing to use dummy
>> runtime PM callback functions if there is no need to do anything device
>> specific beyond PCI device power state management.
>>
>> Implement this by letting core to change device power state during
>> runtime PM transitions even if no callback functions are defined.
>>
>> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: <stable@vger.kernel.org>
> 
> I applied this with Rafael's reviewed-by to pci/misc for v4.20,
> thanks!
> 
> But I dropped the stable tag because if I understand correctly, the
> point of this is to avoid the need for SIMPLE_DEV_PM_OPS() in drivers
> that don't need to do anything for PM.
> 
> That's worthwhile, but it's not transparently obvious that it would
> qualify for a stable backport based on this:
> 
>    https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst
> 
> If there's an argument for adding a stable tag, I'll add it , but that
> justification should be explicit in the changelog.
> 
No disagreement here. I was thinking a second or two before sending the 
patch may I Cc or not the stable. I went adding it since this actually 
fixes a PM regression on i2c-i801 after v4.18. SMBus PCI device doesn't 
go to D3 and
/sys/bus/pci/devices/[0000:00:1f.3 etc]/power/runtime_status
shows "error" when runtime PM framework attempts to autosuspend the device.

But given that most of the platforms I have seen don't implement the PM 
capabilities for SMBus PCI device, a few do implement though, and we 
haven't got any regression reports either so this is not very fatal IMHO.

I definitely don't want to see massive regression from different PCI 
systems either. Queueing for v4.20 sounds reasonable and we can ask to 
cherry-pick the commit into v4.18 and v4.19 stable kernels if nothing 
fatal shows up.

-- 
Jarkko
