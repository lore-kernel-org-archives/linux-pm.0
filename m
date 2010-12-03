From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] regulator: Take into account the
 requirements of all consumers
Date: Fri, 03 Dec 2010 18:12:27 +0000
Message-ID: <1291399947.3271.146.camel@odin>
References: <1291372267-23221-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1291372267-23221-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20101203110930.GO859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101203110930.GO859@rakim.wolfsonmicro.main>
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
Cc: linux-pm@lists.linux-foundation.org, Thomas Petazzoni <t-petazzoni@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-12-03 at 11:09 +0000, Mark Brown wrote:
> On Fri, Dec 03, 2010 at 11:31:07AM +0100, Thomas Petazzoni wrote:
> 
> > Extend the regulator_set_voltage() function to take into account the
> > voltage requirements of all consumers of the regulator being changed,
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Style nit:
> 
> > +	list_for_each_entry(regulator, &rdev->consumer_list, list)
> > +	{
> 
> The { should be on the previous line.

Applied and fixed the style.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
