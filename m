From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29-rc4: Reported regressions from 2.6.28
Date: Sun, 8 Feb 2009 23:04:52 +0100
Message-ID: <200902082304.53585.rjw__20780.5202379406$1234131184$gmane$org@sisk.pl>
References: <AIghyjFgMFP.A.uZD._10jJB@chimera>
	<alpine.LFD.2.00.0902081354150.3048@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902081354150.3048@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Linus Torvalds wrote:
> 
> On Sun, 8 Feb 2009, Rafael J. Wysocki wrote:
> > 
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=12669
> > Subject		: 2.6.28.4 regression: mmap fails if mlockall used
> > Submitter	: Sami Farin <safari-kernel@safari.iki.fi>
> > Date		: 2009-02-08 10:52 (1 days old)
> > References	: http://marc.info/?l=linux-kernel&m=123409037423068&w=4
> 
> Oh, Hugh just sent a patch, and it's now commit 
> d5b562330ec766292a3ac54ae5e0673610bd5b3d. Sadly this just missed -rc4 by 
> something like 20 minutes..

Yes, I saw the Hugh's message right after sending the report.

Bug closed.

Thanks,
Rafael
