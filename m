From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Mon, 14 Jul 2008 02:31:25 +0100
Message-ID: <20080714013125.GA3681__24185.5986569592$1215999212$gmane$org@srcf.ucam.org>
References: <200807010148.02135.rjw@sisk.pl> <487A2431.2050103@myrealbox.com>
	<487A4CB7.1080001@firstfloor.org> <200807132115.08230.rjw@sisk.pl>
	<487A617B.80707@firstfloor.org> <487A67C3.50000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <487A67C3.50000@zytor.com>
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

On Sun, Jul 13, 2008 at 01:38:27PM -0700, H. Peter Anvin wrote:

> The most likely explanation for this is that the VESA BIOS expects to be 
> entered in Big Real Mode (*.limit = 0xffffffff) instead of ordinary Real 
> Mode.  Here is a completely untested patch which changes the segment 
> descriptors to Big Real Mode instead.  It would be worth testing out.

Recent Lenovo BIOSes will read from somewhere just under the 4GB 
boundary if the video BIOS is called, so this sounds likely. 
Unfortunately my T61 is, uh, unhappy right now, so I can't test this.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
