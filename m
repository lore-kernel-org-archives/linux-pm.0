From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] x86 PM: Consolidate suspend and
	hibernation code
Date: Sun, 3 Feb 2008 22:22:36 +0100
Message-ID: <20080203212236.GA2574__12382.9198805199$1202073929$gmane$org@elf.ucw.cz>
References: <200802032141.56887.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802032141.56887.rjw@sisk.pl>
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
Cc: Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-02-03 21:41:56, Rafael J. Wysocki wrote:
> Hi,
> 
> This series of patches consolidates the x86 suspend and hibernation code.
> It does the following:
> - move 64-bit hibernation/suspend files to arch/x86/power (under different
>   names)
> - rename 32-bit files in arch/x86/power in line with the 64-bit files
> - separate hibernation-specific 64-bit code from the code used for both
>   suspend and hibernation and simplify the Makefile
> - fix up comments
> Details are in the changelogs.
> 
> These patches don't introduce any functional changes.
> 
> Please review (and consider for merging if they look good :-)).

ACK, and thanks... It would make merges easier if this could go in
soon...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
