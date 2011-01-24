From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Mon, 24 Jan 2011 19:43:27 +1000
Message-ID: <AANLkTi=YAZxoGTyK4AQwDiBz6e9JegihLuO34cCxSR6U__16395.8157333129$1295862386$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<201101222017.40389.rjw@sisk.pl>
	<AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+@mail.gmail.com>
	<201101232229.49494.rjw@sisk.pl>
	<AANLkTimSv5Myv14Kys2OTgm=wH=8DFPFeeUSkEfg-+b1@mail.gmail.com>
	<1295856557.1866.802.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1295856557.1866.802.camel@rui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Wilson <chris@chris-wilson.co.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 24, 2011 at 6:09 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Mon, 2011-01-24 at 15:22 +0800, Linus Torvalds wrote:
>>
>> Yeah, I think there's something there. In fact, I'm getting pretty
>> sure of it. Because I have now twice seen the _shutdown_ end up
>> halting, and guess what? When I press a key, it then finishes the
>> shutdown.
>>
>> Sound familiar?
>>
>> The last thing printed is the "Disabling non-boot CPU's" thing or
>> whatever. I didn't take a picture, and it obviously doesn't get logged
>> (since it's after the processes have been killed), but it definitely
>> smelled like "Uhhuh, same problem as with suspend".
>>
> https://patchwork.kernel.org/patch/500501/
> does this patch help?

Ding ding ding - I think we have a winner. Five reboots with
successful suspend/resume cycles. So this may well be it.

Of course, it was flaky enough before that it's not a guarantee (it
certainly doesn't always fail), but I'm optimistic.

               Linus
