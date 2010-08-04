From: Florian Mickler <florian@mickler.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 09:35:11 +0200
Message-ID: <20100804093511.616e47b9__43872.274485375$1280907374$gmane$org@schatten.dmk.lab>
References: <20100801210548.23f77ff6@infradead.org>
	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>
	<20100802140933.GB2405@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>
	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>
	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
	<alpine.DEB.2.00.1008022203470.6545@asgard.lang.hm>
	<AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>
	<alpine.DEB.2.00.1008031611100.6545@asgard.lang.hm>
	<20100804001015.GJ2407@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008031723530.6545@asgard.lang.hm>
	<AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
	<alpine.DEB.2.00.1008032111350.25170@asgard.lang.hm>
	<AANLkTi=O++qfY7zz5rErqWQn0n4Tj7dfxQNcytjwiP4q@mail.gmail.com>
	<alpine.DEB.2.00.1008032312440.25170@asgard.lang.hm>
	<AANLkTikyD94wqWZTWA23K=zvN3RpKB6dDRrvFSv9szMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikyD94wqWZTWA23K=zvN3RpKB6dDRrvFSv9szMg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, Arjan@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Aug 2010 00:10:21 -0700
Arve Hj=F8nnev=E5g <arve@android.com> wrote:

> >
> > you are stating that this must be suspend because low-power idle must be
> > transparent to the user.
> =

> It must be transparent to the rest of the system.

Perhaps transparent is badly worded. Both suspend and idle are in some
way "transparent". Idle doesnt happen when an application is runnable.
Suspend is transparent in that the application can not easily detect if
it happened. =


Cheers,
Flo
