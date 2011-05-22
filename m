From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Sat, 21 May 2011 19:00:26 -0700
Message-ID: <BANLkTimnfJmMWmSkFiehNeE95z7kxgeQPw__22431.0341327966$1306029701$gmane$org@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
	<10124.1305906020@localhost>
	<20110520154341.GL31426@htj.dyndns.org>
	<BANLkTi=iNjWsaYCJqP057FkhAXtab5nS=Q@mail.gmail.com>
	<17610.1305915959@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <17610.1305915959@localhost>
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
Cc: Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

HI, Valdis,

This patch is on top of reverted patch 81ca7e4. So you should not
revert 81ca7e4 before applying this new one.

Best regards,
Jian

On Fri, May 20, 2011 at 11:25 AM, <Valdis.Kletnieks@vt.edu> wrote:
>
> On Fri, 20 May 2011 10:02:56 PDT, Jian Peng said:
> > --20cf307f38f6d842a904a3b81730
>
> > You are both right that adding this majic 5ms delay at this place shoul=
d not
> > be the final solution.
> >
> > If this magic 5ms delay works on other affected systems, I plan to post=
 a
> > new patch that inside ahci_start_engine(), still perform same check, and
> > show warning message if failed, but will set a flag, then still set STA=
RT
> > bit, and if there is such failure flag, add 5ms delay.
> >
> > Valdis, could you apply the following patch and retest it?
>
> I should be able to do that this weekend. =A0To clarify - should this be =
with the
> problem commit 270dac35c26433d06a89150c51e75ca0181ca7e4 applied, or rever=
ted?
>
