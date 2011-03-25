From: Calvin Walton <calvin.walton@kepstin.ca>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Fri, 25 Mar 2011 11:41:54 -0400
Message-ID: <1301067716.2053.6.camel__45364.3799447038$1301323312$gmane$org@ayu>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<alpine.LFD.2.02.1103240414450.4529@x980>
	<20110324083959.GE30812@elte.hu>
	<alpine.LFD.2.02.1103241929450.16085@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1103241929450.16085@x980>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H.
	Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-03-24 at 19:49 -0400, Len Brown wrote:
> > > Microsoft was able to delete APM from Windows in 2006
> > > with the release of Windows Vista. [...]
> > 
> > Does Windows XP still support it?
> 
> yes, and so does Red Hat Linux 9.

> > While i'm not a fan of APM at all, this removal is a tad fast IMHO.
> >
> > Beyond the lack of a upstream-visible feature-removal-schedule entry, we still 
> > have an Arcnet driver which hardware was obsoleted by Ethernet in the late 80s, 
> > and we still have i486 support and those are *much* older than APM.
> 
> How would you like to write i486 specific code for the latest kernel
> and test it on i486 hardware, honestly?

Hmm, that reminds me: I should try a newer kernel on my 486 some time,
it's still running 2.6.25. I'm actually quite honestly surprised that
the modern libata drivers include code for and fully support my old
vesa-bus IDE controller! (X has been less friendly, they dropped support
for the graphics chipset during the Xfree86 4 development--but I mostly
use this box headless.)

-- 
Calvin Walton <calvin.walton@kepstin.ca>
