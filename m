From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Suspend code ordering (again)
Date: Thu, 27 Dec 2007 21:41:32 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712272138110.21557@woody.linux-foundation.org>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no>
	<fa.XycBwhGuyvtVl/QW5HONqLwOags@ifi.uio.no>
	<4773E9EE.40107@shaw.ca> <200712272100.20282.rjw@sisk.pl>
	<47744291.30100@shaw.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47744291.30100@shaw.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Thu, 27 Dec 2007, Robert Hancock wrote:
> 
> I doubt they would prefer the later ordering in any way that matters, if the
> Windows version they were designed for uses the earlier ordering.

Well, I wouldn't say it's abotu "preferring" one over the other. It's very 
possible that the BIOS writers were *intending* to prefer ACPI 2.0, and it 
may even be likely that they thought that they wrote it that way, but the 
real issue is that it has apparently never ever been *tested* that way.

So yes, maybe the vendors actually thought they were a good ACPI-2.0 
implementation, but if Windows doesn't do the ordering that the 2.0 spec 
expects, then that is pretty much just a theoretical thing.

But yeah, it would be really nice to have this verified some way. Somebody 
must already know (whether it's a VM person or a BIOS writer, and whether 
they'd tell us, is obviously another issue).

		Linus
