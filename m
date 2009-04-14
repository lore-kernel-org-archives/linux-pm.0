From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
	(minor but annoying) audio problem
Date: Tue, 14 Apr 2009 23:12:33 +0200
Message-ID: <200904142312.33833.rjw__43754.9210539602$1239743927$gmane$org@sisk.pl>
References: <200904100057.43827.rjw@sisk.pl> <s5hzlej308a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s5hzlej308a.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 14 April 2009, Takashi Iwai wrote:
> At Fri, 10 Apr 2009 00:57:41 +0200,
> Rafael J. Wysocki wrote:
> > 
> > Second, KDE4 on openSUSE 11.1 sometimes fails to handle audio correctly after
> > a fresh boot.  Everything seems to work, but there's no sound at all.  It is
> > sufficient to close the X session and start the desktop environment again to
> > make it work, though (may that be async too? ;-)).  The hardware in question is
> > Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller
> > (rev 02) and the driver is snd_hda_intel.
> 
> Is this problem still there?

Just a few minutes ago sound stopped working (that was after a resume from S3,
but not immediately after it), without anything suspicious in dmesg etc.
Restarting X fixed that.

Still, that doesn't happen very often and it is not readily reproducible.

> If restarting the X session fixes the problem, it could be a
> pulseaudio problem.  But, then it doesn't sound like a kernel update
> issue.

Well, that may be a pulseaudio problem, but the very same pulsaudio apparently
 worked well with 2.6.29-git<something>.  That might be a coincidence, though.
 
> Could you check whether non-PA environment (e.g. linux console) works
> reliably?

Yes, it appears to work.

Thanks,
Rafael
