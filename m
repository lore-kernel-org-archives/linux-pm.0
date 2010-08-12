From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 12:57:12 -0700
Message-ID: <20100812125712.48b7fc26__21626.9901291982$1281643203$gmane$org@virtuousgeek.org>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
	<20100812125248.GA2763@thunk.org>
	<AANLkTin4=qpDWEKLwes_af6mSCW+ED7v-fWzD34JywU1@mail.gmail.com>
	<20100812182128.GC2763@thunk.org>
	<AANLkTinZ_gViUjVmEbkmour3BC=PcchJDARs4GaCuQwO@mail.gmail.com>
	<AANLkTimjfU2zu4reEVdOwWwtFHPQ33_Gna6xS2XHRG-h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimjfU2zu4reEVdOwWwtFHPQ33_Gna6xS2XHRG-h@mail.gmail.com>
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
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Aug 2010 12:19:34 -0700
Brian Swetland <swetland@google.com> wrote:
> Question though -- has every feature ever added to the kernel been a
> feature that there's pre-existing usage of?  Seems like a chicken and
> egg problem.  Also, some people seem to think there's value in being
> able to build kernels "out of the box" that work with the Android
> userspace -- given that there are a few devices out there that have
> that userspace on 'em.

We generally try to merge new features like this along with code that
uses said feature, but there are always exceptions.  We've merged code
one release or more before the new code gets used for example, which is
fine IMO.  What we don't want to see is some new drop of code added and
abandoned, but you already knew that.

At any rate, if Felipe is the only one arguing against including
suspend blockers in the kernel, you're probably in good shape.  Based
on my (rather cursory I admit) evaluation of this thread, it seems like
reasonable people agree that there's a place for a suspend blocker like
API in the kernel, and that dynamic power management is also highly
desirable.  So where's the git pull request already? :)

-- 
Jesse Barnes, Intel Open Source Technology Center
