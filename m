From: Mark Gross <mgross@linux.intel.com>
Subject: Re: Voltage/power domain framework?
Date: Mon, 28 Aug 2006 13:24:46 -0700
Message-ID: <20060828202446.GA26848@linux.intel.com>
References: <mailman.2682.1156469445.1142.linux-pm@lists.osdl.org>
	<002101c6c81b$2c61ffd0$4686190c@dsn.sec.samsung.com>
	<20060825180017.GA7636@linux.intel.com>
	<00c701c6c9ce$a721bd50$4686190c@dsn.sec.samsung.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <00c701c6c9ce$a721bd50$4686190c@dsn.sec.samsung.com>
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

On Sun, Aug 27, 2006 at 08:48:01PM +0900, Ikhwan Lee wrote:
> Thanks for your note,
> =

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
> =

> I have been following the threads on both PowerOp and OpPoint; however, I
> never thought they would do the job of voltage/power/clock domain
> frameworks. The way I interpreted is that they _need_ the domain framewor=
ks
> so that they could handle lower-level physics better.
> =

> > Do you have some design ideas, patches,  or requirements in this area t=
hat
> could be
> > taken into account?
> =

> I have requirements and some very rough ideas. And I was searching for an
> existing implementation or a discussion so that I can find a place to sta=
rt
> with. Maybe we can start by writing down the requirements. As far as I kn=
ow,
> the CELF PM Requirement document does not have a section for voltage/power
> domain frameworks.

If you provide me with content then I would be happy to add such a
section or welcome you to edit the public wiki yourself ;)

--mgross
