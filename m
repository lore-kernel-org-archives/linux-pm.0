From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from
	PM operations
Date: Wed, 5 Jan 2011 09:28:53 +0100
Message-ID: <201101050928.53979.rjw__6752.0467252054$1294216205$gmane$org@sisk.pl>
References: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4D23A839.6030205@codeaurora.org>
	<20110104231021.GA18024@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110104231021.GA18024@sirena.org.uk>
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
Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 05, 2011, Mark Brown wrote:
> On Tue, Jan 04, 2011 at 03:07:37PM -0800, Abhijeet Dharmapurikar wrote:
> > Mark Brown wrote:
> 
> >> device op. The PM core provides pm_generic_ functions implementing this
> >> behaviour - use them to reduce coupling with future PM updates.
> 
> > pm_generic_suspend() and others needs to be externed in linux/pm_runtime.h?
> 
> Yes, there's a patch in -next for this already so this patch would need
> to either wait for later in the merge window or go in via the PM tree
> with the preceeding one (the original version of this patch was posted
> as part of a series with the export patch).

I would take it, but I'm still waiting for a word from Jean.

Thanks,
Rafael
