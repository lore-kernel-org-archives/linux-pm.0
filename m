From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Fri, 16 May 2008 14:13:28 +0200
Message-ID: <20080516121328.GD22264__8539.19953010536$1210940154$gmane$org@elf.ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210818762.23707.102.camel@caritas-dev.intel.com>
	<20080515200923.GC9718@redhat.com>
	<1210902514.23707.161.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1210902514.23707.161.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-05-16 09:48:34, Huang, Ying wrote:
> On Thu, 2008-05-15 at 16:09 -0400, Vivek Goyal wrote:
> [...]
> > Ok, You want to make BIOS calls. We already do that using vm86 mode and
> > use bios real mode interrupts. So why do we need this interface? Or, IOW,
> > how is this interface better?
> 
> It can call code in 32-bit physical mode in addition to real mode. So It
> can be used to call EFI runtime service, especially call EFI 64 runtime
> service under 32-bit kernel or vice versa.
> 
> The main purpose of kexec jump is for hibernation. But I think if the
> effort is small, why not support general 32-bit physical mode code call
> at same time.

I believe we should focus on kexecing kernels, first.

Only way to prove the effort is small is by having small followup
patch, and that needs the two patches separated...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
