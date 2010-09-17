From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] opp: introduce library for device-specific
 OPPs
Date: Fri, 17 Sep 2010 16:59:37 +0100
Message-ID: <20100917155937.GB29596__24504.1274851703$1284744533$gmane$org@rakim.wolfsonmicro.main>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk> <4C938EE2.1010307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C938EE2.1010307@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Granados Dorado, Roberto" <x0095451@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@vger.kernel.org>, Romit Dasgupta <ro.mi>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 17, 2010 at 10:53:06AM -0500, Nishanth Menon wrote:
> Mark Brown had written, on 09/17/2010 10:36 AM, the following:

> >It might be clearer to use some term other than enabled in the code -
> >when reading I wasn't immediately sure if enabled meant that it was
> >available to be selected or if it was the active operating point.  How
> >about 'allowed' (though I'm not 100% happy with that)?

> ;).. The opp is enabled or disabled if it is populated, it is
> implicit as being available but not enabled- how about active? this
> would change the opp_enable/disable functions to opp_activate,
> opp_deactivate..

> Recommendations folks?

The enable/disable thing wasn't so noticable in the API itself, it was
in the data structures that I found it confusing - the core has a
different idea about what's going on with the system as a whole compared
to the decision that an individual device is taking.

> >When reading the description I'd expected to see some facility to
> >trigger selection of an active operating point in the library (possibly
> >as a separate call since you might have a bunch of operating points
> >being updated in quick succession) but it looks like that needs to be
> >supplied externally at the minute?

> The intent is we use the opp_search* functions to pick up the opp
> and enable/activate it and disable/deactivate it.

Sure, I get that bit.  What I meant was that I was expecting something
that would say that changes had been made to the enabled/disabled sets
and that it'd be a good idea to rescan, especially for cases where the
devices change their requirements but the OPPs need to be done over a
larger block.
