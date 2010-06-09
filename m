From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.35-rc2-git2: Reported regressions from 2.6.34
Date: Wed, 9 Jun 2010 11:22:35 +0200
Message-ID: <201006091122.35304.rjw__30737.8912847073$1276075710$gmane$org@sisk.pl>
References: <Rlf_Qjov7bG.A.a8F.I8rDMB@chimera>
	<AANLkTiksbL1qHg7Q0A-6TbX0uUrxra4jctUoIGVk5vnE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTiksbL1qHg7Q0A-6TbX0uUrxra4jctUoIGVk5vnE@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: sedat.dilek@gmail.com
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, dmonakhov@openvz.org, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 June 2010, Sedat Dilek wrote:
> The patch from [1] is still missing.
> 
>    "cpufreq-call-nr_iowait_cpu-with-disabled-preemption.patch" from
> Dmitry Monakhoc
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by Maciej Rutecki <maciej.rutecki@gmail.com>
> 
> I have already reported this issue on LKML [2] and cpufreq ML [3].
> 
> - Sedat -
> 
> [1] http://www.spinics.net/lists/cpufreq/msg01631.html
> [2] http://lkml.org/lkml/2010/5/31/77
> [3] http://www.spinics.net/lists/cpufreq/msg01637.html

Thanks, added.

Rafael
