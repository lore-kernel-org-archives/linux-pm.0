From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 13:36:28 +0300
Message-ID: <AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC__33102.8591994711$1281609481$gmane$org@mail.gmail.com>
References: <20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100812034435.GA7403@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 6:44 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Thu, Aug 12, 2010 at 04:25:21AM +0300, Felipe Contreras wrote:
>> Think in terms of an ARM laptop. What good is opportunistic suspend if
>> it's not going to help when the laptop is being used?
>
> For when the laptop is not being used, presumably.

Right, but if you have to optimize for dynamic PM anyway for normal
usage, how much would you gain by opportunistic suspend?

As it has been explained before, there's a point of diminishing returns:
http://article.gmane.org/gmane.linux.kernel/995525
http://article.gmane.org/gmane.linux.ports.arm.omap/37982

Now, how much would dynamic PM have progressed by the time we start
thinking on opportunistic suspend on laptops (ARM, or fixed PM), 10
seconds idle? 1 minute idle? Would it make sense to rewrite *all*
user-space in order to archive that little extra performance, *or*
would it make more sense to keep investing on dynamic PM which we have
to do anyway?

All this has already been explained.

BTW, the gain is even less if you consider that laptops already
automatically go to suspend after a while, so the gains of
opportunistic suspend would have to be measured only for a small
period of time (like 30 min or so).

-- 
Felipe Contreras
