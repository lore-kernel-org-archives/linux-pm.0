From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC Disable suspend on a specific device] This is	a
	little change in linux power scheme
Date: Wed, 8 Apr 2009 19:23:31 +0100
Message-ID: <20090408182330.GA6843@sirena.org.uk>
References: <200904072257.23756.rjw@sisk.pl> <200904081013.25301.rjw@sisk.pl>
	<49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl>
	<20090408114212.GK20122@sirena.org.uk>
	<1239209041.6228.217.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1239209041.6228.217.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 08, 2009 at 07:44:01PM +0300, Igor Stoppa wrote:

> That might be the outcome, but it should be simply because those parts
> which are not in use are idle and therefore can enter spontaneously into
> a low power state.

You might want to read the Android wakelock thread here - this comes
from Android and has been gone over in some detail in the threads
generated from their wakelock stuff.  Essentially what they are doing is
exactly what you suggest, they've identified that suspend is a low power
state and make every effort to enter it as often as possible, including
when on a call.  Clearly there are some issues with this approach but
the Android guys did feel that entering suspend was worthwhile for them,
especially since their users are able to download applications to the
phone.

Besides, no matter how low the power drain from your CPU when fully
gated and at the lowest DVFS setting it's still possible to get a lower
power drain since the CPU is going to be burning something and the
regulators providing the supply to it are going to be burning something.
In most cases it's going to be peanuts - it certainly will be in the
phone use case where you've got radios going.
