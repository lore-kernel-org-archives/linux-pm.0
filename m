From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 18 Feb 2011 20:27:44 +0000
Message-ID: <20110218202744.GA19427__26451.2382251725$1298061131$gmane$org@n2100.arm.linux.org.uk>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102182120.29977.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 18, 2011 at 09:20:29PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 18, 2011, Rabin Vincent wrote:
> > Looking at the i2c drivers using runtime pm in comparison, they all seem
> > to be using straightforward UNIVERSAL_PM_OPS-style code with the runtime
> > and the system sleep doing the same things.  So maybe we do need to
> > treat platform/AMBA different from the I2C/SPI group?
> 
> We probably do.

Do we have any pressing need to convert AMBA stuff?  I haven't heard any
reason yet to convert them to runtime PM - they don't even make any
runtime PM calls.

Maybe Linus can comment on the PM stuff as he has SoCs with these in.
As my boards don't have any sensible PM support, I don't have any
visibility of what PM facilities would be required.
