From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Sun, 12 Jun 2011 16:07:07 -0700
Message-ID: <20110612230707.GE2212__33657.6870679439$1307920157$gmane$org@linux.vnet.ibm.com>
References: <20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
	<20110610175248.GF2230@linux.vnet.ibm.com>
	<20110610180807.GB28500@srcf.ucam.org>
	<20110610184738.GG2230@linux.vnet.ibm.com>
	<20110610192329.GA30496@srcf.ucam.org>
	<20110610193713.GJ2230@linux.vnet.ibm.com>
	<20110610200233.5ddd5a31@infradead.org>
	<20110611170610.GA2212@linux.vnet.ibm.com>
	<20110611102654.01e5cea9@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110611102654.01e5cea9@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 11, 2011 at 10:26:54AM -0700, Arjan van de Ven wrote:
> On Sat, 11 Jun 2011 10:06:10 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Fri, Jun 10, 2011 at 08:02:33PM -0700, Arjan van de Ven wrote:
> > > On Fri, 10 Jun 2011 12:37:13 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > On Fri, Jun 10, 2011 at 08:23:29PM +0100, Matthew Garrett wrote:
> > > > > On Fri, Jun 10, 2011 at 11:47:38AM -0700, Paul E. McKenney
> > > > > wrote:
> > > > > 
> > > > > > And if I understand you correctly, then the patches that
> > > > > > Ankita posted should help your self-refresh case, along with
> > > > > > the originally intended the power-down case and
> > > > > > special-purpose use of memory case.
> > > > > 
> > > > > Yeah, I'd hope so once we actually have capable hardware.
> > > > 
> > > > Cool!!!
> > > > 
> > > > So Ankita's patchset might be useful to you at some point, then.
> > > > 
> > > > Does it look like a reasonable implementation?
> > > 
> > > as someone who is working on hardware that is PASR capable right
> > > now, I have to admit that our plan was to just hook into the buddy
> > > allocator, and use PASR on the top level of buddy (eg PASR off
> > > blocks that are free there, and PASR them back on once an
> > > allocation required the block to be broken up)..... that looked the
> > > very most simple to me.
> > > 
> > > Maybe something much more elaborate is needed, but I didn't see why
> > > so far.
> > 
> > If I understand correctly, you face the same issue that affects
> > transparent huge pages, but on a much larger scale.  If you have even
> > one non-moveable allocation in a given top-level buddy block, you
> > won't be able to PASR that block.
> 
> yep we'd use a non-kernel zone for that; not too big a deal.
> (the much larger scale you can debate, if your memory controller is
> configured correctly the PASR regions are not all that much bigger than
> hugepages)

Ah, OK, so you have a very large number of top-level buddy allocations,
then.  Either that or very large hugepages.

> > In addition, one of the things that Ankita's patchset is looking to do
> > is to control allocations in a given region, so that the region can be
> > easily evacuated.  One use for this is to power off regions of memory,
> > another is to PASR off regions of memory, and a third is to ensure
> > that large regions of memory are available for when needed by media
> > codecs (e.g., cameras), but can be used for other purposes when the
> > media codecs don't need them (e.g., when viewing photos rather than
> > taking them).
> 
> the codec issue seems to be solved in time; a previous generation
> silicon on our (Intel) side had ARM ecosystem blocks that did not do
> scatter gather, however the current generation ARM ecosystem blocks all
> seem to have added S/G to them....
> (in part this is coming from the strong desire to get camera/etc blocks
> to all use "GPU texture" class memory, so that the camera can directly
> deposit its information into a gpu texture, and similar for media
> encode/decode blocks... this avoids copies as well as duplicate memory).

That is indeed a clever approach!

Of course, if the GPU textures are in main memory, there will still
be memory consumption gains to be had as the image size varies (e.g.,
displaying image on one hand vs. menus and UI on the other).  In addition,
I would expect that for quite some time there will continue to be a lot
of systems with display hardware a bit too simple to qualify as "GPU".

							Thanx, Paul
