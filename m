From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 13:25:17 +0100
Message-ID: <200703211325.17696.rjw@sisk.pl>
References: <1174468981.3769.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174468981.3769.8.camel@johannes.berg>
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

On Wednesday, 21 March 2007 10:23, Johannes Berg wrote:
> This patch introduces /sys/power/disk_powerdown_mode

I don't think this name is the right one too, since the platform mode is not
exactly the power down mode (let alone test and testproc).

> and deprecates /sys/power/disk. The former has the advantages
>  * a much more expressive name

Well, please choose another name (I'd probably use disk_mode or something
like that, but 'disk' is well-documented, so why change it?).

>  * contains all valid modes as well as the selected one
>    in a fashion known from the LED subsystem.

Pleases review the documentation under Documentation/power and
Documentation/ABI and update it in accordance with the changes you're makin=
g.

Greetings,
Rafael
