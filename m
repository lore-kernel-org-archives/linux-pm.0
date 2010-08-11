From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Wed, 11 Aug 2010 14:37:55 -0700
Message-ID: <AANLkTinOb5PsrLbMzbYVqqx=6n-yPNRCYgOf4fM5KdXJ__47774.68593461$1281562725$gmane$org@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinBrp1iHWAi=vk_eaEHMs+Xcub6rg8PgT_LK2c9@mail.gmail.com>
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
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 11, 2010 at 2:25 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Now, only Android has decided to use suspend blockers, that's a
> *fact*, and I wanted to narrow the discussion to Android in order to
> make it easier to understand that Android doesn't need suspend
> blockers, once we have agreed that, then I'd gladly discuss it's
> merits outside Android.

On behalf of the Android folks, we don't agree with this.  If you're
going to wait until we suddenly change our minds, I think you're going
to be in for a long wait.

> I argued to you that suspend-blockers are not required in Android, and
> suddenly you decide we should agree to disagree without arguing back?
> Well, suit yourself. I still maintain that suspend-blockers is just an
> expensive workaround, and in some cases actually degrades power
> consumption; the right solution is much more sophisticated.

Once "the right solution" exists and solves our problems, we'll
certainly look into switching over to it.  I've yet to see a proposal
in all this arguing that appears to me to be an improvement over what
we have today with suspend blockers.  I find the "don't do what you're
doing because someday, somebody will do it better" to be an
uncompelling argument.

Given your opinion that Android lacks multitasking (what? really?) and
various other strange statements about the platform, I'm likely to be
taking your suggestions with generous helping of skepticism.

Brian
