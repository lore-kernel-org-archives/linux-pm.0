From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFT] solve "swsusp plays yoyo" with disks
Date: Thu, 21 Jul 2005 21:20:15 +0200
Message-ID: <20050721192015.GA6367@atrey.karlin.mff.cuni.cz>
References: <20050705172953.GA18748@elf.ucw.cz>
	<42DFAD1C.80004@stud.feec.vutbr.cz>
	<42DFBFA8.5060800@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76646342536138201=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <42DFBFA8.5060800@stud.feec.vutbr.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============76646342536138201==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi!

> >>I'd like to get this tested under as many configurations as
> >>possible. With this, your hdd should no longer do "yoyo" (spindown,
> >>spinup, spindown) during suspend...
> >
> >
> >It looks like the patch is now in -mm (I use 2.6.13-rc3-mm1).
> >But my disks still yoyo during suspend. What more is needed? Some patch 
> >to ide-disk.c ?
> 
> I think I've found the problem.
> The attached patch stops the disks from spinning down and up on suspend.
> The patch applies to 2.6.13-rc3-mm1.
> 
> Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

Thanks, applied, I'll eventually propagate it.

							Pavel

> diff -Nurp -X dontdiff.new linux-mm/drivers/ide/ide-io.c linux-mm.mich/drivers/ide/ide-io.c
> --- linux-mm/drivers/ide/ide-io.c	2005-06-30 01:00:53.000000000 +0200
> +++ linux-mm.mich/drivers/ide/ide-io.c	2005-07-21 16:59:46.000000000 +0200
> @@ -150,7 +150,7 @@ static void ide_complete_power_step(ide_
>  
>  	switch (rq->pm->pm_step) {
>  	case ide_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
> -		if (rq->pm->pm_state == 4)
> +		if (rq->pm->pm_state == PM_EVENT_FREEZE)
>  			rq->pm->pm_step = ide_pm_state_completed;
>  		else
>  			rq->pm->pm_step = idedisk_pm_standby;


-- 
Boycott Kodak -- for their patent abuse against Java.

--===============76646342536138201==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76646342536138201==--
