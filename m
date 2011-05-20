From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Fri, 20 May 2011 17:43:41 +0200
Message-ID: <20110520154341.GL31426__34902.2056944252$1305908072$gmane$org@htj.dyndns.org>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
	<10124.1305906020@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <10124.1305906020@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Valdis.Kletnieks@vt.edu
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Michael Leun <lkml20100708@newton.leun.net>
List-Id: linux-pm@vger.kernel.org

On Fri, May 20, 2011 at 11:40:20AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 18 May 2011 17:14:56 PDT, Jian Peng said:
> 
> > > @@ -1353,6 +1332,8 @@
> > >
> > >
> > >   ahci_start_engine(ap);
> > >
> > > + msleep(5);
> > > +
> > >   if (online)
> > >
> > >    *class = ahci_dev_classify(ap);
> > >
> 
> It may very well be that adding a magic msleep(5) here just Makes It Work, but
> I have a gut feeling that it's in the wrong place (for starters, 'online' can't change
> during the msleep() unless somebody *else* sets it - in which case the locking
> is screwed up as we're not forcing a re-read of the value).  The msleep() probably
> needs to be before something else further down in the code (but I have no idea
> exactly what).

At this point, I think it would be better to simply add a flag and
enable the check for the affected controller.

Thanks.

-- 
tejun
