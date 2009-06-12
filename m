From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM updates for 2.6.31
Date: Sat, 13 Jun 2009 00:44:09 +0200
Message-ID: <200906130044.11273.rjw__2924.34163061461$1244846693$gmane$org@sisk.pl>
References: <200906122202.08345.rjw@sisk.pl>
	<alpine.LFD.2.01.0906121317320.3237@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.01.0906121317320.3237@localhost.localdomain>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Jaswinder Singh Rajput <jaswinder@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Friday 12 June 2009, Linus Torvalds wrote:
> 
> On Fri, 12 Jun 2009, Rafael J. Wysocki wrote:
> 
> > Hi Linus,
> > 
> > Please pull power management updates for 2.6.31 from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus
> > 
> > They are cleanups and code rearrangements mostly, in particular:
> > 
> > * arch/x86/power/cpu_(32|64) unification from Sergio Luis (Ingo saw
> >   these patches and his opinion was that they should better go
> >   through the suspend tree)
> > 
> > * Removal of some unused files and PM callbacks, function renames
> >   from Magnus Damm and Alan Stern
> > 
> > * Rearrangements of the code under kernel/power from me and
> >   Cornelia Huck
> > 
> > * Two patches related to the memory shrinking (for the record, Pavel
> >   doesn't like the "PM/Suspend: Do not shrink memory before suspend"
> >   patch, so please let me know if I should drop it)
> > 
> > * A couple of bug fixes
> > 
> > 
> >  arch/x86/power/cpu.c             |  259 +++++++++++
> >  arch/x86/power/cpu_32.c          |  148 ------
> >  arch/x86/power/cpu_64.c          |  174 -------
> >  kernel/power/disk.c              |  955 --------------------------------------
> >  kernel/power/hibernate.c         |  955 ++++++++++++++++++++++++++++++++++++++
> >  kernel/power/hibernate_nvs.c     |  135 ++++++
> >  35 files changed, 2056 insertions(+), 2194 deletions(-)
> 
> Please add rename detection to your pull script (and --summary, for that 
> matter). This _should_ have looked like
> 
>  33 files changed, 984 insertions(+), 1122 deletions(-)
> 
> because it would have detected this:
> 
>  rename arch/x86/power/{cpu_64.c => cpu.c} (62%)
>  delete mode 100644 arch/x86/power/cpu_32.c
>  rename kernel/power/{disk.c => hibernate.c} (96%)
> 
> instead of counting those as some huge patches that add/remove code.

I will, sorry for not doing it this time and thanks for pulling.

Best,
Rafael
