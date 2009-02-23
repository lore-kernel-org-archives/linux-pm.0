From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Mon, 23 Feb 2009 21:13:06 +1100
Message-ID: <1235383986.8805.239.camel__27207.8757327565$1235384250$gmane$org@pasglop>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902220946070.3111@localhost.localdomain>
	<200902222342.08285.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
	<m1ab8ddfbr.fsf@fess.ebiederm.org> <20090223084400.GB9582@elte.hu>
	<m17i3ha4nk.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m17i3ha4nk.fsf@fess.ebiederm.org>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-02-23 at 01:22 -0800, Eric W. Biederman wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> 
> > I think this aspect has been well-understood during the 
> > discussion of this topic and it's just a slightly misleading 
> > changelog.
> 
> As I was a member of that discussion I did not see that.
> 
> It took me several passes through the patches to realize
> the goal is to allow drivers to be able to sleep while they
> are in their late pm shutdown routines.
> 
> Why we want this I don't know.  But it seems simple enough
> to implement, and it makes it harder to get the late pm
> suspend routines wrong, which is always good.

To simplify (it's really all in the discussion we had the last few
weeks) It boils down to being able to do the proper ACPI calls (which
require core interrupts to be on, ie, ACPI uses mutexes, sleeps, etc...)
after we have saved and before we restore the PCI config space, in the
late suspend or early resume stages of devices.

Cheers,
Ben.
