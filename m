From: David Brownell <david-b@pacbell.net>
Subject: Re: Linux 2.6.21-rc6
Date: Sun, 15 Apr 2007 10:53:56 -0700
Message-ID: <200704151053.56939.david-b@pacbell.net>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704150814.01747.david-b@pacbell.net>
	<200704151837.40756.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704151837.40756.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Adrian Bunk <bunk@stusta.de>, linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>
List-Id: linux-pm@vger.kernel.org

On Sunday 15 April 2007 9:37 am, Rafael J. Wysocki wrote:
> =

> Which makes me think the following patch might help:
> =

>  drivers/input/serio/i8042.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> Index: linux-2.6.21-rc6/drivers/input/serio/i8042.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-rc6.orig/drivers/input/serio/i8042.c	2007-04-07 12:15:19=
.000000000 +0200
> +++ linux-2.6.21-rc6/drivers/input/serio/i8042.c	2007-04-15 18:30:01.0000=
00000 +0200
> @@ -846,7 +846,8 @@ static long i8042_panic_blink(long count
>  static int i8042_suspend(struct platform_device *dev, pm_message_t state)
>  {
>  	if (dev->dev.power.power_state.event !=3D state.event) {
> -		if (state.event =3D=3D PM_EVENT_SUSPEND)
> +		if (state.event =3D=3D PM_EVENT_SUSPEND
> +		    || state.event =3D=3D PM_EVENT_PRETHAW)

Yeah, lack of PRETHAW support could be an issue.  As you may recall,
it was added because otherwise statically linked USB host controllers
came up under the mistaken belief that they were getting a real resume
event rather than a restart-after-power-off ... and there needed to be
a way to force a hard reset.  Seems like a similar issue here.

- Dave


>  			i8042_controller_reset();
>  =

>  		dev->dev.power.power_state =3D state;
> =
