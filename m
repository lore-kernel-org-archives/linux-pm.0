From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: tsc breaks atkbd suspend
Date: Tue, 19 Feb 2008 17:51:01 +0100 (CET)
Message-ID: <alpine.LFD.1.00.0802191748110.7583@apollo.tec.linutronix.de>
References: <20080218133852.GA1573@elf.ucw.cz>
	<alpine.LFD.1.00.0802181515070.7583@apollo.tec.linutronix.de>
	<20080218143757.GB1960@elf.ucw.cz>
	<alpine.LFD.1.00.0802181545090.7583@apollo.tec.linutronix.de>
	<20080219100029.GA1637@elf.ucw.cz> <20080219140552.GC9965@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080219140552.GC9965@elte.hu>
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
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, jbohac@suse.cz, jikos@suse.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 19 Feb 2008, Ingo Molnar wrote:
> * Pavel Machek <pavel@ucw.cz> wrote:
> 
> > TSC is used even on machines when CONFIG_X86_TSC is not set (X86_TSC 
> > means _require_ TSC), but it is not properly disabled when it is 
> > unusable, because acpi code understood the config switch as "may use 
> > TSC".
> > 
> > This actually fixes suspend problems on my x60.
> 
> ah! This makes tons of sense. I've applied your patch - but i guess it 
> should go via the ACPI tree.

Right. The breakage was introduced there when IA64 switched to
GENERIC_TIME and the X86_TSC dependency was added.

Thanks,

	tglx
