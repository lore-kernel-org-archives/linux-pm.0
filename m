From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [uclinux-dist-devel] freezer: should barriers be smp
 ?
Date: Fri, 15 Apr 2011 18:57:37 +0200
Message-ID: <20110415165737.GA23812__24948.5459215522$1302887315$gmane$org@elf.ucw.cz>
References: <BANLkTinj3y+-VhzFAPz8Gzb5vAbtUFU6Aw@mail.gmail.com>
	<Pine.LNX.4.44L0.1104131757430.2005-100000@iolanthe.rowland.org>
	<20110415162938.GA11454@atrey.karlin.mff.cuni.cz>
	<BANLkTikaymG-5-YoTnG2SPJCnBtXPpfHBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikaymG-5-YoTnG2SPJCnBtXPpfHBQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> >> The existing code is correct but it isn't optimal.
> >>
> >> wmb() and rmb() are heavy-duty operations, and you don't want to call
> >> them when they aren't needed. =A0That's exactly what smp_wmb() and
> >> smp_rmb() are for -- they call wmb() and rmb(), but only in SMP
> >> kernels.
> >>
> >> Unless you need to synchronize with another processor (not necessarily
> >> a CPU, it could be something embedded within a device), you should
> >> always use smp_wmb() and smp_rmb() rather than wmb() and rmb().
> >
> > Maybe; but this code is not performance critical and I believe being
> > obvious here is better...
> =

> isnt it though ?  especially when we talk about suspending/resuming on
> embedded systems to get more savings over just cpu idle ?  we want
> that latency to be as low as possible.

Feel free to measure the difference. I bet it is lost in noise,
freezer just is not _that_ hot path.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
