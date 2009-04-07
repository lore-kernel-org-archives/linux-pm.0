From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: 2.6.29 on MacBook 2,
	1 fails to reboot (was Re: 2.6.29-git13: Reported regressions from
	2.6.28)
Date: Tue, 7 Apr 2009 10:20:37 -0700
Message-ID: <dd18b0c30904071020v4b4090d9o9721f2d892d9739c__10061.8123579354$1239125154$gmane$org@mail.gmail.com>
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
Cc: Adrian Bunk <bunk@kernel.org>, "Trenton D. Adams" <trenton.d.adams@gmail.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 7, 2009 at 10:10 AM, Stefan Richter
<stefanr@s5r6.in-berlin.de> wrote:
> Trenton D. Adams wrote:
>> On Tue, Apr 7, 2009 at 10:16 AM, Stefan Richter
>> <stefanr@s5r6.in-berlin.de> wrote:
>>> Linus Torvalds wrote:
>>>> On Mon, 6 Apr 2009, Rafael J. Wysocki wrote:
>>>>> Bug-Entry =A0 =A0: http://bugzilla.kernel.org/show_bug.cgi?id=3D13018
>>>>> Subject =A0 =A0 =A0 =A0 =A0 =A0 =A0: 2.6.29 on MacBook 2,1 fails to r=
eboot
> ...
>>>> The bug _sounds_ like some deadlock due to lock problems - the shutdown
>>>> path often triggers locks that no other path really cares about. And we
>>>> had some lock problems in the sound subsystem that got fixed post-2.6.=
28,
>>>> for example.
>>>>
>>>> And it looks like the problem is somewhere in sound shutdown:
>>>>
>>>> 12181 delete_module("snd_hda_codec", O_RDONLY|O_EXCL) =3D -1 EAGAIN (R=
esource temporarily unavailable) <0.000011>
>>>>
>>>> So commits like 91054598f794fb5d8a0b1e747ff8e2e8fc2115b3 ("ALSA: pcm_o=
ss,
>>>> fix locking typo") might explain it.
> ...
>>> could it be the same as this one?
>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D12321
>>> "System hangs when unloading alsa modules"
>>> http://bugs.gentoo.org/show_bug.cgi?id=3D253535
>>> "System hangs when unloading alsa modules on Kernel >2.6.28"
> ...
>> The first one looks similar, if not identical. =A0The second one
>> doesn't, because my problem happens on 2.6.29 only, not 2.6.28.
>
> The Gentoo bug entry too is about a regression _after_ 2.6.28. :-)
> I.e. 2.6.28.y. are unaffected. =A0It's actually just the downstream
> duplicate of the kernel.org bug entry.
>
>> Either way, the unload problem with the module didn't happen in
>> 2.6.28.
>
> Interdependencies between ALSA modules have changed. =A0The Gentoo init
> scripts attempted to unload them in an order which deadlocked modprobe
> due to dependencies. =A0The fix for Gentoo is to just not unload the
> modules on system shutdown. =A0My Gentoo/amd64 Mac mini was affected by
> this too; fixed by userland update.
>
> (Added Cc to tiwai@suse.de)
> --
> Stefan Richter
> -=3D=3D=3D=3D=3D-=3D-=3D=3D=3D -=3D-=3D -=3D=3D-=3D
> http://arcgraph.de/sr/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

With the imac(kernel 2.6.29)
/sbin/shutdown -h now   (works)
but
/sbin/reboot
hangs

-- =

Justin P. Mattock
