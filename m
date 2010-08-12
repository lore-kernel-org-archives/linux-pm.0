From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 10:33:01 -0700
Message-ID: <AANLkTi=9v0o5pQ6s=sjjnk0udmrBAiy4wD+h2vrn_h8=__25088.9882132926$1281634624$gmane$org@mail.gmail.com>
References: <20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812140903.GB11362@sirena.org.uk>
	<AANLkTik=K2znpgiHVgA1oD5Znrmm0Gx45ajfoQ7AwG3F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik=K2znpgiHVgA1oD5Znrmm0Gx45ajfoQ7AwG3F@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: peterz@infradead.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Theodore Tso <tytso@mit.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 9:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Correct, but still a considerable amount of changes would need to be
> done, which _nobody_ has expressed any intention to do.
>
> Besides, IMO a good mobile platform would share as much as possible
> with desktop software. Say, the improvements Nokia has endorsed on the
> Telepathy IM framework can only help the people already using it on
> the desktop.
>
> However, personally, if I ever have to do './configure
> --enable-suspend-blockers', I would think that something that just
> doesn't belong has creped by to user-space. I don't see why there
> should something particularly different between mobile phones and
> laptops, and I think this has been already expressed over, and over.

So, because you feel that phones should be little laptops you oppose
providing (optional!) support for environments that take a different
view to that?

I'll echo Ted's question -- is this the opinion of the kernel
community at large?  If so, there's not much point in continuing to
have discussions around suspend blockers.

I think that we're still a ways away from a world where we can treat
mobile devices the same as laptops and get reasonable user
experiences.  I think it's unfortunate if the attitude here is "wait
and someday it won't matter", especially because I'm skeptical that
we're likely to hit that "someday" any time soon.

Brian
