From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v4] ARM
	hibernation/suspend-to-disk	support
Date: Thu, 9 Jun 2011 17:40:24 +0100
Message-ID: <20110609164024.GB24424__45340.1746963666$1307637694$gmane$org@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4DF0F45A.3030103@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 09, 2011 at 09:57:06PM +0530, Santosh Shilimkar wrote:
> On 6/9/2011 9:10 PM, Russell King - ARM Linux wrote:
>> On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
>>> Btw, when testing this I found that generic cpu_suspend seems to be just
>>> fine for OMAP3; the OMAP platforms though do not at this time use the
>>> generic cpu_suspend/resume for sleep, is it planned to change that ?
>>
>> That's because OMAP was doing changes to their sleep code while I was
>> consolidating the sleep code, and although I asked several times that
>> the OMAP folk should participate in this effort, but evidentally I was
>> unsuccessful in achieving anything in that direction.
>
> Agreed but the situation at that point was the code was not at
> all in convertible position. Looking at your below comment,
> it's still not :)

Well, I had a look before posting this reply, and ran away from it.
I've gone back to it several times since, and got a similar reaction.

I seem to remember that it looked _more_ convertable when I looked at
it when doing the generic suspend/resume support - I could see a nice
simple way to pull out the saving and just leave the PLL resume stuff
in SRAM.

I'm now convinced that if I try to convert it use the generic support,
it will end up being a horrible broken mess.
