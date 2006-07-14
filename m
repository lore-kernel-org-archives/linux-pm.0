From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Rt-tester makes freezing processes fail.
Date: Fri, 14 Jul 2006 10:17:27 +0200
Message-ID: <200607141017.27832.rjw@sisk.pl>
References: <200607140918.49040.nigel@suspend2.net>
	<20060713163743.e71975b0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060713163743.e71975b0.akpm@osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, tglx@timesys.com, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 14 July 2006 01:37, Andrew Morton wrote:
> On Fri, 14 Jul 2006 09:18:43 +1000
> Nigel Cunningham <nigel@suspend2.net> wrote:
> =

> > Compiling in the rt-tester currently makes freezing processes fail.
> > I don't think there's anything wrong with it running during
> > suspending, so adding PF_NOFREEZE to the flags set seems to be the
> > right solution.
> > =

> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > =

> >  rtmutex-tester.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > diff -ruNp 9971-rt-tester.patch-old/kernel/rtmutex-tester.c 9971-rt-tes=
ter.patch-new/kernel/rtmutex-tester.c
> > --- 9971-rt-tester.patch-old/kernel/rtmutex-tester.c	2006-07-07 10:27:4=
6.000000000 +1000
> > +++ 9971-rt-tester.patch-new/kernel/rtmutex-tester.c	2006-07-14 07:48:0=
1.000000000 +1000
> > @@ -259,7 +259,7 @@ static int test_func(void *data)
> >  	struct test_thread_data *td =3D data;
> >  	int ret;
> >  =

> > -	current->flags |=3D PF_MUTEX_TESTER;
> > +	current->flags |=3D PF_MUTEX_TESTER | PF_NOFREEZE;
> >  	allow_signal(SIGHUP);
> >  =

> >  	for(;;) {
> =

> =

> I yesterday queued up the below patch.  Which approach is most appropriat=
e?

I prefer the one that makes these threads freeze (ie. the Luca's patch).

Greetings,
Rafael
