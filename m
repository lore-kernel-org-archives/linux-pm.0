From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 27 Apr 2006 12:44:21 -0700
Message-ID: <200604271244.22376.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604261431.44137.david-b@pacbell.net>
	<200604270024.15651.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11352918926319422=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604270024.15651.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============11352918926319422==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > > > But it's not the root cause of the problem either.  The same problem appears if
> > > > the device holding the resume partition gets forced into this "broken suspend"
> > > > state.
> > > 
> > > Well, IMO the state may or may not be broken depending on the device,
> > > so we should not assume it will always be broken.
> > 
> > Not so.  See my previous emails.  The "broken suspend" state is broken
> > by definition.  Maybe you're referring to a different issue ... whether
> > or not its driver would notice that bug.
> 
> It is a bug from your point of view, and I was referring to the fact that it
> apparently doesn't matter for many drivers.

That is, to "whether driver notices".  It's clearly a bug with respect to
how the FREEZE state is defined.  Not all drivers need to notice all bugs.

- Dave


--===============11352918926319422==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11352918926319422==--
