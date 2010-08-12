From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
 take three
Date: Thu, 12 Aug 2010 21:52:24 +0200
Message-ID: <20100812195224.GA6370__29242.4015039161$1281642817$gmane$org@comet.dominikbrodowski.net>
References: <AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
	<AANLkTinNxZoMab=tG9KXJ9n_nxB1dXHkfk-7xUMWXACW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinNxZoMab=tG9KXJ9n_nxB1dXHkfk-7xUMWXACW@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: david@lang.hm, Theodore Tso <tytso@mit.edu>, arjan@infradead.org, peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, galibert@pobox.com, florian@mickler.org, James.Bottomley@suse.de, tglx@linutronix.de, menage@google.com, paulmck@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, swmike@swm.pp.se
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 12:48:48PM -0700, Brian Swetland wrote:
> On Thu, Aug 12, 2010 at 12:34 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Not Ubuntu, not Fedora, not MeeGo, not anyone with a typical
> > user-space seems to be having this problem. I can argue to you that
> > this problem can be solved in easier ways, but instead I will argue
> > that perhaps we should wait for somebody besides Android to complain
> > about it before providing a "solution". Because after all, what good
> > is a "solution" provided by the kernel, if the user-space is not going
> > to use it, ever.
> 
> I'm curious, when does Android count as a user of the kernel?  I
> gather that volume of sales or users doesn't count.  Do we have to
> include some percentage of "desktop" Linux?
> 
> If we're an undesirable second-class citizen, why do people care that
> "android is forking the kernel"?
> 
> I guess I don't understand,

I guess I don't, either -- there are some parts of the kernel used by only a
handful of users... and here we speak about million users...

Best,
	Dominik
