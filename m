From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Mon, 14 Jul 2008 22:10:41 +0200
Message-ID: <200807142210.43035.rjw__7693.53142609379$1216066464$gmane$org@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <200807132229.43140.rjw@sisk.pl>
	<487ABB81.8020100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <487ABB81.8020100@zytor.com>
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
> Rafael J. Wysocki wrote:
> > 
> > If s3_bios depends on the (invalid) contents of the hidden part of any segment
> > register, it's just terminally broken.
> > 
> 
> Depending on it being in Big Real Mode isn't all that broken, however, 
> especially on laptops where the vendor has control over the system 
> BIOS/video BIOS.
> 
> Enabling BRM by default *shouldn't* break anything, so it might be what 
> we want to do anyway.

Agreed.
