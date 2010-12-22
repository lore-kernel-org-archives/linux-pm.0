From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Prototype the pm_generic_ operations
Date: Wed, 22 Dec 2010 13:15:06 +0100
Message-ID: <201012221315.06948.rjw__32066.9959219687$1293020210$gmane$org@sisk.pl>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201012202208.59102.rjw@sisk.pl>
	<20101222114316.GA4520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101222114316.GA4520@sirena.org.uk>
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
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 22, 2010, Mark Brown wrote:
> On Mon, Dec 20, 2010 at 10:08:58PM +0100, Rafael J. Wysocki wrote:
> 
> > I'd take this one, but the second one depends on it.
> 
> > I can take both if Jean agrees.
> 
> Given the nearness of the merge window another option is to apply this
> one now and punt the I2C one until 2.6.38, I guess?

Except that I don't have any more fixes for 2.6.37 pending
and this one isn't really a fix. :-)

If there's anything else I should push to Linus before 2.6.37, I'll
include this patch in the pull request.  Otherwise I think it shoul go in
during the merge window.

Thanks,
Rafael
