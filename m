From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.38-rc3-git1: Reported regressions 2.6.36 ->
	2.6.37
Date: Thu, 3 Feb 2011 17:11:14 -0800
Message-ID: <AANLkTin-9a5Z3qq4t8UakRvgB1G3_CT2RLKMVaHXvnLr__6866.11546339027$1296782054$gmane$org@mail.gmail.com>
References: <e9vOd5LzdBK.A.dyD.h6eSNB@chimera>
	<AANLkTikELiGS+fM5WguZS=Fo-sSXmej1UnKWqCFmnE0k@mail.gmail.com>
	<s5haaid3xos.wl%tiwai@suse.de> <201102032009.17100.rjw@sisk.pl>
	<AANLkTi=suS1VDL=6EtT0D2=0c1DWwxdwZBBv=-BySNX-@mail.gmail.com>
	<AANLkTi=7EOih=fY5FCvhQbewSc=3a49cYVaKJRWM+-3d@mail.gmail.com>
	<AANLkTin7kBur95H=UBcYEcjYsUkrdG8znX-7PFZ4rrHf@mail.gmail.com>
	<AANLkTimQPPDyBwkN0HWM2+bPcbzVd8YHZvn2iR8MVzfL@mail.gmail.com>
	<yund3n88v7x.fsf@aiko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <yund3n88v7x.fsf@aiko.keithp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Keith Packard <keithp@keithp.com>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Carlos Mafra <crmafra2@gmail.com>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Network Development <netdev@vger.kernel.org>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Dave Airlie <airlied@gmail.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 3, 2011 at 5:05 PM, Keith Packard <keithp@keithp.com> wrote:
>
> The goal is to make it so that when you *do* set a mode, DPMS gets set
> to ON (as the monitor will actually be "on" at that point). Here's a
> patch which does the DPMS_ON precisely when setting a mode.

Ok, patch looks sane, but it does leave me with the "what about the
'fb_changed' case?" question. Is that case basically guaranteed to not
change any existing dpms state?

> (note, this patch compiles, but is otherwise only lightly tested).

Carlos? Takashi? Ignore my crazy patch, try this one instead. Does it
fix things for you?

                      Linus
