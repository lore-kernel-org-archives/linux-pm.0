From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 18 Feb 2011 22:16:06 +0000
Message-ID: <20110218221606.GB25168__12769.0517031171$1298067547$gmane$org@sirena.org.uk>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
	<20110218202744.GA19427@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110218202744.GA19427@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 18, 2011 at 08:27:44PM +0000, Russell King - ARM Linux wrote:

> Do we have any pressing need to convert AMBA stuff?  I haven't heard any
> reason yet to convert them to runtime PM - they don't even make any
> runtime PM calls.

There's a bit of a chicken and egg problem in that it's not possible for
devices to make use of runtime PM unless the bus has runtime PM support
implemented - the bus implementation is mandatory, there's no default.
