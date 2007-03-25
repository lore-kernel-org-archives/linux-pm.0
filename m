From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power management: force pm_ops.valid
	callback to be assigned
Date: Sun, 25 Mar 2007 16:30:58 +0000
Message-ID: <20070325163058.GA9958@ucw.cz>
References: <1174571042.32051.2.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174571042.32051.2.camel@johannes.berg>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch changes the docs and behaviour from "all states valid" to
> "no states valid" if no .valid callback is assigned. Users of pm_ops
> that only need mem sleep can assign pm_valid_only_mem without any
> overhead, others will require more elaborate callbacks.
> =

> Now that all users of pm_ops have a .valid callback this is a safe
> thing to do and prevents things from getting messy again as they
> were before.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: linux-pm@lists.linux-foundation.org

ACK.
						Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
