From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 27 Apr 2006 00:24:14 +0200
Message-ID: <200604270024.15651.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net>
	<200604261326.15853.rjw@sisk.pl>
	<200604261431.44137.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604261431.44137.david-b@pacbell.net>
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
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 April 2006 23:31, David Brownell wrote:
> On Wednesday 26 April 2006 4:26 am, Rafael J. Wysocki wrote:
> > On Wednesday 26 April 2006 00:56, David Brownell wrote:
> 
> > > But it's not the root cause of the problem either.  The same problem appears if
> > > the device holding the resume partition gets forced into this "broken suspend"
> > > state.
> > 
> > Well, IMO the state may or may not be broken depending on the device,
> > so we should not assume it will always be broken.
> 
> Not so.  See my previous emails.  The "broken suspend" state is broken
> by definition.  Maybe you're referring to a different issue ... whether
> or not its driver would notice that bug.

It is a bug from your point of view, and I was referring to the fact that it
apparently doesn't matter for many drivers.

> > > Now, if you have specific examples of things that shouldn't be reset, that
> > > could be interesting.
> > 
> > The resume device and friends (ie. controller, bus, etc.).
> 
> Bad answer.  If its driver would notice, then it must be reset.
> And if the driver wouldn't notice, resetting won't matter.
> 
> There's still no example of a device that should not be reset
> (a second time).

OK, so I have no any.  Which doesn't seem to matter as far as your patch is
concerned, as Pavel doesn't like it anyway. ;-)

Greetings,
Rafael
