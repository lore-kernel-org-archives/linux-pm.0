From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PULL] PM updates for 2.6.31
Date: Fri, 12 Jun 2009 22:06:33 +0200
Message-ID: <20090612200633.GB17688__35824.1658461795$1244839593$gmane$org@elf.ucw.cz>
References: <200906122202.08345.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906122202.08345.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Jaswinder Singh Rajput <jaswinder@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-06-12 22:02:06, Rafael J. Wysocki wrote:
> Hi Linus,
> 
> Please pull power management updates for 2.6.31 from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus
> 
> They are cleanups and code rearrangements mostly, in particular:
> 
> * arch/x86/power/cpu_(32|64) unification from Sergio Luis (Ingo saw
>   these patches and his opinion was that they should better go
>   through the suspend tree)
> 
> * Removal of some unused files and PM callbacks, function renames
>   from Magnus Damm and Alan Stern
> 
> * Rearrangements of the code under kernel/power from me and
>   Cornelia Huck
> 
> * Two patches related to the memory shrinking (for the record, Pavel
>   doesn't like the "PM/Suspend: Do not shrink memory before suspend"
>   patch, so please let me know if I should drop it)

Thanks.

For the record, the patch will break suspend if suspend is attempted
with 0 pages free. (I believe Rafael agrees with this).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
