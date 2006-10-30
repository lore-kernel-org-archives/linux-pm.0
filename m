From: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 19:06:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0610301900350.5198@blonde.wat.veritas.com>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il>
 <45462591.7020200@ce.jp.nec.com> <Pine.LNX.4.64.0610300834060.25218@g5.osdl.org>
 <454637BE.6090309@ce.jp.nec.com> <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
 <20061030183522.GL27968@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161416AbWJ3TI2@vger.kernel.org>
In-Reply-To: <20061030183522.GL27968@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Oct 2006, Adrian Bunk wrote:
> 
> Martin's original bug report stated "now I loose ACPI events after 
> suspend/resume. not every time, but roughly 3 out of 4 times."
> This seems to support your theory.
> 
> But considering that two people have independently reported this as a 
> 2.6.19-rc regression for similar hardware (Michael for a T60 and Martin 
> for an X60), a problem in the kernel seems to be involved.

Add me to the list, on a T43p.  I believe it was happening in -rc1,
but seems worse with -rc3 and current.  But it's one of those things
which doesn't happen if you just go to test it out, only when you
need to suspend and resume for real.

Hugh 
