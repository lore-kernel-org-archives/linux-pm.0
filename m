From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.31-rc5: Reported regressions from 2.6.30
Date: Mon, 3 Aug 2009 18:09:58 +0200
Message-ID: <200908031810.00505.rjw__24588.9738006101$1249315829$gmane$org@sisk.pl>
References: <Su1q3S6JjyO.A.jeB.hcgdKB@chimera>
	<alpine.LFD.2.01.0908021456430.3352@localhost.localdomain>
	<20090803143108.GA12041@cmpxchg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090803143108.GA12041@cmpxchg.org>
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
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Adrian Bunk <bunk@kernel.org>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 03 August 2009, Johannes Weiner wrote:
> On Sun, Aug 02, 2009 at 03:22:01PM -0700, Linus Torvalds wrote:
> 
> > > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13815
> > > Subject		: emacs -nw compilation doesn't show the error message
> > > Submitter	: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > > Date		: 2009-07-23 06:22 (11 days old)
> > > First-Bad-Commit: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d945cb9cce20ac7143c2de8d88b187f62db99bdc
> > 
> > Same old pty bug, same fix: commit e043e42bdb.
> > 
> > > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13813
> > > Subject		: Hangups in n_tty_read()
> > > Submitter	: Johannes Weiner <hannes@cmpxchg.org>
> > > Date		: 2009-07-16 18:48 (18 days old)
> > > References	: http://marc.info/?l=linux-kernel&m=124777019920579&w=4
> > 
> > Hmm. Worth testing that same fix, although the symptoms here are not 
> > exactly the same.
> 
> Hm, I had no debugging enabled, but I think a silent hang in
> 
> 	pty_write()
> 	  tty_flip_buffer_push()
> 	    flush_to_ldisc()
> 
> can cause the receiving side
> 
> 	tty_read()
> 	  n_tty_read()
> 
> to wait forever for updates.  I haven't looked closely.  It seems to
> be gone with your latest master in any case.

Thanks, closed (in fact I closed it earlier already).

Rafael
