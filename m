From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 11 Aug 2010 04:11:38 +0200
Message-ID: <201008110411.38382.rjw__37.2560498819396$1281492873$gmane$org@sisk.pl>
References: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
	<201008100453.11958.rjw@sisk.pl>
	<AANLkTi=UApkc7_qeeXikP7kAnYW2TOXvVQu91UiBr2LV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=UApkc7_qeeXikP7kAnYW2TOXvVQu91UiBr2LV@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 10, 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/8/9 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Monday, August 09, 2010, Arve Hj=F8nnev=E5g wrote:
...
> =

> > Anyway, as I said I'm not opposed to the idea of using a special type of
> > objects for collecting debug information on wakeup events, so please fr=
ee to
> > submit patches modifying the current mainline kernel code in that direc=
tion.
> >
> =

> How do you prefer to handle your pci wakeup events? Add a handle to
> every device or pci device? Or use a global handle to avoid the race
> and report wakeup events for debugging separately?

The latter, maybe?

Thanks,
Rafael
