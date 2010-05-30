From: Victor Lowther <victor.lowther@gmail.com>
Subject: Re: [Pm-utils] cores offline after pm-suspend?
Date: Sun, 30 May 2010 10:23:39 -0500
Message-ID: <1275233020.4638.32.camel__37278.5670836039$1275233107$gmane$org@localhost.localdomain>
References: <1275231359-sup-8543@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275231359-sup-8543@nixos>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marc Weber <marco-oweber@gmx.de>
Cc: pm-utils@lists.freedesktop.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2010-05-30 at 17:04 +0200, Marc Weber wrote:
> Hi,
> 
> Some weeks ago I got a new laptop running core -i5 processsor.
> Everything seems to be working. However after resuming from suspend to
> ram htop only shows one core having 100% utilization and I can't seem to
> fix this putting cores off and online again using the sys cpuX/online
> interface.

Weird.  pm-utils does not do anything special with the cpus across
suspend/resume -- the kernel handles all that.

I have gone ahead and cc'ed the linux-pm mailing list.

> I've tried putting them offline before suspending as well.
> 
> My test case:
> 
> Makefile:
> 
>   a4: a1.x a2.x a3.x a4.x
>   all: a1.x a2.x a3.x a4.x a5.x a6.x a7.x a8.x a9.x a10.x a11.x b1.x b2.x b3.x b4.x 
>   %.x:
>           ./hog
> 
> hog is a just a c prog running a dummy loop which lasts about 4 secs.
> 
> I made a screenshot of htop:
> http://mawercer.de/~marc/htop.jpg
> Make started 4 processes, however only one is running on a core.
> 
> make -j4 doesn't finish faster than make -j1 either.
> 
> Do you have any idea how to start debugging this issue?
> 
> Of course everything is fine after rebooting.
> 
> My kernel:
> 
> Linux nixos 2.6.32.14 #1 SMP Sat May 29 22:06:43 UTC 2010 x86_64 GNU/Linux
> 
> using pm-utils-1.3.0
> 
> Any ideas or hints are appreciated.
> 
> Marc Weber
> _______________________________________________
> Pm-utils mailing list
> Pm-utils@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/pm-utils

-- 
Victor Lowther
LPIC2 UCP RHCE 
