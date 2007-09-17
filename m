From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [3/3] 2.6.23-rc6: known regressions v2
Date: Mon, 17 Sep 2007 23:03:48 +0200
Message-ID: <1190063028.2995.53.camel__8662.26052535257$1190063120$gmane$org@chaos>
References: <46EB3EF8.6040103@googlemail.com>
	<200709172144.43761.arekm@maven.pl> <1190058463.2995.14.camel@chaos>
	<200709172251.07769.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709172251.07769.arekm@maven.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Thomas Voegtle <tv@lio96.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-09-17 at 22:51 +0200, Arkadiusz Miskiewicz wrote:
> > >     clockevents: fix resume logic
> >
> > Linus pulled a series of patches which are addressing this issue into
> > his tree yesterday. Can you please retest against current git ?
> 
> Looks like the problem is fixed in current git for me. Thanks!

Thanks for testing.

> ps. The description about vaio not resuming without key pressing matches what 
> I was seeing here on thinkpad z60m, too.

Sigh, there were several subtle reason why you would need to press keys
during resume. The one you are referring to is the one which is the most
obscure. It would be nice if you could revert that particular one and
check whether it still works on your box.

	tglx
