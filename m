From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Fri, 17 Apr 2009 23:25:45 +0200
Message-ID: <200904172325.49030.rjw__4500.01968206397$1240003840$gmane$org@sisk.pl>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
	<alpine.LFD.2.00.0904161738030.4042@localhost.localdomain>
	<20090417012544.GB16126@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090417012544.GB16126@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 17 April 2009, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > 
> > 
> > I think you put this in the wrong regression pile:
> > 
> > > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13112
> > > Subject		: Oops in drain_array
> > > Submitter	: Bart <mmx@riz.pl>
> > > Date		: 2009-04-14 10:21 (3 days old)
> > > References	: http://marc.info/?l=linux-kernel&m=123970493224628&w=4
> > 
> > Hmm. This one seems like it should be in the "since 2.6.28" camp, since if 
> > I read that one right, it happens with 2.6.29.1.
> > 
> > (I mean sure, it might be new since 2.6.29, but it sounds more likely that 
> > it's already in 2.6.29)
> 
> I'd suspect it's possibly hardware related:
> 
>   http://www.kerneloops.org/search.php?search=free_block&btnG=Function+Search
> 
> Look at the very similar call signatures - spanning almost all 
> kernels back to v2.6.16. There's one spike at .27 - perhaps the same 
> box trying up hard and crashing several times - or a popular distro 
> kernel?
> 
> Or it's a really ancient bug going back to v2.6.16.

I have moved this one onto the list of regressions from 2.6.28.  When it is
confirmed that the bug is older, I'll drop it from there.

Thanks,
Rafael
