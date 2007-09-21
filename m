From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 11:45:12 +0200
Message-ID: <20070921094512.GA20149__43992.2841069803$1190368155$gmane$org@elf.ucw.cz>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
	<200709211259.00195.nigel@nigel.suspend2.net>
	<m1r6ksiq27.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m1r6ksiq27.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!
> >
> > Sounds doable, as long as you can cope with long command lines (which 
> > shouldn't be a biggie). (If you've got a swapfile or parts of a swap 
> > partition already in use, it can be quite fragmented).
> 
> Hmm.  This is an interesting problem.  Sharing a swap file or a swap
> partition with the actual swap of user space pages does seem to be
> a limitation of this approach.
> 
> Although the fact that it is simple to write to a separate file may
> be a reasonable compensation.

I'm not sure how you'd write it to a separate file. Notice that kjump
kernel may not mount journalling filesystems, not even
read-only. (Ext3 replays journal in that case). You could pass block
numbers from the original kernel...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
