From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] i2c: Factor out runtime suspend checks
	from PM operations
Date: Wed, 22 Dec 2010 22:08:59 +0100
Message-ID: <201012222208.59577.rjw__29637.2703546242$1293052260$gmane$org@sisk.pl>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=KOq65TS299rB=K961=mVXnriyqNxdHzJey5rD@mail.gmail.com>
	<20101222152550.GA16099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101222152550.GA16099@opensource.wolfsonmicro.com>
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
> On Wed, Dec 22, 2010 at 08:40:23PM +0530, Rabin Vincent wrote:
> 
> > Shouldn't you be deleting the pm_runtime_* stuff from here?  There is
> > already done in pm_generic_restore() iff the callback exists and returns
> > zero.
> 
> I guess; it's not clear why this is being done by the bus at all or how
> it interacts with the legacy stuff.

It is done, because when the driver's ->resume() or ->restore() brings the
device up (which should have happened if it returned 0), we need to mark
the device as "active" for runtime PM.

Since __pm_generic_resume() does that, it's not necessary to do it in the
bus type callbacks (in the "legacy" case we known that runtime PM is not
supported).

Thanks,
Rafael
