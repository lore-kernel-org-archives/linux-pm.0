From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 21 Feb 2009 21:20:35 +0100
Message-ID: <200902212120.37684.rjw__43333.8107461624$1235247808$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200902211047.26787.rjw@sisk.pl>
	<d6200be20902210232m71700247k8914ca3735563881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902210232m71700247k8914ca3735563881@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Feb 21, 2009 at 1:47 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> On Fri, Feb 20, 2009 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> >> On Fri, Feb 20, 2009 at 7:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wr=
ote:
> >> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> >> >> On Fri, Feb 20, 2009 at 2:49 AM, Rafael J. Wysocki <rjw@sisk.pl>=
 wrote:
> >> >> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> >> >> >> On Thu, Feb 19, 2009 at 2:08 PM, Alan Stern <stern@rowland.ha=
rvard.edu> wrote:
[--snip--]
> >> > The idea is to have both /sys/power/state and /sys/power/sleep at th=
e same
> >> > time, where /sys/power/state will work just like it does right now. =
 Sure,
> >> > there must be mutual exclusion between the two, but that's a matter =
of
> >> > implementation IMO.
> >>
> >> If you want to only prevent suspend though one interface, you have to
> >> also pass information to the driver about its suspend hook is being
> >> called so it can conditionally return -EBUSY. The wakelock interface
> >> requires less code in each driver.
> >
> > Well, I don't think so.  Moreover, it requires you to spread wakelocks =
all
> > over the place if you don't use the timeouted ones which, let's face it=
, is
> > hardly acceptable.
> =

> Your method does not reduce the number of places that has to be
> modified. Any component where we add a wakelock, you have to add a
> suspend handler to abort suspend when we would have held a wakelock.

Well, maybe not, but it doesn't introduce entirely new API for device drive=
rs.
Instead, it extends the existing interfaces which I think is more appropria=
te.

Thanks,
Rafael
