From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ottawa
Date: Fri, 11 Mar 2005 20:08:31 -0500
Message-ID: <1110589712.12485.262.camel@localhost.localdomain>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002F2271A@hdsmsx401.amr.corp.intel.com>
	<1110542934.5810.94.camel@gaston>
	<Pine.LNX.4.50.0503111258490.19793-100000@monsoon.he.net>
	<1110585295.5752.126.camel@gaston>
	<20050311170827.07daf488@cosmic.amd.com>
	<1110587382.5752.144.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7081715949344094=="
In-Reply-To: <1110587382.5752.144.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============7081715949344094==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-03-12 at 11:29 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2005-03-11 at 17:08 -0700, Jordan Crouse wrote:
> > On Sat, 12 Mar 2005 10:54:55 +1100
> > "Benjamin Herrenschmidt" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> wrote:
> > 
> > > > On that note, no matter where we have it, I'd like to limit it to
> > > > 6-8 people, with at most maybe 10. I don't wish to exclude anyone,
> > > > but I think that smaller groups can remain more focused. Plus,
> > > > there's all those sociological studies that say 6-7 people is the
> > > > optimal size for a discussion group. :)
> > > 
> > > Us, Nigel, David Brownell, Alan, Pavel, Brown, we are already 7... ?
> > 
> > Are there any logical divisions of area of interest that could result in
> > multiple productive meetings? 
> 
> Not sure. There are 2 different "main" areas, which are the global
> system suspend/resume, and the "local" or "dynamic" power management of
> devices & busses. We have a good solution for the first, but not for the
> second at this point, so I would expect that we concentrate on that
> part.
> 
> Plus some always-pending issues for global suspend, the biggest one
> beeing video chips that need a re-POST on wakeup.
> 
> Ben.

Under the topic of dynamic power management, there are a few logical
divisions of interest:

1.) Low-level - providing the bus support and facilities for higher
level power management (ex. the current work I'm doing with the PCI bus
driver).  Also support for power domains might fall under this category.

2.) Driver state and driver relationships - logical vs. physical, driver
API, threading power management to transition multiple devices at once,
etc

3.) Power Management Policy - determining which behavior to take for
various classes of devices, how to determine idleness etc., and how to
control/monitor those devices.

4.) Userspace - how to notify of power changes, how to allow the user to
control power management.

Anything else?

Thanks,
Adam



--===============7081715949344094==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============7081715949344094==--
