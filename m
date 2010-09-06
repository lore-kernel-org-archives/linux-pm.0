From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: generic runtime pm callbacks
Date: Mon, 6 Sep 2010 14:22:41 +0100
Message-ID: <20100906132241.GH8381__37640.2554255494$1283779424$gmane$org@sirena.org.uk>
References: <AANLkTikJ5sSQzZ8XL_04_VqzKKPZBRHGtMAQvdz9bfOS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikJ5sSQzZ8XL_04_VqzKKPZBRHGtMAQvdz9bfOS@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 06, 2010 at 03:32:09PM +0300, Ohad Ben-Cohen wrote:

> That may result in some drivers defining nop handlers, just to return
> 0 (in case there's nothing else they need to do).

> Do we want that ?

Funnily enough I was about to report this issue too - it doesn't look
great in the driver code.  My use case is using runtime PM in an MFD to
communicate status to the parent devices.  The subdevices are just
indicating that they are idle to the parent and have no reason to do
anything in a suspend or resume callback.

> Alternatively, we may want to allow drivers to enable Runtime PM (by
> taking the appropriate action for their subsystem, e.g. calling
> put_noidle in probe and get_noresume in remove), but still not define
> any runtime pm handlers (implicitly always returning a success), with
> something like:

This would be my preferred solution.
