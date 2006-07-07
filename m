From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Fri, 7 Jul 2006 10:20:16 +0200
Message-ID: <200607071020.16213.rjw@sisk.pl>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607062318.55787.rjw@sisk.pl>
	<20060706220612.GC30500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060706220612.GC30500@redhat.com>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 07 July 2006 00:06, Dave Jones wrote:
> On Thu, Jul 06, 2006 at 11:18:55PM +0200, Rafael J. Wysocki wrote:
>  > On Thursday 06 July 2006 23:07, David Brownell wrote:
>  > > On Thursday 06 July 2006 2:01 pm, Dave Jones wrote:
>  > > =

>  > > > Why not just use __memcpy instead? Which should be safe on all arc=
hs
>  > > > to do the simplest possible memcpy.
>  > > =

>  > > Or __constant_memcpy(...PAGE_SIZE) ?  :)
>  > =

>  > Is __memcpy() defined on all architectures?  Eg. ppc?
> =

> Seems not.  __constant_memcpy is a gcc built-in though isn't it ?

Well, I'm not sure.  i386 and sparc define it explicitly.

Rafael
