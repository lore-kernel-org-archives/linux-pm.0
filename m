From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.21-rc1: T60 resume from suspend to RAM issues
Date: Tue, 27 Feb 2007 11:38:53 +0100
Message-ID: <20070227103853.GH6745__281.74933181635$1172572805$gmane$org@elf.ucw.cz>
References: <20070223020904.c8fc8a3e.akpm@linux-foundation.org>
	<20070224211141.GA4425@mellanox.co.il>
	<20070227101451.GA11981@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070227101451.GA11981@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org, mingo@redhat.com, len.brown@intel.com, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, bunk@stusta.de, linux-kernel@vger.kernel.org, linux-pm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> * Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> =

> > > > 2. As a separate test, I enabled DynTicks in .config. Seems to =

> > > > work fine but won't come out of suspend to memory at all: pressing =

> > > > Fn/F4 seems to have no effect.
> > > =

> > > Do you believe that the second problem was caused by dynticks?
> > =

> > Assuming these are 2 different problems, yes, the second one seems to =

> > be caused by dyntics.
> =

> on my T60 current -git does not resume even without dynticks. v2.6.20 =

> with the same .config resumes fine (except for the display).

See suspend.sf.net. s2ram is able to resume display for you, too.. as
should some command line parameter.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
