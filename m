From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.38-rc3-git1: Reported regressions 2.6.36 ->
	2.6.37
Date: Thu, 3 Feb 2011 20:09:16 +0100
Message-ID: <201102032009.17100.rjw__12663.5782923133$1296760350$gmane$org@sisk.pl>
References: <e9vOd5LzdBK.A.dyD.h6eSNB@chimera>
	<AANLkTikELiGS+fM5WguZS=Fo-sSXmej1UnKWqCFmnE0k@mail.gmail.com>
	<s5haaid3xos.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s5haaid3xos.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Keith Packard <keithp@keithp.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Carlos R. Mafra" <crmafra2@gmail.com>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Network Development <netdev@vger.kernel.org>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 03, 2011, Takashi Iwai wrote:
> At Thu, 3 Feb 2011 07:42:05 -0800,
> Linus Torvalds wrote:
> > 
> > On Thu, Feb 3, 2011 at 3:23 AM, Carlos R. Mafra <crmafra2@gmail.com> wrote:
> > > On Thu  3.Feb'11 at  1:03:41 +0100, Rafael J. Wysocki wrote:
> > >>
> > >> If you know of any other unresolved post-2.6.36 regressions, please let us know
> > >> either and we'll add them to the list.  Also, please let us know if any
> > >> of the entries below are invalid.
> > >
> > > I'm sorry if I'm overlooking something, but as far as I can see the regression
> > > reported here:
> > >
> > > https://lkml.org/lkml/2011/1/24/457
> > >
> > > is not in the list (update on that report: reverting that commit on top of
> > > 2.6.37 fixes the issue).
> > 
> > Ok, added Keith and Dave to the cc, since they are the signers of that commit.
> > 
> > > After some time, I also ended up finding an earlier report in the kernel bugzilla
> > > which I think is the same regression (it was bisected to the same commit):
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=24982
> > >
> > > but I do not see it in the list either, even though it's marked as a
> > > regression in the bugzilla.
> > >
> > > The issue was also present in 2.6.38-rc2 last time I tested.
> > 
> > Just to confirm, can you also check -rc3? I'm pretty sure nothing has
> > changed, but there were a few drm patches after -rc2, so it's alsways
> > good to double-check.
> 
> The problem I reported in the bugzilla above is still present in
> 2.6.38-rc3.  I'm pretty sure that's the same issue as Carlos' case.

I added https://bugzilla.kernel.org/show_bug.cgi?id=24982 to the list of
post-2.6.36 regressions for further tracking.

Thanks,
Rafael
