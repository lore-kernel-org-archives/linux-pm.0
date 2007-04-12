From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 09:32:41 -0700
Message-ID: <200704120932.41497.david-b@pacbell.net>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176377017.5764.15.camel@localhost.localdomain>
	<200704121703.16206.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704121703.16206.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 12 April 2007 8:03 am, Rafael J. Wysocki wrote:
> On Thursday, 12 April 2007 13:23, Benjamin Herrenschmidt wrote:

> > Why not give this added flexibility ? Archs who don't care don't need to
> > bother and it will make us happy... it's not like we are about to -add-
> > burden to other architectures.
> =

> Well, I think it would be reasonable to add the quiesce()/activate() hook=
s for
> all of the above reasons. =


Makes sense to me.  Though I'd rather see pm_set_ops() patch the default
hooks than expect all platforms to change ... that would shrink the size
of the patch adding these, as well as the potential cost of removing them.


> However, once we've done that, it'll be quite =

> difficult to remove them, so we should better be sure they are really rea=
lly
> needed and there's no other way to implement what you need (or all of the
> alternative ways are far worse).

In general I think too much of the way PM "works" now is a bit more
due to convenient side effects than by clear intent.  So while I agree
that adding hooks should be done with care, this one certain seems to
be a step in the right direction.

- Dave
