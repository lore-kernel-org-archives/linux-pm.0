From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:49:34 +0200
Message-ID: <200704140049.34981.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704140018.07367.rjw@sisk.pl>
	<1176502807.7052.136.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176502807.7052.136.camel@johannes.berg>
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
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 00:20, Johannes Berg wrote:
> On Sat, 2007-04-14 at 00:18 +0200, Rafael J. Wysocki wrote:
> =

> > Technically, they may be not needed by (u)swsusp, but since (u)swsusp a=
lready
> > uses pm_ops in the platform mode, it formally should use these new hook=
s in
> > the platform mode too.  =

> =

> Sure. I'll do that.
> =

> > Otherwise it won't make sense to use pm_ops in
> > (u)swsusp at all, IMHO.
> =

> IMHO it never has and never will be, it's just to make it all fit the
> ACPI model ;)

I'm not against changing that, as you might have noticed. :-)

Greetings,
Rafael
