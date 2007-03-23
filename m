From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power management: change /sys/power/disk
	display
Date: Fri, 23 Mar 2007 01:05:12 +0100
Message-ID: <20070323000512.GA8182@elf.ucw.cz>
References: <1174468981.3769.8.camel@johannes.berg>
	<20070321122954.GO4520@elf.ucw.cz>
	<1174480375.4230.12.camel@johannes.berg>
	<20070321131128.GB4523@elf.ucw.cz>
	<1174482773.4230.19.camel@johannes.berg>
	<1174574051.3588.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174574051.3588.5.camel@johannes.berg>
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

On Thu 2007-03-22 15:34:11, Johannes Berg wrote:
> This patch changes /sys/power/disk to display all valid modes
> as well as the currently selected one in a fashion known from
> the LED subsystem.

looks ok to me. It changes userland interface, but I believe noone
uses this particular detail.


> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

ack.

> ---
> This patch is the simplified version that just changes the attribute
> instead of introducing a new on. It also contains the relevant updates
> to the documentation.
> =

> Good to push for .22?

Actually, this may even be .23 material.

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
