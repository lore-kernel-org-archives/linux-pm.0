From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 19:35:22 +0100
Message-ID: <20061030183522.GL27968@stusta.de>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <45462591.7020200@ce.jp.nec.com> <Pine.LNX.4.64.0610300834060.25218@g5.osdl.org> <454637BE.6090309@ce.jp.nec.com> <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 30, 2006 at 10:16:34AM -0800, Linus Torvalds wrote:
>...
> I assume that "compile the kernel" just triggers some magic ACPI event 
> (probably fan-related due to heat), and I wonder if the bisection faked 
> you out because once you get "close enough" the differences are small 
> enough that the kernel compile is quick and the heat event doesn't 
> actually trigger?
> 
> See what I'm saying? Maybe the act of bisecting itself changed the 
> results, and then when you just revert the patch, you end up in the same 
> situation: you only recompile a small part (you only recompile that 
> particular file), and the problem doesn't occur, so you'd think that the 
> revert "fixed" it.
> 
> If it's heat-related, it should probably trigger by anything that does a 
> lot of CPU (and perhaps disk) accesses, not just kernel builds. It might 
> be good to try to find another test-case for it than a kernel recompile, 
> one that doesn't depend on how much changed in the kernel..

Martin's original bug report stated "now I loose ACPI events after 
suspend/resume. not every time, but roughly 3 out of 4 times."
This seems to support your theory.

But considering that two people have independently reported this as a 
2.6.19-rc regression for similar hardware (Michael for a T60 and Martin 
for an X60), a problem in the kernel seems to be involved.

Martin, Michael, can you send complete "dmesg -s 1000000" for both 
2.6.18.1 and a non-working 2.6.19-rc kernel after resume?
I don't have high hopes, but perhaps looking at the dmesg and/or 
diff'ing them might give a hint.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

