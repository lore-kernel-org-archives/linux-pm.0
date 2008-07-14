From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sun, 13 Jul 2008 22:22:06 -0300
Message-ID: <20080714012206.GA11882__38260.1456171416$1215998745$gmane$org@khazad-dum.debian.net>
References: <200807010148.02135.rjw@sisk.pl> <200807122253.32382.rjw@sisk.pl>
	<48793A0E.3050803@myrealbox.com> <200807130133.12324.rjw@sisk.pl>
	<20080713091524.GA29907@elte.hu>
	<20080713120253.GA27582@srcf.ucam.org>
	<487A2431.2050103@myrealbox.com>
	<487A4CB7.1080001@firstfloor.org> <487A62B3.8010207@zytor.com>
	<487A63D2.9040006@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <487A63D2.9040006@firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 13 Jul 2008, Andi Kleen wrote:
> It probably switches to protected mode. I noticed this on my old
> Fujitsu laptop when I tried to make the S3 wakeup run in the s2ram x86 emulator
> and found it entered protected mode at some point, which x86emu
> didn't support.
> 
> I guess Lenovo is doing the same.
> 
> And that protected mode code relies on some GDT values that have been
> loaded earlier when the BIOS also went into protected mode.
> 
> It seems the BIOS programmers really don't like real mode anymore.
> Somehow understandable.

If it were just Lenovo, it shouldn't be too difficult to get them to fix the
BIOS.  But since other vendors have the same problem, that won't fly as a
solution.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
