From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sysdev suspend/resume
Date: Wed, 27 Jul 2005 11:40:57 +0200
Message-ID: <20050727094057.GC4270@elf.ucw.cz>
References: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
	<20050726101409.GA1950@openzaurus.ucw.cz>
	<1122454220.7414.3.camel@linux-hp.sh.intel.com>
	<20050727090748.GB4270@elf.ucw.cz>
	<1122456610.3000.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77478420659861635=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1122456610.3000.5.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============77478420659861635==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > +#define SYSDEV_RESUME(cls, dev, drv)			\
> > > +	/* First, call the class-specific one */ 	\
> > > +	if (cls->resume)				\
> > > +		cls->resume(dev);			\
> > > +							\
> > > +	/* Call auxillary drivers next. */ 		\
> > > +	list_for_each_entry(drv, &cls->drivers, entry) {\
> > > +		if (drv->resume) 			\
> > > +			drv->resume(dev); 		\
> > > +	}						\
> > > +							\
> > > +	/* Call global drivers. */			\
> > > +	list_for_each_entry(drv, &sysdev_drivers, entry) {\
> > > +		if (drv->resume)			\
> > > +			drv->resume(dev);		\
> > > +	}
> > 
> > Are you sure you are resuming already-resumed devices?
> What's your point? if sysdev_suspend failed, sysdev_resume isn't called,
> so it will not be resumed twice.

Probably nothing then, sorry for noise.
									Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.

--===============77478420659861635==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77478420659861635==--
