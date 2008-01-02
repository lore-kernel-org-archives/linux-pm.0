From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [Suspend2-devel] Freezing filesystems (Was Re:
	What's in store for 2008 for TuxOnIce?)
Date: Tue, 1 Jan 2008 20:03:25 -0500
Message-ID: <20080102010325.GC13288__11881.7981136546$1199289214$gmane$org@mit.edu>
References: <477AC060.5040004@nigel.suspend2.net>
	<200801020021.37259.rjw@sisk.pl>
	<477AD2AA.4070707@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <477AD2AA.4070707@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, The place to get help! <suspend2-users@lists.tuxonice.net>, suspend2-devel@lists.tuxonice.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 02, 2008 at 10:54:18AM +1100, Nigel Cunningham wrote:
> > I would also like the TuxOnIce issues related to drivers, ACPI, etc. to go to
> > one of the kernel-related lists, but I think linux-pm may be better for that
> > due to the much lower traffic.
> 
> I guess that makes sense. I guess people can always be referred to LKML
> for the issues where the appropriate person isn't on linux-pm.

Hi Nigel,

I'd really recommend pushing the TuxOnIce discussions to LKML.  That
way people can see the size of the user community and Andrew and Linus
can see how many people are using TuxOnIce.  They can also see how
well the TuxOnIce community helps address user problems, which is a
big consideration when Linus decides whether or not to merge a
particular technology. 

If the goal is eventual merger of TuxOnIce, LKML is really the best
place to have the discussions.  Examples such as Realtime, CFS, and
others have shown that you really want to keep the discussion front
and center.  When one developer says, "not my problem; my code is
perfect", and the other developer is working with users who report
problems, guess which technology generally ends up getting merged by
Linus?

Regards,

						- Ted
