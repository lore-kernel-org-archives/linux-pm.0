From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] x86 PM: Consolidate suspend and
	hibernation code
Date: Sun, 3 Feb 2008 22:16:56 +0100
Message-ID: <200802032216.57391.rjw__2324.42233614183$1202073648$gmane$org@sisk.pl>
References: <200802032141.56887.rjw@sisk.pl> <20080203211519.GA27737@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080203211519.GA27737@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 of February 2008, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > This series of patches consolidates the x86 suspend and hibernation code.
> > It does the following:
> > - move 64-bit hibernation/suspend files to arch/x86/power (under different
> >   names)
> > - rename 32-bit files in arch/x86/power in line with the 64-bit files
> > - separate hibernation-specific 64-bit code from the code used for both
> >   suspend and hibernation and simplify the Makefile
> > - fix up comments
> > Details are in the changelogs.
> > 
> > These patches don't introduce any functional changes.
> 
> looks sane to me - i've applied them to x86.git. Is it fine with you if 
> we push them upstream (barring any test failures)?

Yes, it is. :-)

Thanks,
Rafael
