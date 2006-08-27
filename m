From: Ikhwan Lee <ikhwan.lee@samsung.com>
Subject: Re: Voltage/power domain framework?
Date: Sun, 27 Aug 2006 20:48:01 +0900
Message-ID: <00c701c6c9ce$a721bd50$4686190c@dsn.sec.samsung.com>
References: <mailman.2682.1156469445.1142.linux-pm@lists.osdl.org>
	<002101c6c81b$2c61ffd0$4686190c@dsn.sec.samsung.com>
	<20060825180017.GA7636@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: mgross@linux.intel.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Thanks for your note,

> > I've seen quite a few discussions mentioning the necessity of
voltage/power
> > domain framework. Is there any project going on? I heard that there were
> > some activities by Nokia, but I could not find any on the web.
>
> There isn't anything formal going on.  However; there is a loose
> collection of folks working on the "operating point" patches with an eye
> to defining a lower level interface to enable voltage/power/clock domain
> framework's.

I have been following the threads on both PowerOp and OpPoint; however, I
never thought they would do the job of voltage/power/clock domain
frameworks. The way I interpreted is that they _need_ the domain frameworks
so that they could handle lower-level physics better.

> Do you have some design ideas, patches,  or requirements in this area that
could be
> taken into account?

I have requirements and some very rough ideas. And I was searching for an
existing implementation or a discussion so that I can find a place to start
with. Maybe we can start by writing down the requirements. As far as I know,
the CELF PM Requirement document does not have a section for voltage/power
domain frameworks.

Regards,
Ikhwan
