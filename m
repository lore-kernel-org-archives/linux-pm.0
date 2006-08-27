From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Voltage/power domain framework?
Date: Sun, 27 Aug 2006 11:50:47 -0700
Message-ID: <c55240ed0608271150s42d2098dv27fa5a28b5f402d4@mail.gmail.com>
References: <mailman.2682.1156469445.1142.linux-pm@lists.osdl.org>
	<002101c6c81b$2c61ffd0$4686190c@dsn.sec.samsung.com>
	<20060825180017.GA7636@linux.intel.com>
	<00c701c6c9ce$a721bd50$4686190c@dsn.sec.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <00c701c6c9ce$a721bd50$4686190c@dsn.sec.samsung.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ikhwan Lee <ikhwan.lee@samsung.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

2006/8/27, Ikhwan Lee <ikhwan.lee@samsung.com>:
> Thanks for your note,
>
> > > I've seen quite a few discussions mentioning the necessity of
> voltage/power
> > > domain framework. Is there any project going on? I heard that there w=
ere
> > > some activities by Nokia, but I could not find any on the web.
> >
> > There isn't anything formal going on.  However; there is a loose
> > collection of folks working on the "operating point" patches with an eye
> > to defining a lower level interface to enable voltage/power/clock domain
> > framework's.
>
> I have been following the threads on both PowerOp and OpPoint; however, I
> never thought they would do the job of voltage/power/clock domain
> frameworks. The way I interpreted is that they _need_ the domain framewor=
ks
> so that they could handle lower-level physics better.
OpPoint does not have any integration with voltage/clock framework
idea what is completely unaccepted considering the announced goals for
OpPoint.

Yes, clock/voltage framework is separate entity and PowerOP does not
do the job of clock/voltage framewrok because PowerOP is completely
different layer. But PowerOP is only a part of PM framework Matt and I
are proposing and PowerOP leverages clock/voltage framework as the
lowest layer in the PM framework - PowerOP sits on top of PM Core
while PM Core interacts directly with clock/voltage framework (please
see PM framework architecture picture overview in my patch set
postings).

Clock framework is implemented for omap1/2 arches and is utilized by
PM Core for omap in my previous posts of PowerOP.

Thanks,
Eugeny
> > Do you have some design ideas, patches,  or requirements in this area t=
hat
> could be
> > taken into account?
>
> I have requirements and some very rough ideas. And I was searching for an
> existing implementation or a discussion so that I can find a place to sta=
rt
> with. Maybe we can start by writing down the requirements. As far as I kn=
ow,
> the CELF PM Requirement document does not have a section for voltage/power
> domain frameworks.
>
> Regards,
> Ikhwan
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
