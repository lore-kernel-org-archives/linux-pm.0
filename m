From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: 2.6.35-rc4-git3: Reported regressions from 2.6.34
Date: Fri, 9 Jul 2010 04:04:42 +0200
Message-ID: <20100709020440.GJ6405__46950.3218461343$1278641242$gmane$org@nowhere>
References: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
	<AANLkTiknnzWyVpqnPCpyiEVHLgkewd0zaGzLInABRe2G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiknnzWyVpqnPCpyiEVHLgkewd0zaGzLInABRe2G@mail.gmail.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Patrick McHardy <kaber@trash.net>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "David S. Miller" <davem@davemloft.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Shawn Starr <shawn.starr@rogers.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 08, 2010 at 06:34:25PM -0700, Linus Torvalds wrote:
> On Thu, Jul 8, 2010 at 4:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16=
284
> > Subject =A0 =A0 =A0 =A0 : Hitting WARN_ON in hw_breakpoint code
> > Submitter =A0 =A0 =A0 : Paul Mackerras <paulus@samba.org>
> > Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-23 12:57 (16 days old)
> > Message-ID =A0 =A0 =A0: <20100623125740.GA3368@brick.ozlabs.ibm.com>
> > References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D12772978=
9113432&w=3D2
> =

> This has "I have a fix, will post it very soon." in the thread from
> Frederic, but I'm not seeing anything else. Frederic?



Right. In fact it wasn't a regression. The per task breakpoint reservation
design was broken from the beginning and this warning has revealed the
problem. This only touched perf, and it did since perf support breakpoints.
Fortunately ptrace wasn't concerned by this problem, even not by side effec=
ts
of this.

The fix is invasive as it's a rewrite of a (little) part of the breakpoint
reservation. And since the symptom is only a warning and also breakpoints
never released from the constraint table (just a counter, no memory leak),
the fix is headed for 2.6.36.

It is ready in tip:/perf/core:

http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.git;a=3Dcommi=
tdiff;h=3D45a73372efe4a63f44aa2e1125d4a777c2fdc8d8

I think this ticket can be safely closed.

Thanks.
