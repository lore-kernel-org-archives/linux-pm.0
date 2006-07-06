From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Thu, 6 Jul 2006 22:55:08 +0200
Message-ID: <200607062255.08540.rjw@sisk.pl>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607061626.53761.rjw@sisk.pl>
	<200607061344.43314.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607061344.43314.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 06 July 2006 22:44, David Brownell wrote:
> =

> > > Of course it needs fixing ... it's a bug, also a regression.
> > > =

> > > My question is where to fix...
> > =

> > Well, I meant replacing the memcpy() in copy_data_pages with an open co=
ded
> > copying loop.  That should be enough to fix the problem.
> =

> One like this?  Yes, it works.

Heh, I've just sent my own version. ;-)

> The slower speed shouldn't be much of an issue here.

Yup.  On my system it's hardly noticeable.

> (Though I'm glad that something in RC1 has gotten rid of that slowdown in
> reading/writing snapshots.)

Er, that's nothing in swsusp AFAICT.  (Or maybe the default value of image_=
size
is now different.  Anyway you can change it using /sys/power/image_size.)

Rafael
