From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / clock_ops: Fix clock error check in __pm_clk_add()
Date: Fri, 8 May 2015 22:59:04 +0200
Message-ID: <CAMuHMdVJsUNaWiULVeWKj5BE-wCDetmYi6Hh0CUrcdu9GP4tyQ@mail.gmail.com>
References: <1431074863-19124-1-git-send-email-geert+renesas@glider.be>
	<20150508171955.GA38039@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150508171955.GA38039@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grygorii Strashko <Grygorii.Strashko@linaro.org>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 8, 2015 at 7:19 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, May 08, 2015 at 10:47:43AM +0200, Geert Uytterhoeven wrote:
>> In the final iteration of commit 245bd6f6af8a62a2 ("PM / clock_ops: Add
>> pm_clk_add_clk()"), a refcount increment was added by Grygorii Strashko.
>> However, the accompanying IS_ERR() check operates on the wrong clock
>> pointer, which is always zero at this point, i.e. not an error.
>> This may lead to a NULL pointer dereference later, when __clk_get()
>> tries to dereference an error pointer.
>>
>> Check the passed clock pointer instead to fix this.
>
> Frankly I would remove the check altogether. Why do we only check for
> IS_ERR and not NULL or otherwise validate the pointer? The clk is passed

__clk_get() does the NULL check.

> in and we do not call any API that would return ERR_PTR-encoded value to
> us so we shoud lnot even try to handle IS_ERR here.
>
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Fixes: 245bd6f6af8a62a2 ("PM / clock_ops: Add pm_clk_add_clk()")
>> ---
>> Note that there are no users of pm_clk_add_clk() in next-20150508, so
>> for now no in-tree code is affected.
>> ---
>>  drivers/base/power/clock_ops.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
>> index 7fdd0172605afe1b..c7b0fcebf168cabe 100644
>> --- a/drivers/base/power/clock_ops.c
>> +++ b/drivers/base/power/clock_ops.c
>> @@ -93,7 +93,7 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
>>                       return -ENOMEM;
>>               }
>>       } else {
>> -             if (IS_ERR(ce->clk) || !__clk_get(clk)) {
>> +             if (IS_ERR(clk) || !__clk_get(clk)) {
>>                       kfree(ce);
>>                       return -ENOENT;
>>               }
>> --
>> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
