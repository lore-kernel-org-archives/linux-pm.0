From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 18:19:28 +0200
Message-ID: <20100813161928.GA16898__35099.0135375925$1281716417$gmane$org@isilmar-3.linta.de>
References: <20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
	<20100813152254.GD2511@linux.vnet.ibm.com>
	<AANLkTimdpgC2DBn1pS2OG35+_06-L6TZ9Q_nb+C6Yeqv@mail.gmail.com>
	<20100813155738.GA11507@isilmar-3.linta.de>
	<1281715607.15486.102.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1281715607.15486.102.camel@Joe-Laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: david@lang.hm, Theodore Tso <tytso@mit.edu>, arjan@infradead.org, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, galibert@pobox.com, florian@mickler.org, James.Bottomley@suse.de, tglx@linutronix.de, menage@google.com, paulmck@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, swmike@swm.pp.se
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 13, 2010 at 09:06:47AM -0700, Joe Perches wrote:
> On Fri, 2010-08-13 at 17:57 +0200, Dominik Brodowski wrote:
> > Because millions of users are happy -- with Android, including suspend
> > blockers.
> 
> I'd guess there are on the order of 20 users
> that have built and deployed a kernel with
> Android suspend blockers support.

You mean non-Google users?

> The total deployed systems is relatively meaningless.

Well, it wasn't meaningless wrt noveau:

"I've heard all the excuses. If it isn't ready, they shouldn't ship it to
millions of people. And if it's ready, they should work on merging it.

No excuses.

Linus"

So let's get the suspend blockers to Linus.

Best
	Dominik
