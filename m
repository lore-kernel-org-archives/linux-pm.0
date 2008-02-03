From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 0/4] x86 PM: Consolidate suspend and
	hibernation code
Date: Sun, 3 Feb 2008 22:52:36 +0100
Message-ID: <20080203215236.GG2648__32399.1884397858$1202075665$gmane$org@uranus.ravnborg.org>
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
Cc: Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 03, 2008 at 09:41:56PM +0100, Rafael J. Wysocki wrote:
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

All looks good from my angle.

I would have deferred first patch until step 3 but no need to change
that now.
And I like the simplification of the arch/x86/Makefile
and the resulting kernel/power/Makefile.

	Sam
