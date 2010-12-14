From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: pm_runtime_suspended() and
	non-pm_runtime-using	(i2c) drivers
Date: Tue, 14 Dec 2010 16:40:59 +0000
Message-ID: <20101214164059.GE5723__30002.131444826$1292345043$gmane$org@sirena.org.uk>
References: <AANLkTik7D2mDJN=BaasvLa4xx0fQBgjHREqQB06aD9JU@mail.gmail.com>
	<Pine.LNX.4.44L0.1012141114150.2087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1012141114150.2087-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 14, 2010 at 11:16:45AM -0500, Alan Stern wrote:

> I'm not familiar with the details of how the i2c subsystem works.  But
> in general, the subsystem code should call pm_runtime_set_active()  
> for every device before registering it.  Then if a driver doesn't use
> any runtime-PM functions, pm_runtime_suspended() will return false.

Hrm, if that's the case then we also need to update at least the
platform and SPI buses.  Though looking at the documentation this is
going to get a bit interesting as there's a requirement that the parent
has runtime PM enabled on it...  It's certainly not terribly apparent
from the documentation.

It'd be really helpful if it were clearer what noop buses like this were
supposed to do to get runtime PM working.
