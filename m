From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 6 Apr 2007 11:41:31 +0200
Message-ID: <200704061141.31677.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175849322.3489.64.camel@johannes.berg>
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

On Friday, 6 April 2007 10:48, Johannes Berg wrote:
> On Fri, 2007-04-06 at 02:17 +0200, Rafael J. Wysocki wrote:
> =

> > > Not sure, it might be different for different suspend methods. We
> > > actually need to do some platform-function stuff inbetween, and if we
> > > ever want some S4-like state then we might need to do it differently.
> > =

> > Ah, OK
> =

> Keep in mind that I don't know that yet, and am not totally sure I ever
> will implement something S4-like (it would probably require kexec or
> similar tricks). Also, these handlers are not even called fro the
> suspend to disk case right now (and documented that way.)
> =

> I will repost with some BUG_ON() assertions, but should I change it to
> have 4 handlers before_irq_off/after_irq_off/before_irq_on/after_irq_on
> instead of the two I have now?

Frankly, I'm not sure.

For practical purposes the BUG_ON() assertions will suffice, so I think you
can keep the two handlers.  I'd change the names, though, to something
like quiesce() and activate(), for example.

[Hm, it feels more appropriate to define them for all platforms and make th=
em
call local_irq_save() on the platforms that don't need to do anything more.]

BTW, please remember to update the SNAPSHOT_S2RAM ioctl accordingly (well,
I think we should move the common code to a separate function).

Greetings,
Rafael
