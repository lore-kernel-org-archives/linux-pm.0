From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/3] clk: keystone: Add sci-clk driver support
Date: Thu, 1 Sep 2016 15:27:33 +0300
Message-ID: <7b74dc9f-54f3-3081-72b7-116d4c44e98a@ti.com>
References: <20160820003342.13599-1-nm@ti.com>
 <20160820003342.13599-4-nm@ti.com> <20160824083415.GA6502@codeaurora.org>
 <c1a66f45-fa81-8137-4d9b-73e84141f67f@ti.com>
 <20160831223101.GI12510@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160831223101.GI12510@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Michael Turquette <mturquette@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 01/09/16 01:31, Stephen Boyd wrote:
> On 08/31, Tero Kristo wrote:
>> On 24/08/16 11:34, Stephen Boyd wrote:
>>> On 08/19, Nishanth Menon wrote:
>>>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>>>> new file mode 100644
>>>> index 000000000000..6c43e097e6d6
>>>> --- /dev/null
>>>> +++ b/drivers/clk/keystone/sci-clk.c
>>>> @@ -0,0 +1,539 @@
>>>> +	return (int)new_rate;
>>>
>>> determine rate should return a negative number on failure and 0
>>> on success. The actual rate that was found should go into
>>> req->rate. This looks broken.
>>
>> Yea it seems broken, I wonder how we haven't seen any issues with
>> this in testing.... Apparently positive return values from this are
>> interpreted as success. Having a quick look at clk.c seems to
>> confirm this.
>>
>> Anyway, will fix.
>
> True, perhaps we should fix that so we don't use a long to hold
> the int return value either.
>
>>>> + *
>>>> + * Gets a handle to an existing TI SCI clock, or builds a new clock
>>>> + * entry and registers it with the common clock framework. Called from
>>>> + * the common clock framework, when a corresponding of_clk_get call is
>>>> + * executed, or recursively from itself when parsing parent clocks.
>>>> + * Returns a pointer to the clock struct, or ERR_PTR value in failure.
>>>> + */
>>>
>>> Please move this driver to clk_hw_register() and friends. This on
>>> the fly clk generation is scary considering how we hold locks
>>> while the provider is asked to give us the pointer, so allocating
>>> and registering clks (basically reentering the CCF again) could
>>> lead to a locking nightmare. Best to avoid that.
>>
>> Ok, so just converting the driver to use provider->get_hw should be
>> enough? This seems to be a relatively new API in the CCF. Will look
>> at that.
>
> Hopefully it will simplify things greatly.

Well, it didn't simplify things greatly, but somewhat. I still need to 
use of_parse_phandle_with_args with one of the helpers for example. Will 
send out v2 in a bit.

>
>>
>>>> +	}
>>>> +
>>>> +	snprintf(name, 20, "%s:%d:%d", dev_name(provider->dev), sci_clk->dev_id,
>>>> +		 sci_clk->clk_id);
>>>
>>> I hope we don't make dev_name() longer than 20 characters
>>
>> Shall I just increase the size of the buffer and add a length check?
>> Using kmalloc or something here seems overkill, as the name gets
>> copied by CCF anyway.
>
> There's kasprintf() which would always make it long enough. I
> don't know if it really matters though.

Ok, I will use this one.

-Tero
