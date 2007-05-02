From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 02 May 2007 23:44:01 +0200
Message-ID: <1178142241.2340.21.camel__24742.651920724$1178149387$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<20070425114317.GA32153@elte.hu>
	<b6a2187b0704250645t62a0d8u20f1f43df6feaea@mail.gmail.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b6a2187b0704250645t62a0d8u20f1f43df6feaea@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Mikael Pettersson <mikpe@it.uu.se>, John Stultz <johnstul@us.ibm.com>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Guilherme Schroeder <guilherme@centralinf.com.br>, Adrian Bunk <bunk@stusta.de>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, discuss@x86-64.org, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Jeff,

On Wed, 2007-04-25 at 21:45 +0800, Jeff Chua wrote:
> On 4/25/07, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > > > Subject    : suspend to disk hangs  (CONFIG_NO_HZ)
> > > > References : http://lkml.org/lkml/2007/3/25/217
> > > > Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> > > > Status     : unknown
> > >
> > > That's still rather a lot of bustage from the timekeeping changes.  Is
> > > anything really happening here or have we all given up?
> >
> > Jeff: does that suspend-to-disk hang problem also happen if you use
> > hpet=disable?
> 
> Yes, it is still broken with HPET disabled.
> 
> I've reported that if I press some keys, suspend will complete
> successfully, otherwise, it'll just hang before the "percentage" comes
> on.

Can you please grab the collection of fixups, which I just put into
bugzilla: 

http://bugzilla.kernel.org/attachment.cgi?id=11379&action=view

and apply it on top of 2.6.21 ?

Thanks,

	tglx
