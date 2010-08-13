From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
 take three
Date: Fri, 13 Aug 2010 15:08:01 -0400
Message-ID: <20100813190801.GB26950__44277.9024866924$1281726560$gmane$org@thunk.org>
References: <AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
	<20100813152254.GD2511@linux.vnet.ibm.com>
	<AANLkTimdpgC2DBn1pS2OG35+_06-L6TZ9Q_nb+C6Yeqv@mail.gmail.com>
	<20100813155738.GA11507@isilmar-3.linta.de>
	<AANLkTikN2zKcLtFJ6EdBU=iqT78bZKt_rKQoPNBRXJHj@mail.gmail.com>
	<1281719489.8407.17.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1281719489.8407.17.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: david@lang.hm, arjan@infradead.org, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, galibert@pobox.com, florian@mickler.org, tglx@linutronix.de, menage@google.com, paulmck@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, swmike@swm.pp.se
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 13, 2010 at 01:11:29PM -0400, James Bottomley wrote:
> 
> The facts are that suspend blockers identifies a race within our suspend
> to ram system that permeates from top to bottom (that's from server to
> mobile).  The problem is that resume events are racy with respect to
> suspend and vice versa.  This manifests itself most annoyingly on my
> laptop in the "double suspend" case: where I suspend with a pending
> suspend event, my laptop will resume and then immediately re-suspend
> (leading me to kick myself and remind myself to check it stayed up
> before pushing unsuspend and walking away).  The other annoying case is
> that if I accidentally close the lid before presenting, I have to wait
> until the system is fully down before pressing resume.

This is all true, but it's also only one aspect of the problem.  I
agree with you that this is the part of the problem which affects
Linux at all scales, from Cloud servers in a data center that want to
suspend themselves when there's no work to do (and then fail to
respond to the WOL packet) to mobile platforms that are suspending
much more frequently.

However, it doesn't follow that this is the _only_ problem that the
Android folks might be interested in solving.  Opportunistic suspend
is a different part of the problem space, which is generally believed
by the Android developers as being far more efficient than a
user-space suspend manager.  Rafael has stated his complete
unwillingness to deal with this part of the problem.  OK, so that
probably means that for Android, it will have to be an out-of-tree
kernel patch.

The question, then, is whether a solution which addresses the only
part of the problem which Rafael is interested in dealing with at this
point, is sufficient such that (a) the kernel-level opportunistic
suspend can be done as an out-of-tree patch, while simultaneously (b)
allowing device drivers for Android devices can utilize Rafael's
interfaces to solve the race design bug currently found in our suspend
subsystem, while (c) requiring minimal changes to the Android
userspace, and (d) providing all of the statistics and debugging
functionality required by the Android userspace.

If we can engineer a solution which meets (a), (b), (c), and (d)
above, then everyone will be happy.

					- Ted
