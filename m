From: krzysztof.h1@poczta.fm
Subject: Re: =?utf-8?q?commit_66c1ca_breaks_fbdev_mode_switching?=
Date: 07 Apr 2009 08:11:36 +0200
Message-ID: <20090407061136.E94711BAC63__31754.1351578713$1239085001$gmane$org@f42.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Andrea Righi napisa=B3(a):
> On Mon, Apr 06, 2009 at 08:47:18PM +0200, Krzysztof Helt wrote:
> > Hi,
> > =

> > The commit 66c1ca breaks fbdev mode switching. The first mode
> > (selected with mode_option or during boot) is ok but every mode
> > switch with fbset locks up computer. If the commit is reverted
> > mode switching works correctly.
> > =

> > I do not understand why. I would be grateful if someone else
> > can confirm the problem as well.
> > =

> > The commit&#039;s details are:
> > =

> > commit 66c1ca019078220dc1bf968f2bb18421100ef147
> > Author: Andrea Righi >righi.andrea@gmail.com>
> > Date:   Tue Mar 31 15:25:18 2009 -0700
> > =

> >     fbmem: fix fb_info->lock and mm->mmap_sem circular locking
> dependency
> >     =

> > =

> > Regards,
> > Krzysztof
> =

> Any lockdep info or oops? it just locks up the system?
> =


It just locked up. I can try with more debug info enabled.

Regards,
Krzysztof

----------------------------------------------------------------------
10% zysku na lokacie bankowej z gwarancja BFG. Sprawdz!
http://link.interia.pl/f20fd
