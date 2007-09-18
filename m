From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: [3/3] 2.6.23-rc6: known regressions v2
Date: Tue, 18 Sep 2007 09:07:29 +0200
Message-ID: <1190099250.29236.4.camel__19709.0531969026$1190100578$gmane$org@localhost>
References: <46EB3EF8.6040103@googlemail.com>
	<200709172144.43761.arekm@maven.pl> <1190058463.2995.14.camel@chaos>
	<200709172251.07769.arekm@maven.pl>  <1190063028.2995.53.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190063028.2995.53.camel@chaos>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>, Thomas Voegtle <tv@lio96.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-09-17 at 23:03 +0200, Thomas Gleixner wrote:
> On Mon, 2007-09-17 at 22:51 +0200, Arkadiusz Miskiewicz wrote:
> > > >     clockevents: fix resume logic
> > >
> > > Linus pulled a series of patches which are addressing this issue into
> > > his tree yesterday. Can you please retest against current git ?
> > 
> > Looks like the problem is fixed in current git for me. Thanks!
> 
> Thanks for testing.

I can confirm that the problem is fixed for me too in current git when
using the free avivo driver (with the binary only fglrx driver the
machine just hangs on resume or even sometimes on sleep). So it might be
worth to purposely keep that such that people transit from fglrx to the
free avivo/radeonhd drivers. Anyway s2ram with avivo takes 2-3 sec to
suspend and 4-5 for resume (when fglrx worked it was more in the 10-20
secs).

Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
