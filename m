From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp status report
Date: Tue, 25 Jul 2006 21:39:10 +0200
Message-ID: <200607252139.10356.rjw@sisk.pl>
References: <200607251325.14747.rjw@sisk.pl>
	<20060725151145.GG14964@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060725151145.GG14964@redhat.com>
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
To: Dave Jones <davej@redhat.com>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 July 2006 17:11, Dave Jones wrote:
> On Tue, Jul 25, 2006 at 01:25:14PM +0200, Rafael J. Wysocki wrote:
> =

>  > V. Freeing memory
>  > =

>  > Step (3) of the suspend procedure is completed by calling the same
>  > functions that are normally used by kswapd, but in a slightly differen=
t way.
>  > The part of swsusp responsible for that is referred to as 'the memory
>  > shrinker' and it may sometimes be called by the suspend-to-RAM code as=
 well
> =

> This isn't actually necessary though is it ?
> (Ie, it's a bug that needs fixing?)

Well, that depends on what FREE_PAGE_NUMBER, as defined in
kernel/power/main.c, is for.  Someone probably knows.
[I'm tempted to remove it, though. ;-) ]

> Good write-up btw, it may even be a nice addition to Documentation/power/=
  ?

I'm going to update the existing docs soon, so it probably won't be needed.
Still I think we can make it available from suspend.sf.net.

Rafael
