From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: x86: Increase PCIBIOS_MIN_IO to 0x1500 to fix nForce
 4 suspend-to-RAM
Date: Tue, 25 Dec 2007 23:13:16 -0600
Message-ID: <4771E2EC.7020407__1918.41925629905$1198646089$gmane$org@shaw.ca>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no>
	<200712251312.43478.carlos@strangeworlds.co.uk>
	<47713B2B.3000105@shaw.ca> <200712251926.51628.rjw@sisk.pl>
	<alpine.LFD.0.9999.0712252023290.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.0.9999.0712252023290.21557@woody.linux-foundation.org>
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
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
>> IMO, we should check which version of the specification we're supposed to
>> follow, on the basis of FADT contents, for example, and follow this one.
> 
> No, we should try to figure out what Windows does. *If* windows checks the 
> version, we should do that too. But we should absolutely *not* just assume 
> that the documentation is an accurate picture of reality.
> 
> Does anybody know how we could find out? 
> 
> 			Linus
> 

Well, it seems that if one had a checked (debug) build of Windows (or at 
least the acpi.sys driver) installed, as well as a copy of the Microsoft 
ASL compiler, they could compile and temporarily override the DSDT with 
a hacked one that would output what the device power states were in some 
fashion (maybe through the kernel debugger). Some info about this here:

http://download.microsoft.com/download/1/8/f/18f8cee2-0b64-41f2-893d-a6f2295b40c8/TW04015_WINHEC2004.ppt

I suspect that might require more Windows hacking skill and/or 
motivation than one might be likely to find on this list, though :-)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
