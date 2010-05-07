From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 7 May 2010 07:29:47 -0400
Message-ID: <81818215-44A2-4B74-A43F-E2644C950F5C@mit.edu>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
	<20100505234025.GB4838@opensource.wolfsonmicro.com>
	<l2kd6200be21005052125rc43217a2r8c65bc98e7a5d3d4@mail.gmail.com>
	<20100507100406.GA21498@rakim.wolfsonmicro.main>
	<w2kd6200be21005070357r9aad2896l355168a23bf85eae@mail.gmail.com>
	<20100507112102.GC21498@rakim.wolfsonmicro.main>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100507112102.GC21498@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org


On May 7, 2010, at 7:21 AM, Mark Brown wrote:
> 
> This goes back to the thing about a full system suspend being a
> sledgehammer which doesn't give enough information about what's going
> on when it's used like this.  As discussed we need a way to know that
> the connections involved are able to stay live during suspend (on a
> large proportion of systems suspend is going to mean that the relevant
> bits of the board will loose power so need to be shut down) and that
> that the intention of the user is that they should do so (this isn't
> clear in the general system, especially not if the suspend is initiated
> manually).  

This sounds like it may be something unique to your board/product.  Or am I missing something?

One of the challenges with PM in the embedded world is that everybody seems to have slightly different assumptions, and hardware that doesn't behave the same way.

More than once this discussion has wandered off into the weeds wrt to whether this patch series is ready to be merged, since there are so many drivers blocked on it....

-- Ted
