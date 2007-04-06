From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 6 Apr 2007 21:19:03 +0200
Message-ID: <20070406191903.GD2583@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1175852652.3489.67.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

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

And why do _you_ need it? Unfortunately I do not know what the
decrementer is...?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
