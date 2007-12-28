From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Suspend code ordering (again)
Date: Thu, 27 Dec 2007 18:25:53 -0600
Message-ID: <47744291.30100__844.123893375759$1198801654$gmane$org@shaw.ca>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no>
	<fa.XycBwhGuyvtVl/QW5HONqLwOags@ifi.uio.no> <4773E9EE.40107@shaw.ca>
	<200712272100.20282.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200712272100.20282.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
>> Also, as was pointed out, pre-Vista versions of Windows follow ACPI 1.0 
>> and Vista follows 3.0, so 2.0 doesn't really matter since BIOS people 
>> won't test against it. 1.0 specifies that _PTS is to be called before 
>> suspending devices and 3.0 says that the AML must not depend on any 
>> specific device power state, so in both cases it should be safe to call 
>> _PTS before suspending, no?
> 
> Well, IMO, if we take one option only (whichever that is) and there are systems
> that follow the other one, they will likely break.
> 
> Apart from this, there are BIOSes that openly claim ACPI 2.0 support (for
> example, the one in my HP nx6325 does that) and they may actually prefer the
> post-ACPI-1.0 ordering even if they work with the pre-ACPI-2.0 one.

I doubt they would prefer the later ordering in any way that matters, if 
the Windows version they were designed for uses the earlier ordering.

It would be best if somebody could manage to find out what ordering 
Windows XP (and Windows Vista, for good measure) actually use, then we 
could just use that. Virtual machine trickery might be an option - the 
only complication being that it'll be using the DSDT for the fake 
machine and not the real one..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
