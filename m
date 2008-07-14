From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Mon, 14 Jul 2008 22:09:53 +0200
Message-ID: <200807142209.54841.rjw__25862.2371162803$1216066325$gmane$org@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <487A67C3.50000@zytor.com>
	<487AD37A.2050903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <487AD37A.2050903@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@myrealbox.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of July 2008, H. Peter Anvin wrote:
> H. Peter Anvin wrote:
> > 
> > The most likely explanation for this is that the VESA BIOS expects to be 
> > entered in Big Real Mode (*.limit = 0xffffffff) instead of ordinary Real 
> > Mode.  Here is a completely untested patch which changes the segment 
> > descriptors to Big Real Mode instead.  It would be worth testing out.
> > 
> 
> ... and here is one that actually has a prayer of actually working.

It works on my box and if that's the same as the one you attached to the
Bugzilla entry, it has also been reported to work on an X61s.

Thanks,
Rafael
