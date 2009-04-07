From: "Trenton D. Adams" <trenton.d.adams@gmail.com>
Subject: Re: 2.6.29-git13: Reported regressions from 2.6.28
Date: Tue, 7 Apr 2009 10:44:37 -0600
Message-ID: <9b1675090904070944m798ed608i1d9194ebd1ed3961__17494.4897684783$1239123012$gmane$org@mail.gmail.com>
References: <n4io5wq70ZO.A.gzG.rFn2JB@chimera>
	<alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
	<49DB7C77.1000702@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49DB7C77.1000702@s5r6.in-berlin.de>
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 7, 2009 at 10:16 AM, Stefan Richter
<stefanr@s5r6.in-berlin.de> wrote:
> Linus Torvalds wrote:
>> On Mon, 6 Apr 2009, Rafael J. Wysocki wrote:
>>> Bug-Entry =A0 =A0: http://bugzilla.kernel.org/show_bug.cgi?id=3D13018
>>> Subject =A0 =A0 =A0 =A0 =A0 =A0 =A0: 2.6.29 on MacBook 2,1 fails to reb=
oot
>>> Submitter =A0 =A0: Trenton Adams <trenton.d.adams@gmail.com>
>>> Date =A0 =A0 =A0 =A0 : 2009-03-30 2:04 (8 days old)
>>> References =A0 : http://marc.info/?l=3Dlinux-kernel&m=3D123837870307249=
&w=3D4
>>> Handled-By =A0 : "Morten P.D. Stevens" <mstevens@win-professional.com>
>>
>
> Trenton,
> could it be the same as this one?
> http://bugzilla.kernel.org/show_bug.cgi?id=3D12321
> "System hangs when unloading alsa modules"
> http://bugs.gentoo.org/show_bug.cgi?id=3D253535
> "System hangs when unloading alsa modules on Kernel >2.6.28"
> --
> Stefan Richter
> -=3D=3D=3D=3D=3D-=3D=3D--=3D -=3D-- --=3D=3D=3D
> http://arcgraph.de/sr/
>

The first one looks similar, if not identical.  The second one
doesn't, because my problem happens on 2.6.29 only, not 2.6.28.
Either way, the unload problem with the module didn't happen in
2.6.28.
