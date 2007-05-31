From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.22-rc3-mm1
Date: Thu, 31 May 2007 23:34:20 +0200
Message-ID: <200705312334.20834.rjw__27926.4017510743$1180646952$gmane$org@sisk.pl>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<200705312158.26560.rjw@sisk.pl>
	<6bffcb0e0705311425q2e00cc69j5006d95c3f0df158@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6bffcb0e0705311425q2e00cc69j5006d95c3f0df158@mail.gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 31 May 2007 23:25, Michal Piotrowski wrote:
> On 31/05/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, 31 May 2007 17:29, Michal Piotrowski wrote:
> > > Hi,
> > >
> > > Andrew Morton napisa=B3(a):
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6=
.22-rc3/2.6.22-rc3-mm1/
> > > >
> > >
> > > FYI suspend to disk doesn't work anymore on my box, system hangs af=
ter "Suspending console(s)" message.
> > >
> > > [  186.297753] Shrinking memory...  =08-=08\=08|=08/=08-=08\=08|=08=
done (113064 pages freed)
> > > [  187.841914] Freed 452256 kbytes in 1.54 seconds (293.67 MB/s)
> > > [  187.847730] Suspending console(s)
> > >
> > > http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.22-rc3=
-mm1/console.log
> > > http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.22-rc3=
-mm1/mm-config
> >
> > Hmm, that might be a couple of things, actually.
> >
> > To see if the patches directly related to hibernation/suspend cause t=
his, can
> > you please test 2.6.22-rc3 with the patch series at
> >
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/
> >
> > applied?
>=20
> Ok, bug is in suspend tree.

Yup.  Please see the message I've just sent (with a fix).

Rafael
