From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 21:27:39 +0200
Message-ID: <20100812192739.GA11390__41103.257580153$1281641307$gmane$org@isilmar-3.linta.de>
References: <20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812140903.GB11362@sirena.org.uk>
	<AANLkTik=K2znpgiHVgA1oD5Znrmm0Gx45ajfoQ7AwG3F@mail.gmail.com>
	<AANLkTi=9v0o5pQ6s=sjjnk0udmrBAiy4wD+h2vrn_h8=@mail.gmail.com>
	<AANLkTiniku7rqkio-T6f9tL_adJSrDKfU33wFEEkeMVH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiniku7rqkio-T6f9tL_adJSrDKfU33wFEEkeMVH@mail.gmail.com>
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
Cc: david@lang.hm, menage@google.com, Theodore Tso <tytso@mit.edu>, arjan@infradead.org, peterz@infradead.org, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, galibert@pobox.com, linux-kernel@vger.kernel.org, florian@mickler.org, James.Bottomley@suse.de, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, swmike@swm.pp.se
List-Id: linux-pm@vger.kernel.org

Felipe,

> If you think suspend blockers are useful for you, great, use them. I
> just don't see why they should be merged if nobody is going to use
> them but you.

Aren't there many drivers in the kernel sources which are only used by very
few users? Android is used by million users, albeit on one platform, but I
don't see this to be a valid reason to keep this functionality out of the
kernel.

Best,
	Dominik
