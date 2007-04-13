From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:47:56 +0200
Message-ID: <200704140047.56677.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704140009.33298.rjw@sisk.pl>
	<1176503122.5764.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176503122.5764.109.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 00:25, Benjamin Herrenschmidt wrote:
> =

> > Hmm, I missed that. :-(
> > =

> > I think we need to make things clear: Either we add the additional hook=
s to
> > pm_ops in which case they should be taken into account in the (u)swsusp=
 code
> > too, or we don't add them at all.
> > =

> > Well, there also is one more solution.  Namely, we can add the hooks to=
 pm_ops
> > and make (u)swsusp use something else instead of pm_ops, but that would=
 require
> > some more consideration.
> =

> Well, what would be nice would be if swsusp wasn't just such a gross
> contraption completely bypassing the rest of the suspend/resume
> framework...

IMHO, swsusp is a really special case, especially when it doesn't use pm_op=
s.

On a PC it may look like a "typical" suspend/resume operation, but I think =
it
generally is not one.  Although we try to use as many pieces of the framewo=
rk
in swsusp as we can, we're still running into problems with that.  There are
just too many _practical_ differences.

Greetings,
Rafael
