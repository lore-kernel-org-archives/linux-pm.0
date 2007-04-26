From: john stultz <johnstul@us.ibm.com>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 17:49:33 -0700
Message-ID: <1177548573.6401.36.camel__2506.04919060624$1177548694$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<1177524532.6401.17.camel@localhost.localdomain>
	<200704252033.06288.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704252033.06288.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Mikael Pettersson <mikpe@it.uu.se>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-pm@lists.linux-foundation.org, Guilherme Schroeder <guilherme@centralinf.com.br>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, ak@suse.de
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-04-25 at 20:33 -0400, Len Brown wrote:
> On Wednesday 25 April 2007 14:08, john stultz wrote:
> > On Wed, 2007-04-25 at 04:06 -0700, Andrew Morton wrote:
> > > On Mon, 23 Apr 2007 23:49:09 +0200 Adrian Bunk <bunk@stusta.de> wrote:
> > > > Subject    : acpi_pm clocksource loses time on x86-64
> > > > References : http://lkml.org/lkml/2007/4/17/143
> > > > Submitter  : Mikael Pettersson <mikpe@it.uu.se>
> > > > Handled-By : John Stultz <johnstul@us.ibm.com>
> > > > Status     : problem is being debugged
> > 
> > 
> > The ACPI PM one is *really* odd as its the same clocksource driver on
> > both arches. I had Mikael cut out the clocksource frequency adjustments,
> > and confirmed both i386 and x86_64 are using the same base freq
> > (confirmed via printks).
> 
> If this chipset's PM-timer loses "several minutes per hour" on x86_64,
> I would expect it to do the same on i386.  I can't imagine what the
> difference could be.  Any possibility it is the 24-bit version
> and we do something funky on wraparound?

No, we assume the PM timer wraps at 24 bits and mask it as such on all
systems.

-john
