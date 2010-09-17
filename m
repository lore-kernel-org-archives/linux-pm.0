From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Sat, 18 Sep 2010 00:22:50 +0200
Message-ID: <201009180022.51011.rjw__20744.6250286468$1284762409$gmane$org@sisk.pl>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk> <4C938EE2.1010307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Granados Dorado, Roberto" <x0095451@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

On Friday, September 17, 2010, Nishanth Menon wrote:
> Mark Brown had written, on 09/17/2010 10:36 AM, the following:
> > On Thu, Sep 16, 2010 at 08:29:33PM -0500, Nishanth Menon wrote:
> > 
> >> +struct opp_def {
> >> +	unsigned long freq;
> >> +	unsigned long u_volt;
> >> +
> >> +	bool enabled;
> >> +};
> > 
> > It might be clearer to use some term other than enabled in the code -
> > when reading I wasn't immediately sure if enabled meant that it was
> > available to be selected or if it was the active operating point.  How
> > about 'allowed' (though I'm not 100% happy with that)?
> ;).. The opp is enabled or disabled if it is populated, it is implicit 
> as being available but not enabled- how about active? this would change 
> the opp_enable/disable functions to opp_activate, opp_deactivate..

Would that mean that "active" is the one currently in use?

Rafael
