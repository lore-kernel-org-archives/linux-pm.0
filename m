From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 11:17:21 -0500
Message-ID: <45462591.7020200@ce.jp.nec.com>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030560AbWJ3QTg@vger.kernel.org>
In-Reply-To: <20061030135625.GB1601@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, Martin Lorenz <martin@lorenz.eu.org>
Cc: Pavel Machek <pavel@suse.cz>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: linux-pm@vger.kernel.org

Hi Michael,

 > 2.6.19-rc3 without reverting
 > d7dd8fd9557840162b724a8ac1366dd78a12dff stops receiving ACPI events after some
 > use (sometimes after suspend/resume, sometimes after kernel build stress).  Now,
 > what does this tell us? Andrew, any idea?

The code is related to bd_claim_by_disk which is called when
device-mapper or md tries to mark the underlying devices
for exclusive use and creates symlinks from/to the devices
in sysfs. The patch added error handlings which weren't in
the original code.

I have no idea how it affects ACPI event handling.
Are you using dm and/or md on your machine?
Have you seen any unusual kernel messages or symptoms regarding
dm/md before the ACPI problem occurs?

Michael S. Tsirkin wrote:
> Quoting r. Adrian Bunk <bunk@stusta.de>:
>> Subject    : T60 stops triggering any ACPI events
>> References : http://lkml.org/lkml/2006/10/4/425
>>              http://lkml.org/lkml/2006/10/16/262
>>              http://bugzilla.kernel.org/show_bug.cgi?id=7408
>> Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
>> Status     : unknown
> 
> OK, I spent half a night with git-bisect, and the patch that triggers this issue
> seems to be this:
> 
> commit d7dd8fd9557840162b724a8ac1366dd78a12dff
> Author: Andrew Morton <akpm@osdl.org> 
>     [PATCH] blockdev.c: check driver layer errors
> 
> Reset to d7dd8fd9557840162b724a8ac1366dd78a12dff seems to hide part of the issue
> (I have ACPI after kernel build, but not after suspend/resume).  Both reverting
> this patch, and reset to the parent of this patch seem to solve (or at least,
> hide) both problems for me (no ACPI after suspend/resume and no ACPI after
> kernel build).
> 
> I am currently running on 2.6.19-rc3 minus
> d7dd8fd9557840162b724a8ac1366dd78a12dff, and in a full day of use I have not
> observed any issues yet. 2.6.19-rc3 without reverting
> d7dd8fd9557840162b724a8ac1366dd78a12dff stops receiving ACPI events after some
> use (sometimes after suspend/resume, sometimes after kernel build stress).  Now,
> what does this tell us? Andrew, any idea?
> 
> 
> Martin, could you test whether reverting this helps you, too, by chance?
> Here's a patch to apply for testing this.
> 
> ---
> 
> commit 658488b7577b7b2242372c43f081f55e2d274615
> Author: Michael S. Tsirkin <mst@mellanox.co.il>
> Date:   Mon Oct 30 01:28:40 2006 +0200
> 
>     Revert "[PATCH] blockdev.c: check driver layer errors"
>     
>     This reverts commit 4d7dd8fd9557840162b724a8ac1366dd78a12dff.

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation of America
