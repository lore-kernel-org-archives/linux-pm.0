From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v12.6 0/11] bq27xxx_battery partial series
Date: Mon, 10 Apr 2017 09:46:47 -0500
Message-ID: <21b8db86-358f-f3ed-0e4c-e98fb8bed164@ti.com>
References: <20170410050712.930-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:9435 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbdDJOqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 10:46:50 -0400
In-Reply-To: <20170410050712.930-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org

On 04/10/2017 12:07 AM, Liam Breck wrote:
> Latest changes:
> 
> New patch to disable updates to flash/NVM. The purpose of this series has always
> been to update NVM or RAM via DT. It was Sebastian's idea to site the properties
> in a fixed/simple-battery node representing the battery to the fuel gauge (i.e.
> your characterization that I "misused" the battery node is mistaken). I relent
> only because I've switched from a NVM to RAM gauge. I expect others will succeed
> in reverting this. Also, I have no need for a knob which lets userspace trigger
> NVM update, so I leave that to others.
> 
> Add module param use_monitored_battery to the power_supply_battery_info patch;
> it is dropped in the above patch. Allowing users to ignore the DT properties
> is the correct solution IMO.
> 
> Add Copyright notice
> 
> unseal() returns error on key==0
> 
> Skip reset on non-cfgupdate chips if not updated
> 
> Emit warning if no dm_regs table
> 
> Map orig ID to chip ID via bq27xxx_chips[]
> 
> Drop "prototypes" in enum comments
> 
> Rename dupes detector bq27xxx_battery_dbg_regs_dupes()
> 
> ^.^ ^.^ - We can has test?
> 

Can you post the whole series against v4.11-rc6?
