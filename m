From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.34-rc3-git6: Reported regressions from 2.6.33
Date: Wed, 7 Apr 2010 15:22:20 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004071521500.3586__8876.09244459799$1270679264$gmane$org@i5.linux-foundation.org>
References: <6Pphclm24fK.A.lSF.qsPvLB@chimera>
	<alpine.LFD.2.00.1004071444440.3586@i5.linux-foundation.org>
	<20100407221941.GL30031@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100407221941.GL30031@ZenIV.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org



On Wed, 7 Apr 2010, Al Viro wrote:
> 
> No, it's not the same thing; the fix is to have nfs ->d_revalidate()
> return an error on failing open attempt (in insane codepath that has
> ->d_revalidate() handling open()).  Confirmed to work by reporter...

Ok, can you do the proper changelog description and sign-offs etc?

		Linus
