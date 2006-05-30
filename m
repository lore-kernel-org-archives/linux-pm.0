From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc5-git 3/6] PM_EVENT_PRETHAW,
	handle in IDE and PCI
Date: Tue, 30 May 2006 19:21:08 +0000
Message-ID: <20060530192108.GA4044@ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
	<200606050938.23356.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606050938.23356.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> @@ -1227,7 +1227,9 @@ static int generic_ide_suspend(struct de
>  	rq.special =3D &args;
>  	rq.pm =3D &rqpm;
>  	rqpm.pm_step =3D ide_pm_state_start_suspend;
> -	rqpm.pm_state =3D state.event;
> +	if (mesg.event =3D=3D PM_EVENT_PRETHAW)
> +		mesg.event =3D PM_EVENT_FREEZE;
> +	rqpm.pm_state =3D mesg.event;
> =


Actually it would be nicer not to modify mesg.event... And perhaps I'd
move this check lower -- to be consistent with 'low level driver gets
full info' idea. (Or is it checked at too many places?)

-- =

Thanks for all the (sleeping) penguins.
