From: Pavel Machek <pavel@ucw.cz>
Subject: Re: new kmemleak between 2.6.35.3 and 2.6.35.4
Date: Tue, 14 Sep 2010 08:53:34 +0200
Message-ID: <20100914065334.GB1422__9436.48226461864$1284447278$gmane$org@ucw.cz>
References: <201008301628.46130.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201008301628.46130.toralf.foerster@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Toralf F?rster <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon 2010-08-30 16:28:45, Toralf F?rster wrote:
> Hello,
> 
> with the new minor stable version this kmemleak entry seems to be new :

That should be Dave Jones / cpufreq, right?
								Pavel

>  unreferenced object 0xf61437e0 (size 32):
>   comm "modprobe", pid 1042, jiffies 4294676655 (age 15869.486s)
>   hex dump (first 32 bytes):
>     63 70 75 66 72 65 71 00 55 31 2e 5f 50 50 43 00  cpufreq.U1._PPC.
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<c122f8d7>] kmemleak_alloc+0x27/0x50
>     [<c109c93f>] __kmalloc+0xcf/0x110
>     [<c108554c>] kstrdup+0x2c/0x50
>     [<c10e8604>] sysfs_new_dirent+0xe4/0x100
>     [<c10e8e8e>] create_dir+0x2e/0xb0
>     [<c10e8f80>] sysfs_create_dir+0x70/0xb0
>     [<c11248cc>] kobject_add_internal+0x8c/0x1d0
>     [<c1124b1d>] kobject_add_varg+0x2d/0x50
>     [<c1124b67>] kobject_init_and_add+0x27/0x30
>     [<c11c2fbc>] cpufreq_add_dev_interface+0x3c/0x290
>     [<c11c3b7c>] cpufreq_add_dev+0x29c/0x3a0
>     [<c1187db7>] sysdev_driver_register+0x97/0x110
>     [<c11c29b6>] cpufreq_register_driver+0x86/0x140
>     [<f9b76080>] 0xf9b76080
>     [<c100112d>] do_one_initcall+0x2d/0x180
>     [<c105ecf9>] sys_init_module+0x99/0x1e0
> 
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
