From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Runtime PM discussion notes
Date: Tue, 28 Jun 2011 13:47:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106281346160.2874__23901.0417288684$1309291939$gmane$org@utopia.booyaka.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201106232234.21930.rjw@sisk.pl>
	<alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
	<BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-293461756-1309290467=:2874"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-293461756-1309290467=:2874
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Arve,

On Fri, 24 Jun 2011, Arve Hj=F8nnev=E5g wrote:

> On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > As I understand it, in the original Android implementation, the hardwar=
e
> > that they were using didn't have fine-grained power management. =A0So
> > system-wide suspend made more sense in that context. =A0But that should=
n't
> > be confused with the modern rationale for wakelocks:
> >
> > https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.h=
tml
> >
> > "On the hardware that shipped we enter the same power state from idle
> > and suspend, so the only power savings we get from suspend that we
> > don't get in idle is from not respecting the scheduler and timers."
> >
>=20
> This is no longer the case. Both the Nexus-S and Xoom enter lower
> power states from suspend than idle.

Just out of curiosity, is that due to some kind of hardware limitation on=
=20
those platforms, or is it because the software infrastructure for dynamic=
=20
deep idle hasn't been fully implemented in that subarchitecture code?


- Paul
--155748971-293461756-1309290467=:2874
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-293461756-1309290467=:2874--
