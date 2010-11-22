From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH RESEND] tools: add
 power/x86/x86_energy_perf_policy to program MSR_IA32_ENERGY_PERF_BIAS
Date: Mon, 22 Nov 2010 21:33:59 +0100
Message-ID: <20101122203359.GD21836__33508.4821483635$1290458099$gmane$org@basil.fritz.box>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
	<alpine.LFD.2.00.1009281143070.14962@localhost.localdomain>
	<alpine.LFD.2.00.1010230035360.29399@localhost.localdomain>
	<alpine.LFD.2.00.1011151103280.2939@x980>
	<8739r0rxlz.fsf@basil.nowhere.org>
	<alpine.LFD.2.00.1011221348200.19247@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1011221348200.19247@x980>
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
Cc: x86@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 22, 2010 at 03:13:24PM -0500, Len Brown wrote:
> Per the comments from Andrew and others, the concept of a
> "full tools build" doesn't actually exit (yet).
> 
> So I guess the only assurance that somebody not on x86 would run
> make in this directory this utility lives in tools/power/x86/
> 
> Note that there are other utilities under tools
> which have no Makefile at all...

I suspect this will need to be fixed at some point.

e.g. kernel rpms probably don't want to hard code all of this
but just call some standard make file target. And the kernel
eventually needs a make install_user or similar.

> 
> > ...I would prefer a manpage
> 
> I'll be happy to write a manpage.
> Is there good example I should follow?

Just pick one from /usr/share/man.  You can grep for my 
name if you want one written by me, but I don't claim they are
necessarily better than others @)

> I'm not inclined to bother, as the use-case for this utility
> is to be invoked by another program, and the options available

What other program?

I could well imagine administrators sticking this 
into their boot.locals to set the policy they want.

> In the highly unlikely scenario that somebody uses
> the -r option to excerise the read-only code,
> and simultaneously invokes and completes a cpu hot remove

FWIW there are setups where core offlining can happen
automatically in response to an error.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
