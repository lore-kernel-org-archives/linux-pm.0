From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.21-rc1: T60 resume from suspend to RAM issues
Date: Tue, 27 Feb 2007 13:33:08 +0200
Message-ID: <20070227113308.GE10548@mellanox.co.il>
References: <20070223020904.c8fc8a3e.akpm@linux-foundation.org>
	<20070224211141.GA4425@mellanox.co.il>
	<20070227101451.GA11981@elte.hu>
	<20070227102809.GD10548@mellanox.co.il>
	<20070227110306.GE20927@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070227110306.GE20927@elte.hu>
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
Cc: linux-acpi@vger.kernel.org, mingo@redhat.com, len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, bunk@stusta.de, linux-kernel@vger.kernel.org, linux-pm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Quoting Ingo Molnar <mingo@elte.hu>:
> Subject: Re: 2.6.21-rc1: T60 resume from suspend to RAM issues
> =

> =

> * Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> =

> > > > > Do you believe that the second problem was caused by dynticks?
> > > > =

> > > > Assuming these are 2 different problems, yes, the second one seems =

> > > > to be caused by dyntics.
> > > =

> > > on my T60 current -git does not resume even without dynticks. =

> > > v2.6.20 with the same .config resumes fine (except for the display).
> > > =

> > > after pressing Fn/F4 the disk light flashes briefly, which suggests =

> > > that action is probably back to the Linux kernel at that point, and =

> > > that we hung somewhere there. Will try a bisection thing.
> > =

> > That's exactly the behaviour I have with DynTicks: the disk light =

> > flashes briefly.
> =

> it flashes here briefly even if suspend works fine.

Yes of course. The difference with 2.6.21-rc1 is that flashing the LED
is all it does :)


-- =

MST
