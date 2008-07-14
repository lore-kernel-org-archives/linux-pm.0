From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Mon, 14 Jul 2008 09:39:16 +0200
Message-ID: <20080714073916.GC1796__39776.6507616781$1216021389$gmane$org@elf.ucw.cz>
References: <200807010148.02135.rjw@sisk.pl> <487A2431.2050103@myrealbox.com>
	<487A4CB7.1080001@firstfloor.org> <200807132115.08230.rjw@sisk.pl>
	<487A617B.80707@firstfloor.org> <487A67C3.50000@zytor.com>
	<487AD37A.2050903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <487AD37A.2050903@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@myrealbox.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-07-13 21:18:02, H. Peter Anvin wrote:
> H. Peter Anvin wrote:
>>
>> The most likely explanation for this is that the VESA BIOS expects to be 
>> entered in Big Real Mode (*.limit = 0xffffffff) instead of ordinary Real 
>> Mode.  Here is a completely untested patch which changes the segment 
>> descriptors to Big Real Mode instead.  It would be worth testing out.
>>
>
> ... and here is one that actually has a prayer of actually working.

I tried 2.6.26, but it does not seem to be broken here :-(. Thinkpad
x60. So it does not seem _all_ thinkpads have this problem... 

									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
