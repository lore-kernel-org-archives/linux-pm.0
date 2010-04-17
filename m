From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] Sound not transferred to docking
	station after resume from StR
Date: Sat, 17 Apr 2010 11:06:22 +0200
Message-ID: <201004171106.23787.elendil__42346.4885833257$1271495274$gmane$org@planet.nl>
References: <201004162131.19171.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004162131.19171.elendil@planet.nl>
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
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@lists.linux-foundation.org, alsa-devel@alsa-project.org
List-Id: linux-pm@vger.kernel.org

On Friday 16 April 2010, Frans Pop wrote:
> Scenario:
> - suspend laptop while *un*docked, i.e. with laptop speakers in use
> - dock laptop
> - resume
>
> With 2.6.33 and earlier the sound would always come from the external
> speakers connected to the docking station. But with 2.6.34-rc4 I get
> sound still coming from the laptop's internal speakers, which is not
> correct.

The problem is slightly different than I thought. Turns out *both* the
internal (laptop) and external (docking station) speakers are active after
the resume. So the problem is that the internal speakers are not switched off.

I have traced this to an ALSA merge: 524df55725217. Unfortunately I get
boot failures when I try to bisect down into that merge.

Here's the bisect log:
# bad: [0d0fb0f9c5fddef4a10242fe3337f00f528a3099] Linux 2.6.34-rc4
# good: [724e6d3fe8003c3f60bf404bf22e4e331327c596] Linux 2.6.33-rc8
git bisect start 'v2.6.34-rc4' 'v2.6.33-rc8'
# bad: [94468080220162f74dc6ce5c3e95e5fec8022902]
  Merge git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty-2.6
git bisect bad 94468080220162f74dc6ce5c3e95e5fec8022902
# bad: [524df55725217b13d5a232fb5badb5846418ea0e] Merge branch 'for-linus'
  of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
git bisect bad 524df55725217b13d5a232fb5badb5846418ea0e
# good: [0f4533979473a456a8adb3869365e12c7a99cf65]
  Merge branches 'futexes-for-linus', 'irq-core-for-linus' and
  'bkl-drivers-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
git bisect good 0f4533979473a456a8adb3869365e12c7a99cf65

Cheers,
FJP
