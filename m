From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 11:15:20 -0700
Message-ID: <200606231115.21265.david-b@pacbell.net>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
	<20060622235100.GA4940@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060622235100.GA4940@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


> > The Mac Mini was the first machine when I decided to try using netconso=
le. =

> > And I did so because it didn't work for me even before. It just so =

> > happened that netconsole actually made things EVEN WORSE.
> > =

> > The other machines I've tried (without netconsole) haven't resumed eith=
er.
> =

> Well... here's list of machines we got to work (from suspend.sf.net
> project):

Doesn't it seem wrong to _everyone_ else that making a basic
kernel mechanism like "echo ... >/sys/power/state" work, some
out of tree code appears to be needed?

- Dave
