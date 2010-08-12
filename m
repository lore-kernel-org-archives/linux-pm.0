From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 14:21:28 -0400
Message-ID: <20100812182128.GC2763__48361.3766068176$1281637365$gmane$org@thunk.org>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
	<20100812125248.GA2763@thunk.org>
	<AANLkTin4=qpDWEKLwes_af6mSCW+ED7v-fWzD34JywU1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin4=qpDWEKLwes_af6mSCW+ED7v-fWzD34JywU1@mail.gmail.com>
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
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 07:46:03PM +0300, Felipe Contreras wrote:

> All the Android community had to do is push the drivers *without*
> suspend blockers, then the Android kernel wouldn't be so different and
> thus wouldn't be considered a fork. AFAIU the kernel side wakelocks
> are already in the kernel, so there's no excuse not to merge the
> drivers.

What's there is not good enough, because it's missing the statistics
and reporting so that badly behaved kernel and userspace drivers that
take wakelocks can be found.

I have a similar problem with the whole pm_qos subsystem, as I've said
earlier.  If some badly behaved application claims to want 0us
wireless latency, and keeps the radio on all the time, there is no way
for me to find out which is the badly behaved application --- even
though I'm the owner of the laptop, and at the end of the day *I*
should be able to say, no, battery lifetime is more important than
what the application might think is its "minimum wireless latency".
Not only can I not override the application, I can't even find out
which application is at fault!   ***FAIL***

In some ways, this is exactly the same problem as the "which badly
Maemo application is causing my causing my N770 to have its battery
laptop drop in half?".

     	 	     	   	    	- Ted
