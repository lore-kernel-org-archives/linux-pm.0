From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.34-rc6-git2: Reported regressions from 2.6.33
Date: Tue, 4 May 2010 17:00:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005041654400.5478__48283.1794456162$1273017858$gmane$org@i5.linux-foundation.org>
References: <JzEGxUyyQHG.A.ZtH.YHJ4LB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <JzEGxUyyQHG.A.ZtH.YHJ4LB@chimera>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org



On Tue, 4 May 2010, Rafael J. Wysocki wrote:
> 
> Unresolved regressions
> ----------------------
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=15880
> Subject		: Very bad regression from 2.6.33 as of 1600f9def
> Submitter	: Alex Elsayed <eternaleye@gmail.com>
> Date		: 2010-04-29 2:28 (6 days old)
> Message-ID	: <loom.20100429T041908-663@post.gmane.org>
> References	: http://marc.info/?l=linux-kernel&m=127250825306178&w=2

This looks like it wasn't a regression, but some other compile/install 
issue. See

	http://marc.info/?l=linux-kernel&m=127274294422719&w=2

where he reports that his self-compiled 2.6.33 doesn't boot either. 

There's some confusion about .config, but it might well be an install 
problem too (in fact, that sounds more likely - the original bug-report 
seems to reboot before the kernel has really even booted - it apparently 
hasn't done the graphics mode switch by the early bootloader)

		Linus
