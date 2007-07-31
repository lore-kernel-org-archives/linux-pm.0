From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/2] Introduce CONFIG_HIBERNATION and
	CONFIG_SUSPEND (updated)
Date: Mon, 30 Jul 2007 23:54:17 -0400
Message-ID: <200707302354.18212.lenb__42501.2836502448$1185854352$gmane$org@kernel.org>
References: <200707251238.50218.lenb@kernel.org>
	<200707292323.29601.rjw@sisk.pl>
	<alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
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
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 29 July 2007 20:21, Linus Torvalds wrote:
> 
> Ok, I took this, and modified Len's patch to re-introduce ACPI_SLEEP on 
> top of it (I took the easy way out, and just made PM_SLEEP imply 
> ACPI_SLEEP, which should make everything come out right. I could have 
> dropped ACPI_SLEEP entirely in favour of PM_SLEEP, but that would have 
> implied changing more of Len's patch than I was really comfy with).
> 
> Len, Rafael, please do check that the end result looks ok. 

SUSPEND depends only on (!SMP || SUSPEND_SMP_POSSIBLE).
This means that while we limit the architectures it can build on
if they are SMP, it can build on any !SMP architecture --
which probably isn't what we want.

I think the right way to go is your SUSPEND_UP_POSSIBLE suggestion.
Honestly, I though it was overly verbose when I first read it,
but I like it better now, especially since it works;-)
I'll reply w/ an incremental patch.

> I suspect ACPI could now take the PM_SLEEP/SUSPEND/HIBERNATE details into 
> account, and that some of the code is not necessary when HIBERNATE is not 
> selected, for example, but I'm not at all sure that it's worth it being 
> very fine-grained.

As you know, I don't think that it is worth dedicated config options
to save 16KB on an SMP+ACPI kernel.  The prospect of adding code to
slice that 16KB into finer grain savings seems even less worthwhile.

-Len
