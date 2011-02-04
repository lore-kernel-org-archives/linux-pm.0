From: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.38-rc3-git1: Reported regressions 2.6.36 ->
	2.6.37
Date: Fri, 4 Feb 2011 10:06:19 +1000
Message-ID: <AANLkTin7kBur95H=UBcYEcjYsUkrdG8znX-7PFZ4rrHf__35658.8823291988$1296778063$gmane$org@mail.gmail.com>
References: <e9vOd5LzdBK.A.dyD.h6eSNB@chimera>
	<AANLkTikELiGS+fM5WguZS=Fo-sSXmej1UnKWqCFmnE0k@mail.gmail.com>
	<s5haaid3xos.wl%tiwai@suse.de> <201102032009.17100.rjw@sisk.pl>
	<AANLkTi=suS1VDL=6EtT0D2=0c1DWwxdwZBBv=-BySNX-@mail.gmail.com>
	<AANLkTi=7EOih=fY5FCvhQbewSc=3a49cYVaKJRWM+-3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=7EOih=fY5FCvhQbewSc=3a49cYVaKJRWM+-3d@mail.gmail.com>
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
Cc: Keith Packard <keithp@keithp.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Carlos Mafra <crmafra2@gmail.com>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Network Development <netdev@vger.kernel.org>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 4, 2011 at 8:10 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 3, 2011 at 1:56 PM, Carlos Mafra <crmafra2@gmail.com> wrote:
>>>
>>> I added https://bugzilla.kernel.org/show_bug.cgi?id=3D24982 to the list=
 of
>>> post-2.6.36 regressions for further tracking.
>>
>> I also tested on 2.6.38-rc3+ now and the issue is not solved,
>> just like Takashi expected.
>
> Hmm. That commit (bf9dc102e284) still reverts cleanly.
>
> Keith, Dave, should we just revert it? It's definitely a regression,
> and we do _not_ allow "fixes" to one thing that just causes a
> regression to another.
>
> Quite frankly, I think it's totally wrong to just blindly set DPMS
> status to ON like that. It's as wrong as it was to leave it off, and
> the regressions reported are basically mirror images of the exact same
> bug that that commit tried to fix.
>
> IOW, the commit message says:
>
> =A0 =A0When setting a new crtc configuration, force the DPMS state of all
> =A0 =A0connectors to ON. Otherwise, they'll be left at OFF and a future m=
ode set
> =A0 =A0that disables the specified connector will not turn the connector =
off.
>
> but setting it to ON doesn't actually _fix_ anything, because you just
> get the exact same issue in reverse, ie you just get
>
> =A0 .. and a future mode set =A0that ENables the specified connector will
> =A0 =A0not turn the connector ON.

If we are setting a mode on a connector it automatically will end up
in a DPMS on state,
so this seemed correct from what I can see.

A future mode set shouldn't ever not turn the connector on, since
modesetting is an implicit
DPMS,

It sounds like something more subtle than that, though I'm happy to
revert this for now, and let Keith
think about it a bit more.

Dave.
