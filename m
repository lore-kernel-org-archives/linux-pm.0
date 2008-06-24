From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor
	register on	resume
Date: Tue, 24 Jun 2008 23:46:10 +0200
Message-ID: <20080624214610.GC18679__6883.09519687227$1214344112$gmane$org@elf.ucw.cz>
References: <200806242303.49498.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806242303.49498.rjw@sisk.pl>
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
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: H. Peter Anvin <hpa@zytor.com>
> 
> x86 ACPI: normalize segment descriptor register on resume
> 
> Some Dell laptops enter resume with apparent garbage in the segment
> descriptor registers (almost certainly the result of a botched
> transition from protected to real mode.)  The only way to clean that
> up is to enter protected mode ourselves and clean out the descriptor
> registers.
> 
> This fixes resume on Dell XPS M1210 and Dell D620.
> 
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=10927
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> Tested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks for great work.

I still consider this one slightly risky, and would like to get it as
much testing as possible, but all the risks are hypothetical and
regression from 2.6.25 is real, so...

Acked-by: Pavel Machek <pavel@suse.cz>

If this could be sneaked into Ingo's tree for some automated testing,
that would be good.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
