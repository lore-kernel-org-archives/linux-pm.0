From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] opp: introduce library for
	device-specific	OPPs
Date: Sat, 18 Sep 2010 11:08:27 +0100
Message-ID: <20100918100827.GC22248__18027.0533114255$1284804556$gmane$org@opensource.wolfsonmicro.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk>
	<20100917164543.GI20325@esdhcp04044.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100917164543.GI20325@esdhcp04044.research.nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: Nishanth Menon <nm@ti.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, "Valentin Eduardo (Nokia-MS/Helsinki)" <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Thara Gopinath <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Roberto Granados Dorado <x0095451@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@vger.kernel.org>Romit Dasgupta <ro>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 17, 2010 at 07:45:43PM +0300, Phil Carmody wrote:
> On 17/09/10 17:36 +0200, ext Mark Brown wrote:

> > It might be clearer to use some term other than enabled in the code -
> > when reading I wasn't immediately sure if enabled meant that it was
> > available to be selected or if it was the active operating point.  How
>   ^^^^^^^^^
> > about 'allowed' (though I'm not 100% happy with that)?

> I think your query contains its own answer.

Yeah, I didn't pick that because all of them are available in the sense
that they could in the future be enabled but I do think it's the best
option.
