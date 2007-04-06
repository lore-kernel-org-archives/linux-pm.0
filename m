From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 6 Apr 2007 12:02:41 +0200
Message-ID: <200704061202.42069.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175852652.3489.67.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 6 April 2007 11:44, Johannes Berg wrote:
> On Fri, 2007-04-06 at 11:41 +0200, Rafael J. Wysocki wrote:
> =

> > Frankly, I'm not sure.
> > =

> > For practical purposes the BUG_ON() assertions will suffice, so I think=
 you
> > can keep the two handlers.  I'd change the names, though, to something
> > like quiesce() and activate(), for example.
> =

> Sure.
> =

> > [Hm, it feels more appropriate to define them for all platforms and mak=
e them
> > call local_irq_save() on the platforms that don't need to do anything m=
ore.]
> =

> Is there much point in that? It seems to make implementing new pm_ops a
> bit more complex seeing that nobody but us seems to require such a thing
> yet.

That's why I said "it feels". :-)

Still, we can, for example, define default_quiesce() and default_activate()
that will only call local_irq_save/restore() to be used by the architectures
that don't need anything more etc.

Greetings,
Rafael
