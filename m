From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sat, 6 Dec 2008 22:00:59 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812062157590.3425__32777.2340192043$1228629984$gmane$org@nehalem.linux-foundation.org>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<200812062236.44111.rjw@sisk.pl>
	<alpine.LFD.2.00.0812061420190.3425@nehalem.linux-foundation.org>
	<20081206152545.326c8b67@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081206152545.326c8b67@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 6 Dec 2008, Arjan van de Ven wrote:
> 
> the problem is that the system bios can have reassigned interrupts
> after resume, and afaik we need to re-evaluate the ACPI methods to
> get the new mapping.
> So we need to unregister + re-register to make that happen

Can you give actual examples of real life situations?

Because quite frankly, it sounds less and less likely for any relevant 
hardware. It's a non-issue for MSI, for example. And it's a non-issue for 
any sane interrupt source I can think of.

In other words, I've heard that claim before - and I just don't believe 
it. I've never heard a realistic explanation of why it would happen for a 
normal PCI driver. And I still claim that it's a very odd and special case 
if it does.

And btw, I'm talking suspend, not hibernate. 

			Linus
