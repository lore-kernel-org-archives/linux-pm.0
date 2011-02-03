From: Carlos Mafra <crmafra2@gmail.com>
Subject: Re: 2.6.38-rc3-git1: Reported regressions 2.6.36 ->
	2.6.37
Date: Thu, 3 Feb 2011 22:56:29 +0100
Message-ID: <AANLkTi=suS1VDL=6EtT0D2=0c1DWwxdwZBBv=-BySNX-__17686.2017637633$1296833741$gmane$org@mail.gmail.com>
References: <e9vOd5LzdBK.A.dyD.h6eSNB@chimera>
	<AANLkTikELiGS+fM5WguZS=Fo-sSXmej1UnKWqCFmnE0k@mail.gmail.com>
	<s5haaid3xos.wl%tiwai@suse.de> <201102032009.17100.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102032009.17100.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Keith Packard <keithp@keithp.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 3, 2011 at 8:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, February 03, 2011, Takashi Iwai wrote:
>> At Thu, 3 Feb 2011 07:42:05 -0800,
>> Linus Torvalds wrote:
>> >
>> > On Thu, Feb 3, 2011 at 3:23 AM, Carlos R. Mafra <crmafra2@gmail.com> w=
rote:
>> > > On Thu =A03.Feb'11 at =A01:03:41 +0100, Rafael J. Wysocki wrote:

>> > Just to confirm, can you also check -rc3? I'm pretty sure nothing has
>> > changed, but there were a few drm patches after -rc2, so it's alsways
>> > good to double-check.
>>
>> The problem I reported in the bugzilla above is still present in
>> 2.6.38-rc3. =A0I'm pretty sure that's the same issue as Carlos' case.
>
> I added https://bugzilla.kernel.org/show_bug.cgi?id=3D24982 to the list of
> post-2.6.36 regressions for further tracking.

I also tested on 2.6.38-rc3+ now and the issue is not solved,
just like Takashi expected.
