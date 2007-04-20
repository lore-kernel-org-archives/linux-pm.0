From: Dave Jones <davej@redhat.com>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Fri, 20 Apr 2007 13:21:47 -0400
Message-ID: <20070420172147.GC20118@redhat.com>
References: <20070416003723.GM3691@stusta.de> <4628482B.6040804@goop.org>
	<20070420050344.GG20566@redhat.com> <46284C84.6060301@goop.org>
	<20070420051908.GH20566@redhat.com> <462850B3.70901@goop.org>
	<20070420145126.GC25051@redhat.com> <4628DC0A.60707@goop.org>
	<20070420160308.GB20118@redhat.com> <4628F586.3040606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4628F586.3040606@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: gregkh@suse.de, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 20, 2007 at 10:16:54AM -0700, Jeremy Fitzhardinge wrote:
 > Dave Jones wrote:
 > >  > Andi, I think.  I've got his firstfloor.org patches applied to this kernel.
 > >
 > > Ah, I saw you patched in CFS too, and thought it may be related.
 > >   
 > 
 > Well, I have CONFIG_FB_BACKLIGHT enabled, and it still works.
 > 
 > Maybe there's something in Andi's queue which is making it work?

Shrug, I'm out of ideas.  I'm hoping that it'll magically start working
when people start flushing their git trees for .22
Maybe that'll yield a clue for something that can be backported to .21.x
because right now, I'm completely puzzled.

I was testing on a vanilla 2.6.21-rc7-git3.

	Dave

-- 
http://www.codemonkey.org.uk
