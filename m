From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 18:32:23 +0200
Message-ID: <20061030163223.GK1941@mellanox.co.il>
References: <45462591.7020200@ce.jp.nec.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965136AbWJ3Qdj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45462591.7020200@ce.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: linux-pm@vger.kernel.org

Quoting r. Jun'ichi Nomura <j-nomura@ce.jp.nec.com>:
> Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
> 
> Hi Michael,
> 
>  > 2.6.19-rc3 without reverting
>  > d7dd8fd9557840162b724a8ac1366dd78a12dff stops receiving ACPI events after some
>  > use (sometimes after suspend/resume, sometimes after kernel build stress).  Now,
>  > what does this tell us? Andrew, any idea?
> 
> The code is related to bd_claim_by_disk which is called when
> device-mapper or md tries to mark the underlying devices
> for exclusive use and creates symlinks from/to the devices
> in sysfs. The patch added error handlings which weren't in
> the original code.
> 
> I have no idea how it affects ACPI event handling.

It's a mystery. Probably exposes a bug somewhere?

> Are you using dm and/or md on your machine?

The .config is attached to bugzilla.

> Have you seen any unusual kernel messages or symptoms regarding
> dm/md before the ACPI problem occurs?

I haven't.

-- 
MST
