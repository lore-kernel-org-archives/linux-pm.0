From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 10:17:14 +0800
Message-ID: <1185070634.3517.11.camel__12716.3559118801$1185070735$gmane$org@caritas-dev.intel.com>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<200707172217.01890.rjw@sisk.pl> <87odiag45q.fsf@jbms.ath.cx>
	<200707151433.34625.rjw@sisk.pl> <200707172320.16279.rjw@sisk.pl>
	<40fa2626aff7b6b590ad6aa4737fc873@bga.com>
	<1184942918.13737.23.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707200845200.19248@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707200845200.19248@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-07-20 at 08:48 -0700, david@lang.hm wrote:
> > Backuping target memory before kexec and restoring it after kexec is
> > planed feature for kexec jump. But I will work on image writing/reading
> > first.
> 
> if we can get a list of what memory is safe to backup/restore then the 
> reading/writing of the image should be able to be done in userspace.

The backup/restore here has nothing to do with the read/write of the
image. It means instead of preserving memory for a new kernel like that
of crash-dump, the memory for a new kernel is backupped before kexec and
restored after kexec by the kexec kernel.

> > If the "scatter copy" is replaced by "scatter swap", we need not the
> > inverse list, and the state of kexeced kernel can be backuped too. There
> > are "scatter copy" support in normal kexec implementation in
> > "relocate_kernel".
> 
> what do you mean by "scatter swap"

copy:	dest=src
swap:	tmp=dest; dest=src; src=tmp

If memory is swapped, no information is lost, both that of kexec kernel
and kexeced kernel.

Best Regards,
Huang, Ying
