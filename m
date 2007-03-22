From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] power management: change /sys/power/disk
	display
Date: Thu, 22 Mar 2007 22:45:00 +0100
Message-ID: <200703222245.01300.rjw@sisk.pl>
References: <1174468981.3769.8.camel@johannes.berg>
	<1174482773.4230.19.camel@johannes.berg>
	<1174574051.3588.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174574051.3588.5.camel@johannes.berg>
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

On Thursday, 22 March 2007 15:34, Johannes Berg wrote:
> This patch changes /sys/power/disk to display all valid modes
> as well as the currently selected one in a fashion known from
> the LED subsystem.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

No objections from me.

> ---
> This patch is the simplified version that just changes the attribute
> instead of introducing a new on. It also contains the relevant updates
> to the documentation.
> =

> Good to push for .22?

Well, I think it can go to -mm for now (if Pavel agrees with it).  Later we=
'll
decide whether it should go into .22 or .23.

Greetings,
Rafael
