From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/3] xen: use freeze/restore/thaw
 PM events for suspend/resume/chkpt
Date: Tue, 22 Feb 2011 17:36:38 -0500
Message-ID: <20110222223638.GA1341__47308.4474950612$1298476621$gmane$org@dumpdata.com>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
	<1298157158-5421-3-git-send-email-rshriram@cs.ubc.ca>
	<20110222204320.GB4605@dumpdata.com>
	<AANLkTikrUUG92vQS_ZkdKCZ_+1BahQfAhRB-=8eNNW2o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikrUUG92vQS_ZkdKCZ_+1BahQfAhRB-=8eNNW2o@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

> > Could we just make CONFIG_XEN_SAVE_RESTORE depend on CONFIG_HIBERANTION?
> > Like this:
> >
> >
> > diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> > index 5b54892..838e20c 100644
> > --- a/arch/x86/xen/Kconfig
> > +++ b/arch/x86/xen/Kconfig
> > @@ -38,7 +38,7 @@ config XEN_MAX_DOMAIN_MEMORY
> >
> > =A0config XEN_SAVE_RESTORE
> > =A0 =A0 =A0 =A0bool
> > - =A0 =A0 =A0 depends on XEN && PM
> > + =A0 =A0 =A0 depends on XEN && PM && HIBERNATION
> > =A0 =A0 =A0 =A0default y
> >
> > =A0config XEN_DEBUG_FS
> >
> >
> On that aspect, just noticed
> config PM_SLEEP
>         bool
>         depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
>         default y
> we could get rid of XEN_SAVE_RESTORE as the suspend/resume code doesnt
> depend on PM_SLEEP

OK. Do you want to respin patch #2 without the #ifdefs in the drivers/base/=
...
and provide a new patch (#4?) which will alter the Kconfig file appropriate=
ly?
