From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.38-rc3-git1: Reported regressions 2.6.36 ->
	2.6.37
Date: Thu, 3 Feb 2011 14:19:31 -0800
Message-ID: <AANLkTin=YcecPX1AOpihPVJO3UOfrcjf0MFTu55dpEUy__12529.996087733$1296771745$gmane$org@mail.gmail.com>
References: <e9vOd5LzdBK.A.dyD.h6eSNB@chimera>
	<AANLkTikELiGS+fM5WguZS=Fo-sSXmej1UnKWqCFmnE0k@mail.gmail.com>
	<s5haaid3xos.wl%tiwai@suse.de> <201102032009.17100.rjw@sisk.pl>
	<AANLkTi=suS1VDL=6EtT0D2=0c1DWwxdwZBBv=-BySNX-@mail.gmail.com>
	<AANLkTi=7EOih=fY5FCvhQbewSc=3a49cYVaKJRWM+-3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Carlos Mafra <crmafra2@gmail.com>, Keith Packard <keithp@keithp.com>, Dave Airlie <airlied@redhat.com>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 3, 2011 at 2:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe the right thing to do is to set it to 'unknown', something like this.
>
> TOTALLY UNTESTED!

Doing some grepping and "git blame", I found this: commit 032d2a0d068
("drm/i915: Prevent double dpms on") which took a very similar
approach, except it just uses "-1" directly instead of introducing
that DRM_MODE_DPMS_UNKNOWN concept.

So I suspect that my patch is going in the right direction, and
judging by the comments in that commit, we probably should do this
correctly at the dri level rather than have drivers see those stupid
"let's set dpms to the state that it was already in". But that very
much does require that kind of "UNKNOWN" state option.

So maybe we can get that patch tested (and acked if it works)? Carlos, Takashi?

                         Linus
