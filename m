From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from
	PM	operations
Date: Tue, 4 Jan 2011 23:10:21 +0000
Message-ID: <20110104231021.GA18024__12545.4700588763$1294182687$gmane$org@sirena.org.uk>
References: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4D23A839.6030205@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D23A839.6030205@codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 04, 2011 at 03:07:37PM -0800, Abhijeet Dharmapurikar wrote:
> Mark Brown wrote:

>> device op. The PM core provides pm_generic_ functions implementing this
>> behaviour - use them to reduce coupling with future PM updates.

> pm_generic_suspend() and others needs to be externed in linux/pm_runtime.h?

Yes, there's a patch in -next for this already so this patch would need
to either wait for later in the merge window or go in via the PM tree
with the preceeding one (the original version of this patch was posted
as part of a series with the export patch).
