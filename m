From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [regression,
 bisected] adb trackpad disappears after suspend to ram
Date: Tue, 02 Jun 2009 08:52:23 +1000
Message-ID: <1243896743.591.13.camel__35365.6967905865$1243897026$gmane$org@pasglop>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<200906011836.15507.rjw@sisk.pl>
	<877hzv8txp.fsf@scholz.fias.uni-frankfurt.de>
	<200906020042.37036.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906020042.37036.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, Jan Scholz <scholz@fias.uni-frankfurt.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> > Tried this, but it does not help.
> > 
> > What I haven't noticed before is, that even if the trackpad already
> > disappeared, an additional suspend-resume cycle from the console brought
> > it back to life every time. Sometimes this worked from within X as well,
> > just not with such a high probability as from the console.
> > However, this is independent from 'sleepy_trackpad = 1'. 
> 
> OK, thanks for testing.  I think I know what to do, but I need some time to
> prepare a patch.

I wonder if the trakpad is timing out at some stage, we don't drain it
properly before suspend or something like that. Those ADB things are
a bit strange.

Ben.
