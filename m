From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] PCI / PM: Allow runtime PM without callback functions
Date: Wed, 12 Dec 2018 13:42:29 +0200
Message-ID: <14190b11-f7f1-3a27-1476-8b043bd72555@linux.intel.com>
References: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
 <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi

On 10/25/18 4:57 PM, Rafael J. Wysocki wrote:
> On Tue, Oct 23, 2018 at 1:46 PM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>>
>> Commit a9c8088c7988 ("i2c: i801: Don't restore config registers on
>> runtime PM") nullified the runtime PM suspend/resume callback pointers
>> while keeping the runtime PM enabled.
>>
>> This causes that SMBus PCI device stays in D0 power state and sysfs
>> /sys/bus/pci/devices/[SMBus PCI ID]/power/runtime_status shows "error"
>> when the runtime PM framework attempts to autosuspend the device. This
>> is due PCI bus runtime PM which checks for driver runtime PM callbacks
>> and returns with -ENOSYS if they are not set.
>>
>> Since i2c-i801.c don't need to do anything device specific beyond PCI
>> device power state management Jean Delvare proposed if this can be fixed
>> in the PCI subsystem core level rather than adding dummy runtime PM
>> callback functions in the PCI drivers.
>>
>> Change the pci_pm_runtime_suspend()/pci_pm_runtime_resume() semantics so
>> that they allow change the PCI device power state during runtime PM
>> transitions even if no runtime PM callback functions are defined.
>>
>> This change fixes the runtime PM regression on i2c-i801.c.
>>
>> It is not obvious why the code had hard requirements for the runtime PM
>> callbacks. Test has been here since the code was introduced by the
>> commit 6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
>>
>> On the other hand similar change than this was done to generic runtime
>> PM callbacks way back in the commit 05aa55dddb9e ("PM / Runtime: Lenient
>> generic runtime pm callbacks").
>>
>> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # 4.18+
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
I guess this patch with Reviewed-by tags from Rafael and Jean got buried 
under other list traffic as I don't find this from pci.git or linux-next?

-- 
Jarkko
