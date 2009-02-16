From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29-rc5: Reported regressions from 2.6.28
Date: Mon, 16 Feb 2009 22:11:29 +0100
Message-ID: <200902162211.30830.rjw__25637.2870797806$1234818875$gmane$org@sisk.pl>
References: <20090216072910.GA4763@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216072910.GA4763@ff.dom.local>
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
To: Jarek Poplawski <jarkao2@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 February 2009, Jarek Poplawski wrote:
> On 14-02-2009 21:35, Rafael J. Wysocki wrote:
> > This message contains a list of some regressions from 2.6.28, for which there
> > are no fixes in the mainline I know of.  If any of them have been fixed already,
> > please let me know.
> ...
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=12615
> > Subject		: boot hangs while bringing up gianfar ethernet
> > Submitter	: Ira Snyder <iws@ovro.caltech.edu>
> > Date		: 2009-01-29 19:41 (17 days old)
> > References	: http://marc.info/?l=linux-kernel&m=123325817201665&w=4
> 
> Fixed by:
> commit	8707bdd48ab705a459ac1b12014075a139d1d4f9
> gianfar: Fix boot hangs while bringing up gianfar ethernet
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8707bdd48ab705a459ac1b12014075a139d1d4f9

Thanks, closed.

Rafael
