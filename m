From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 32-bit user suspend program on 64-bit kernel?
Date: Wed, 21 Mar 2007 15:17:19 +0100
Message-ID: <200703211517.20297.rjw@sisk.pl>
References: <1174468281.3769.7.camel@johannes.berg>
	<200703211505.52812.rjw@sisk.pl>
	<1174485879.4230.36.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174485879.4230.36.camel@johannes.berg>
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

On Wednesday, 21 March 2007 15:04, Johannes Berg wrote:
> On Wed, 2007-03-21 at 15:05 +0100, Rafael J. Wysocki wrote:
> =

> > Unfortunately the numbers of ioctls are not portable due to my rookie m=
istake
> > in the beginning (using void * in _IOW() and friends which passed with =
no
> > objections).
> > =

> > I'm ashamed of that, but it's probably too late to fix it. :-(
> =

> Bugger. What would be required to fix it?

Well, the change itself wouldn't be big (three #defines or so), but it would
break all of the existing setups.

Alternatively, we can add some ioctls that duplicate those with nonportable
numbers and tell people to use the new ones in the future (documentation
changes would be needed).

Greetings,
Rafael
