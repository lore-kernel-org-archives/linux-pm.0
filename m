From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC v2 0/3] ahci_platform: unbind/rmmod power down sequence
Date: Sun, 28 Oct 2012 02:11:59 +0200
Message-ID: <1569755.7jSillTKZU@vostro.rjw.lan>
References: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Please don't CC the linux-pm@lists.linux-foundation.org list, which is dead.

Please use linux-pm@vger.kernel.org for future submissions, as documented in
multiple places.

Thanks,
Rafael


On Saturday, October 27, 2012 01:09:33 PM Brian Norris wrote:
> Hello,
> 
> This is a follow up on a previous questions and RFC series I sent. See here for
> some context:
> 
>     http://article.gmane.org/gmane.linux.ide/53143
>     http://article.gmane.org/gmane.linux.ide/52951
> 
> This series:
> 
> (1) Allows ahci_platform to unbind a device from the driver. This is useful for
>     allowing total power-off of the device, for instance.
> (2) Adds ahci_platform ata_port_operations.host_stop() hook, so that
>     platform-device exit() can power down the device at the appropriate point
>     in the removal sequence.
> 
> Thanks to Tejun for the comments, which suggested that ahci_platform (not
> libata-core) was broken.
> 
> Brian
> 
> Brian Norris (3):
>   ahci_platform: enable hotplug unbinding
>   ahci_platform: convert to module_platform_driver
>   ahci_platform: perform platform exit in host_stop() hook
> 
>  drivers/ata/ahci_platform.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
