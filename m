From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] power management: remove firmware disk
	mode
Date: Thu, 22 Mar 2007 00:49:50 +0100
Message-ID: <20070321234950.GD6060@elf.ucw.cz>
References: <20070321145328.496614000@sipsolutions.net>
	<20070321145421.528048000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070321145421.528048000@sipsolutions.net>
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

> This patch removes the firmware disk suspend mode which is the wrong
> approach, it is supposed to be used for implementing firmware-based disk
> suspend but cannot actually be used for that.

Actually, it _can_ be used for that. It worked... once, on machine I
no longer have and patch is lost anyway.

ACK.
								Pavel

>  5 files changed, 34 insertions(+), 54 deletions(-)
> =

> --- linux-2.6.orig/include/linux/pm.h	2007-03-21 15:44:54.663148946 +0100
> +++ linux-2.6/include/linux/pm.h	2007-03-21 15:45:04.403148946
                                                             ~~~~~~~~
								wow :-)



-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
