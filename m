From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 17:57:38 +0200
Message-ID: <20100813155738.GA11507__14955.5423799486$1281715153$gmane$org@isilmar-3.linta.de>
References: <20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
	<20100813152254.GD2511@linux.vnet.ibm.com>
	<AANLkTimdpgC2DBn1pS2OG35+_06-L6TZ9Q_nb+C6Yeqv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimdpgC2DBn1pS2OG35+_06-L6TZ9Q_nb+C6Yeqv@mail.gmail.com>
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
Cc: david@lang.hm, Theodore Tso <tytso@mit.edu>, arjan@infradead.org, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, galibert@pobox.com, florian@mickler.org, James.Bottomley@suse.de, tglx@linutronix.de, menage@google.com, paulmck@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, swmike@swm.pp.se
List-Id: linux-pm@vger.kernel.org

> >> Not Ubuntu, not Fedora, not MeeGo, not anyone with a typical
> >> user-space seems to be having this problem. I can argue to you that
> >> this problem can be solved in easier ways, but instead I will argue
> >> that perhaps we should wait for somebody besides Android to complain
> >> about it before providing a "solution". Because after all, what good
> >> is a "solution" provided by the kernel, if the user-space is not going
> >> to use it, ever.
> >
> > At this point in the discussion, I am quite prepared to believe that you
> > will avoid using suspend blockers, and that you will further do everyth=
ing
> > in your power to prevent anyone else from using suspend blockers. =A0;-)
> =

> I'm not tying anybody's hands.
> =

> How are people using real-time linux if it's not on mainline? Well,
> duuh, you apply the patches. If say Fedora was interested on it, they
> could apply the patches, and see for themselves. People do that all
> the time, with the mm tree, with Con Koliva's patches, etc. Once
> people are happy with the results, things get merged. Why should this
> be any different?

Because millions of users are happy -- with Android, including suspend
blockers.

Best,
	Dominik
