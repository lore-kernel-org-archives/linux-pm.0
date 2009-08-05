From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/5] pda-power: switch to new dev_pm_ops
Date: Thu, 6 Aug 2009 00:29:20 +0200
Message-ID: <20090805222920.GF19257__5738.48713324896$1249511440$gmane$org@buzzloop.caiaq.de>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-2-git-send-email-daniel@caiaq.de>
	<200908052149.55567.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908052149.55567.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: spyro@f2s.com, cbou@mail.ru, linux-pm@lists.linux-foundation.org, mreimer@vpop.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 05, 2009 at 09:49:52PM +0200, Frans Pop wrote:
> Daniel Mack wrote:
> > +static struct dev_pm_ops pda_power_pm_ops = {
> > +       .suspend        = pda_power_suspend,
> > +       .freeze         = pda_power_freeze,
> 
> Hmmm. Where's pda_power_freeze defined? Forgot to (compile)test the 
> patches?

Yes, sorry. I can't test hibernation, so I didn't pay enough attention.
I'll resend them anyway with Rafael's new macro used.

Thanks,
Daniel
