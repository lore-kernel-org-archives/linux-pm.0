From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] I2C: runtime: Fix checks which make legacy
 suspend to never get called
Date: Wed, 29 Sep 2010 14:23:21 +0200
Message-ID: <20100929142321.59356b5b__15409.0336793617$1285763091$gmane$org@endymion.delvare>
References: <1285602360-21180-1-git-send-email-rnayak@ti.com>
	<201009282345.26363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009282345.26363.rjw@sisk.pl>
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
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Mark@smtp1.linux-foundation.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Sep 2010 23:45:26 +0200, Rafael J. Wysocki wrote:
> On Monday, September 27, 2010, Rajendra Nayak wrote:
> > For devices which are not adapted to runtime PM a call to
> > pm_runtime_suspended always returns true.
> > 
> > Hence the pm_runtime_suspended checks below prevent legacy
> > suspend from getting called.
> > 
> > So do a pm_runtime_suspended check only for devices with a
> > dev_pm_ops populated (which hence do not rely on the legacy
> > suspend)
> 
> Makes sense.
> 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  drivers/i2c/i2c-core.c |   44 ++++++++++++++++++++++++--------------------
> >  1 files changed, 24 insertions(+), 20 deletions(-)

Applied, thanks.

-- 
Jean Delvare
