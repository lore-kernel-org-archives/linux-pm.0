From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Mon, 6 Aug 2007 11:02:10 +0200
Message-ID: <20070806090210.GA15329@atrey.karlin.mff.cuni.cz>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731110458.GA1777@elf.ucw.cz>
	<1185932071.1363.13.camel@caritas-dev.intel.com>
	<20070805185558.GE1758@elf.ucw.cz>
	<1186367486.527.5.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1186367486.527.5.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Did the trick, I got the kernel to load, and it even attempted
> > exec... but I got doublefault (or what is it?)
> > 
> > Int 6: ... EIP: c4739906. Address is in reserve_bootmem_core.
> > 
> > Do I have to disable ACPI completely? I tried with acpi=off,
> > nosmp... but problem does not seem device related.
> 
> It seems that the problem has nothing to do with device or ACPI. Can you
> do a normal kexec? That is:
> 
> kexec -l <...>
> kexec -e
> 
> or 
> 
> kexec -p <...>
> ALT-SysRq-c to trigger a crash dump.

...that was indeed a problem. I can do successful kexec, as long as I
load bzImage (and not vmlinux). (Both kernels 2.6.22 and
2.6.23-rc2-git). Problem is, I can only load bzImage using -l, attempt
to load bzImage using -p results in 

"Could not find a free area of memory of 9000 bytes"
locate_hole failed

. Any ideas?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
