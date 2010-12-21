From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Tue, 21 Dec 2010 23:51:27 +0000
Message-ID: <20101221235127.GC10081__35728.8684150719$1292975522$gmane$org@opensource.wolfsonmicro.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201012181559.50347.rjw@sisk.pl>
	<20101220150051.GI26706@rakim.wolfsonmicro.main>
	<201012202213.53902.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012202213.53902.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 20, 2010 at 10:13:53PM +0100, Rafael J. Wysocki wrote:

> Well, the _solution_ is to get rid of the legacy stuff from those buses in the
> first place.  Then, they'll just need to use the generic ops without any
> trouble.

> What you're proposing is a workaround that people will use as an excuse for
> not doing the right thing forever.

I hadn't actually realised that there was any urgency about removing the
old APIs - I'd not really seen much work in that direction.  If the
intention is to actively push people over to dev_pm_ops that does make a
bit more sense.
