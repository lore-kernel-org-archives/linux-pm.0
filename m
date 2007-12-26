From: Avi Kivity <avi@qumranet.com>
Subject: Re: x86: Increase PCIBIOS_MIN_IO to 0x1500 to fix nForce
	4 suspend-to-RAM
Date: Wed, 26 Dec 2007 09:23:25 +0200
Message-ID: <4772016D.30900__10758.235367439$1198781858$gmane$org@qumranet.com>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no>
	<200712251312.43478.carlos@strangeworlds.co.uk>
	<47713B2B.3000105@shaw.ca> <200712251926.51628.rjw@sisk.pl>
	<alpine.LFD.0.9999.0712252023290.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.9999.0712252023290.21557@woody.linux-foundation.org>
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
Cc: Robert Hancock <hancockr@shaw.ca>, Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
>
>> IMO, we should check which version of the specification we're supposed to
>> follow, on the basis of FADT contents, for example, and follow this one.
>>     
>
> No, we should try to figure out what Windows does. *If* windows checks the 
> version, we should do that too. But we should absolutely *not* just assume 
> that the documentation is an accurate picture of reality.
>
> Does anybody know how we could find out? 
>
>   

Run it in a virtual machine, with the ACPI methods of interest wired to
output to some port, and log that I/O port in the monitor/emulator.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
