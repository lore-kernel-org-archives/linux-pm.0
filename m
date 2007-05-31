From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH -mm] Freezer: migration_thread should not be freezable
	(was: Re: Re: 2.6.22-rc3-mm1)
Date: Thu, 31 May 2007 23:45:17 +0200
Message-ID: <6bffcb0e0705311445o40eb54bbr318b71d3113ff37b@mail.gmail.com>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<465EE9F2.8080905@googlemail.com> <200705312158.26560.rjw@sisk.pl>
	<200705312330.09157.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705312330.09157.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 31/05/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, 31 May 2007 21:58, Rafael J. Wysocki wrote:
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
>
> Ahem, I broke it. :-(
>
> Andrew, the following fix is needed on top of
> freezer-make-kernel-threads-nonfreezable-by-default.patch
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> migration_thread should not be freezable, or it will break hibernation =
and
> suspend on SMP.
>

Problem fixed, suspend to disk works fine. Huge thanks!

Regards,
Michal

--=20
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
