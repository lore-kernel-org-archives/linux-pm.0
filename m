From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 12:34:54 -0500
Message-ID: <454637BE.6090309@ce.jp.nec.com>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <45462591.7020200@ce.jp.nec.com> <Pine.LNX.4.64.0610300834060.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610300834060.25218@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> Actually, looking closer at the code, the patch seems to add _incorrect_ 
> error handling.
> 
> For example, look at bd_claim_by_kobject(): if the "bd_claim()" inside of 
> it succeeds, we used to always return success. Now, we don't necessarily 
> do that: we may have done a _successful_ "bd_claim()" call, but then we 
> return an error because something else failed, and now we're returning 
> with from bd_claim_by_kobject() with the bd_claim() done, but with an 
> error return (so the caller will _not_ call "bd_release()", and the 
> block_device will forever stay exclusive).
> 
> No?

You're right.

> Now, exactly why acpi stops working as a result, I don't know, but maybe 
> something else tries to get exclusive access to a swap partition, for 
> example, and now fails, causing some acpi sequence to not be set up? 
> Dunno.
> 
> So I suspect it should be reverted, but maybe somebody can see exactly 
> what goes wrong here.

Please revert the patch. I'll fix the wrong error handling.

I'm not sure reverting the patch solves the ACPI problem
because Michael's kernel seems not having any user of
bd_claim_by_kobject.

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation of America
