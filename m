From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Null suspend/resume functions
Date: Wed, 18 Nov 2009 13:41:12 +0000
Message-ID: <20091118134112.GF6592__45896.5869890109$1258743824$gmane$org@rakim.wolfsonmicro.main>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<aec7e5c30911170446n71031671i48aca11f5276405d@mail.gmail.com>
	<20091117125901.GF823@rakim.wolfsonmicro.main>
	<200911172314.04396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911172314.04396.rjw@sisk.pl>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 17, 2009 at 11:14:04PM +0100, Rafael J. Wysocki wrote:

> In fact, it's not mandatory for bus types, not for drivers.  IMO bus types
> really have to know how to suspend a device and how to resume it,
> otherwise the core framework won't be useful anyway.  What the bus type does
> about drivers not implementing ->runtime_suspend() or ->runtime_resume(), it's
> up to the bus type.  That's even documented IIRC.

OK, thanks - I hadn't realised that these were being called directly
from the bus type code rather than by the core.
