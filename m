From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 idle APM: delete apm_cpu_idle(),
 and its use of pm_idle
Date: Thu, 31 Mar 2011 08:56:22 +0200
Message-ID: <20110331065622.GE5938__15876.2587038384$1301554646$gmane$org@elte.hu>
References: <20110326172204.05e52c10.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.1103281443240.8162@twin.jikos.cz>
	<20110329004438.d9e755ef.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1103281604040.26754@pobox.suse.cz>
	<20110328174542.GW21838@one.firstfloor.org>
	<4D90CC0B.8070105@zytor.com>
	<20110328182123.GX21838@one.firstfloor.org>
	<AANLkTimqE2YZCH5GonnqeHGGBwzggTymauS1KYuTsqOX@mail.gmail.com>
	<alpine.LNX.2.00.1103282309290.26754@pobox.suse.cz>
	<alpine.LFD.2.02.1103302311500.2444@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1103302311500.2444@x980>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ondrej Zary <linux@rainbow-software.org>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> There is some doubt whether the APM idle feature
> to call into the BIOS from the idle loop is reliable.
> Certainly it was known to fail on some machines,
> but more importantly, APM machines have not shipped
> for a decade and so finding machines to test the code
> is problematic.
> 
> After this patch, systems running in APM mode will
> simply run default_idle() and HALT without calling
> into the BIOS from their idle loop.
> 
> This deletes a much-maligned modular user of the (pm_idle)()
> function pointer.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Ok, this should have far less negative impact on old hardware.

Acked-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
