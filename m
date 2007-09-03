From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [4/4] 2.6.23-rc4: known regressions
Date: Mon, 3 Sep 2007 08:12:04 +0200
Message-ID: <200709030812.05460.arekm__46057.7377155007$1188800012$gmane$org@maven.pl>
References: <46D58CC6.4020605@googlemail.com>
	<1188470552.22467.8.camel@localhost>
	<6bffcb0e0709021533u1fd81db6pfb0d985d80f73995@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6bffcb0e0709021533u1fd81db6pfb0d985d80f73995@mail.gmail.com>
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
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 03 of September 2007, Michal Piotrowski wrote:
> Hi,
>
> On 30/08/07, Soeren Sonnenburg <kernel@nn7.de> wrote:
> > On Wed, 2007-08-29 at 17:27 +0200, Michal Piotrowski wrote:
> > > Power management
> > >
> > > Subject         : something broke resume from s2ram on mbp c1d (???=
 :))
> > > References      : http://lkml.org/lkml/2007/8/28/67
> > > Last known good : 2.6.23-rc3
> > > Submitter       : Soeren Sonnenburg <kernel@nn7.de>
> > > Caused-By       : ?
> > > Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> > > Status          : unknown
> > >
> > > Subject         : resume from ram much slower
> > > References      : http://lkml.org/lkml/2007/8/10/275
> > > Last known good : 2.6.23-rc1 ?
> > > Submitter       : Arkadiusz Miskiewicz <arekm@maven.pl>
> > > Caused-By       : ?
> > > Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> > > Status          : problem is being debugged
> >
> > I am not sure whether the problem I am having is not the very same as
> > the one Arkadiusz is seeing. At least I've found resume from s2ram to=
 be
> > working a couple of times. Only sometimes it took long to resume, tha=
t
> > is >30 seconds (around 5 - which I already consider long - is normal).
> >
> > anyway this this is with the closed source fglrx kernel module,
>
> Arkadiusz, are you using any of these binary crap modules?

No.

> Regards,
> Michal

ps. had no time to do bisecting

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
