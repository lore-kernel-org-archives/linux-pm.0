From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [RFC Disable suspend on a specific device] This	is	a
	little change in linux power scheme
Date: Wed, 08 Apr 2009 22:53:07 +0300
Message-ID: <1239220387.6228.233.camel@localhost>
References: <200904072257.23756.rjw@sisk.pl>
	<200904081013.25301.rjw@sisk.pl> <49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl> <20090408114212.GK20122@sirena.org.uk>
	<1239209041.6228.217.camel@localhost>
	<20090408182330.GA6843@sirena.org.uk>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090408182330.GA6843@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

Hi,
On Wed, 2009-04-08 at 20:23 +0200, ext Mark Brown wrote:

> You might want to read the Android wakelock thread here - this comes
> from Android and has been gone over in some detail in the threads
> generated from their wakelock stuff.  

I did follow it. Didn't really like that either.

> Essentially what they are doing is
> exactly what you suggest, they've identified that suspend is a low power
> state and make every effort to enter it as often as possible, including
> when on a call. 

I'm not suggesting that. Suspend is inadequate for _real_ runtime power
management. Certainly it is not seamless.
Of course a smarter approach depends on the HW supporting certain
features, but if the HW is not there, I'd rather consider the suspend
based approach a workaround, rather than a real solution.

>  Clearly there are some issues with this approach but
> the Android guys did feel that entering suspend was worthwhile for them,
> especially since their users are able to download applications to the
> phone.

I don't think this is anyhow different from the Nokia Internet Tablets.

> Besides, no matter how low the power drain from your CPU when fully
> gated and at the lowest DVFS setting it's still possible to get a lower
> power drain since the CPU is going to be burning something and the
> regulators providing the supply to it are going to be burning something.

If you have a proper SoC, it can enter clock stop, lower voltage and
possibly even OFF mode. DVFS is by no means the way to save power in
general. It just addresses certain cases where the latency requirements
are too strict to afford entering really deep power saving states.
Otherwise it would mostly be better to run at max speed and do race to
OFF.

Regulators should have the options to be switched off if they are not
needed to preserve states, or enter a low power mode when only minimal
(non functional current) is needed.

> In most cases it's going to be peanuts - it certainly will be in the
> phone use case where you've got radios going.

I know that, but for this, suspend is still a poor man's power
management solution.
Of course the HW needs to be up to the intended task.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
