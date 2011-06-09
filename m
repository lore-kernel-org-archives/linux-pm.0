From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
	support
Date: Thu, 09 Jun 2011 22:26:43 +0530
Message-ID: <4DF0FB4B.3080806__30664.2808173367$1307638665$gmane$org@ti.com>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<alpine.DEB.2.00.1106091742350.11513@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1106091742350.11513@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: frank.hofmann@tomtom.com
Cc: linux-pm@lists.linux-foundation.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 6/9/2011 10:14 PM, Frank Hofmann wrote:
>
>
> On Thu, 9 Jun 2011, Santosh Shilimkar wrote:
>
>> On 6/9/2011 9:10 PM, Russell King - ARM Linux wrote:
>>> On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
>>>> Btw, when testing this I found that generic cpu_suspend seems to be
>>>> just
>>>> fine for OMAP3; the OMAP platforms though do not at this time use the
>>>> generic cpu_suspend/resume for sleep, is it planned to change that ?
>>>
>>> That's because OMAP was doing changes to their sleep code while I was
>>> consolidating the sleep code, and although I asked several times that
>>> the OMAP folk should participate in this effort, but evidentally I was
>>> unsuccessful in achieving anything in that direction.
>>>
>> Agreed but the situation at that point was the code was not at
>> all in convertible position. Looking at your below comment,
>> it's still not :)
>>
>>> And of course since then it's been forgotten about, and I've given up
>>> on that particular aspect. I've also come to the conclusion that OMAP
>>> is sufficiently weird (requiring soo much to execute from SRAM) that
>>> its hopeless to persue.
>>>
>> We did discuss this Russell and requested your help here. I guess
>> you have already looked at OMAP code from generic suspend
>> hooks point of view and the SRAM execution, Errata's seems to
>> make you feel it's not going to work.
>> Is that what you mean here ?
>>
>> Regards
>> Santosh
>>
>
> Sorry for interjecting ... you're right there's a lot special about
> OMAP. What I've been talking about is a rather small(ish) bit. Maybe the
> diff illustrates what I mean - use cpu_suspend/resume for the parts of
> off-mode save/restore that are non-OMAP-specific.
>
> Like this (not tested, just for illustration what I mean):
>
Mostly it won't work.
Just replied to your questions. I think you can get the
answer on why this change won't work in it's current form.

Regards
Santosh
