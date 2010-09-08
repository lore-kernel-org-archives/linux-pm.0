From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: lenient generic runtime pm callbacks
Date: Thu, 9 Sep 2010 01:46:18 +0200
Message-ID: <201009090146.18786.rjw@sisk.pl>
References: <1283811642-18837-1-git-send-email-ohad@wizery.com>
	<20100908105551.GB1219@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100908105551.GB1219@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 08, 2010, Mark Brown wrote:
> On Tue, Sep 07, 2010 at 01:20:42AM +0300, Ohad Ben-Cohen wrote:
> > Allow drivers, that belong to subsystems which use the generic
> > runtime pm callbacks, not to define runtime pm suspend/resume handlers,
> > by implicitly assuming success in such cases.
> > 
> > This is needed to eliminate nop handlers that would otherwise be
> > necessary by drivers which enable runtime pm, but don't need
> > to do anything when their devices are runtime-suspended/resumed.
> > 
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> As I said previously this would also remove some dummy suspend functions
> I need for some MFDs.

Applied to suspend-2.6/linux-next.

Thanks,
Rafael
