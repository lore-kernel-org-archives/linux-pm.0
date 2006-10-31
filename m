From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc4: known unfixed regressions
Date: Tue, 31 Oct 2006 21:12:17 +0100
Message-ID: <1162325537.3044.49.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	 <20061031195654.GV27968@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423843AbWJaUMp@vger.kernel.org>
In-Reply-To: <20061031195654.GV27968@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr, oprofile-list@lists.sf.net, ak@suse.de, discuss@x86-64.org, Martin Lorenz <martin@lorenz.eu.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org, Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>, Jens Axboe <jens.axboe@oracle.com>, Christian <christiand59@web.de>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, Komuro <komurojun-mbn@nifty.com>, Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <randy.dunlap@o>
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-10-31 at 20:56 +0100, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : PCI: MMCONFIG breakage
> References : http://lkml.org/lkml/2006/10/27/251
> Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> Status     : unknown, both BIOS and Direct work
> 


hmm I see nothing MMCONFIG related here much....
