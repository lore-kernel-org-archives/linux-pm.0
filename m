From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 03:46:34 +0300
Message-ID: <AANLkTinWmZZHd6uRRY-RRj_qu5P-3BjY8LRWrpRwFncH__21672.3496829674$1281574096$gmane$org@mail.gmail.com>
References: <20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<AANLkTinNc1SWmz8pE_4k6vThxQCJfCR_UqV6OM=OsJOf@mail.gmail.com>
	<20100811193106.GB24435@thunk.org>
	<AANLkTinBrp1iHWAi=vk_eaEHMs+Xcub6rg8PgT_LK2c9@mail.gmail.com>
	<AANLkTinOb5PsrLbMzbYVqqx=6n-yPNRCYgOf4fM5KdXJ@mail.gmail.com>
	<AANLkTimAKwDPYZeCj_UEyXf-6DxLg8=Zi-=tFKzzgvQi@mail.gmail.com>
	<AANLkTimwdJgAUHNgUDwagDhBd2MtEoSbt7rFa2dPkm2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimwdJgAUHNgUDwagDhBd2MtEoSbt7rFa2dPkm2c@mail.gmail.com>
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
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 1:12 AM, Brian Swetland <swetland@google.com> wrote:
> On Wed, Aug 11, 2010 at 3:03 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This is what I'm talking about when I say multi-tasking, Android
>> certainly doesn't have anything remotely like that:
>> http://www.youtube.com/watch?v=7emvUBpEkbU
>
> Home + pick app -> switch to the app in whatever state it was in.

If the app stops running, that's *fake* multi-tasking, and doesn't
match my experience; I can't remember the details, but I tested it on
a Nexus One, and the item I was looking at was gone, I had to scroll
again.

Also, I cannot go to last.fm on the browser, play some music, and do
other stuff at the same time, can I?

Anyway, what you do in Android is your problem. The point is that in
Linux we need good PM *with* multi-tasking (not really an argument
against opportunistic suspend, I think, but a clarification from Ted's
comment)

-- 
Felipe Contreras
