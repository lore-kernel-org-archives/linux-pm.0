From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 13:29:54 +0100
Message-ID: <20070321122954.GO4520@elf.ucw.cz>
References: <1174468981.3769.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174468981.3769.8.camel@johannes.berg>
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

> This patch introduces /sys/power/disk_powerdown_mode and
> deprecates /sys/power/disk. The former has the advantages
>  * a much more expressive name
>  * contains all valid modes as well as the selected one
>    in a fashion known from the LED subsystem.
> =

> The disk attribute is scheduled for removal, but since there
> are no disadvantages in keeping we give it plenty of time.

Does it really need to be this complex? Maybe we can disply change
/sys/power/disk format? Is the change required at all?
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
