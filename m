From: "Trenton D. Adams" <trenton.d.adams@gmail.com>
Subject: Re: 2.6.29 on MacBook 2,
	1 fails to reboot (was Re: 2.6.29-git13: Reported regressions from
	2.6.28)
Date: Tue, 7 Apr 2009 12:22:01 -0600
Message-ID: <9b1675090904071122k6a53295fwfffc336011edee8e__24560.75754385$1239128756$gmane$org@mail.gmail.com>
References: <n4io5wq70ZO.A.gzG.rFn2JB@chimera>
	<alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
	<49DB7C77.1000702@s5r6.in-berlin.de>
	<9b1675090904070944m798ed608i1d9194ebd1ed3961@mail.gmail.com>
	<49DB8909.3000905@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49DB8909.3000905@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 7, 2009 at 11:10 AM, Stefan Richter
<stefanr@s5r6.in-berlin.de> wrote:
> Trenton D. Adams wrote:
> Interdependencies between ALSA modules have changed. =A0The Gentoo init
> scripts attempted to unload them in an order which deadlocked modprobe
> due to dependencies. =A0The fix for Gentoo is to just not unload the
> modules on system shutdown. =A0My Gentoo/amd64 Mac mini was affected by
> this too; fixed by userland update.
>

While that is interesting, I am not seeing that problem on my Gentoo
box (the macbook), which is completely up-to-date.  2.6.28 works, and
2.6.29 doesn't.  Same init scripts, different kernels.

And sure, I could put a comment on the rmmod, in the init script, but
IMO that would be a hack around a _bug_.  Which is fine for me.  But,
is it worth leaving the issue in the kernel?
