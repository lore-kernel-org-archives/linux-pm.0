From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: 3.2-rc2+: Reported regressions from 3.0 and 3.1
Date: Mon, 21 Nov 2011 14:29:02 -0800
Message-ID: <CALCETrX-GS+R3jZXURSk0=8rvNK_X2XzkMF+age+TbPmwENt-w__5670.73851493678$1321933380$gmane$org@mail.gmail.com>
References: <lx6sezwGldO.A.IhF.UBpWOB@chimera> <201111212249.31196.rjw@sisk.pl>
	<CA+55aFygSFt+O5KLoiE_0V+o45eKfsoDDV5ML8EF=J0n9z_D-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFygSFt+O5KLoiE_0V+o45eKfsoDDV5ML8EF=J0n9z_D-Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2011 at 2:18 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 21, 2011 at 1:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>
>> Subject =A0 =A0: hugetlb oops on 3.1.0-rc8-devel
>> Submitter =A0: Andy Lutomirski <luto@amacapital.net>
>> Date =A0 =A0 =A0 : 2011-11-01 22:20
>> Message-ID : CALCETrW1mpVCz2tO5roaz1r6vnno+srHR-dHA6_pkRi2qiCfdw@mail.gm=
ail.com
>> References : http://marc.info/?l=3Dlinux-kernel&m=3D132018604426692&w=3D2
>
> Despite the subject line, that's not an oops, it's a BUG_ON().
>
> And it *should* be fixed by commit ea4039a34c4c ("hugetlb: release
> pages in the error path of hugetlb_cow()") although I don't think Andy
> ever confirmed that (since it was hard to trigger).

I haven't seen it again, but that probably doesn't mean anything.
I've also fixed a bug in some userspace software I was running, and
that fix means I'm probably not stressing that part of the kernel
anymore.  (Even without the fix, it took two weeks to hit this.)
