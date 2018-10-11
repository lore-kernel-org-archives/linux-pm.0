From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [workqueue/driver-core PATCH v2 4/5] driver core: Attach devices
 on CPU local to device node
Date: Thu, 11 Oct 2018 08:50:29 -0700
Message-ID: <e2c37263-ccbd-f3e1-243d-f5c6867fa251@linux.intel.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230836.10609.73485.stgit@localhost.localdomain>
 <20181011104501.GA30183@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011104501.GA30183@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org



On 10/11/2018 3:45 AM, Greg KH wrote:
> On Wed, Oct 10, 2018 at 04:08:40PM -0700, Alexander Duyck wrote:
>> This change makes it so that we call the asynchronous probe routines on a
>> CPU local to the device node. By doing this we should be able to improve
>> our initialization time significantly as we can avoid having to access the
>> device from a remote node which may introduce higher latency.
> 
> This is nice in theory, but what kind of real numbers does this show?
> There's a lot of added complexity here, and what is the benifit?
> 
> Benchmarks or bootcharts that we can see would be great to have, thanks.
> 
> greg k-h
> 

In the case of persistent memory init the cost for getting the wrong 
node is pretty significant. On my test system with 3TB per node just 
getting the initialization node matched up to the memory node dropped 
initialization time per node from 39 seconds down to about 26 seconds 
per node.

We are already starting to see code like this pop up in subsystems 
anyway. For example the PCI code already has logic similar to what I am 
adding here floating around in it[1]. I'm hoping that by placing this 
change in the core device code we could start consolidating it so we 
don't have all the individual drivers or subsystems implementing their 
own NUMA specific init logic.

This is likely going to become more of an issue in the future as we now 
have CPUs like the AMD Ryzen Threadripper out there that have people 
starting to discuss NUMA in the consumer space.

- Alex

[1] 
https://elixir.bootlin.com/linux/v4.19-rc7/source/drivers/pci/pci-driver.c#L331
