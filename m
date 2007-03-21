From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] rework pm_ops pm_disk_mode, kill misuse
Date: Thu, 22 Mar 2007 00:45:54 +0100
Message-ID: <20070321234554.GC6060@elf.ucw.cz>
References: <20070321145328.496614000@sipsolutions.net>
	<20070321145420.910171000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070321145420.910171000@sipsolutions.net>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> The pm_ops.pm_disk_mode is used in totally bogus ways since
> nobody really seems to understand what it actually does.

Well, I believe me and Rafael understand it by now...

> ACPI is the only user left with a non-zero pm_disk_mode.
> =

> The patch also sets the default mode to shutdown again, but
> when a new pm_ops is registered its pm_disk_mode is selected
> as default, that way the default stays for ACPI where it is
> apparently required.

Ok.

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@lists.linux-foundation.org

ACK, not 2.6.21 material.
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
