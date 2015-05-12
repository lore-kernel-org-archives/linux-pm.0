From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] PM / clock_ops: Fix clock error check in __pm_clk_add()
Date: Tue, 12 May 2015 16:55:39 +0300
Message-ID: <5552065B.1020501@linaro.org>
References: <1431074863-19124-1-git-send-email-geert+renesas@glider.be> <20150508171955.GA38039@dtor-ws> <CAMuHMdVJsUNaWiULVeWKj5BE-wCDetmYi6Hh0CUrcdu9GP4tyQ@mail.gmail.com> <20150508210557.GC38039@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36446 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbbELNzk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 09:55:40 -0400
Received: by wizk4 with SMTP id k4so155046931wiz.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 06:55:38 -0700 (PDT)
In-Reply-To: <20150508210557.GC38039@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry,
On 05/09/2015 12:05 AM, Dmitry Torokhov wrote:
> On Fri, May 08, 2015 at 10:59:04PM +0200, Geert Uytterhoeven wrote:
>> On Fri, May 8, 2015 at 7:19 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> On Fri, May 08, 2015 at 10:47:43AM +0200, Geert Uytterhoeven wrote:
>>>> In the final iteration of commit 245bd6f6af8a62a2 ("PM / clock_ops: Add
>>>> pm_clk_add_clk()"), a refcount increment was added by Grygorii Strashko.
>>>> However, the accompanying IS_ERR() check operates on the wrong clock
>>>> pointer, which is always zero at this point, i.e. not an error.
>>>> This may lead to a NULL pointer dereference later, when __clk_get()
>>>> tries to dereference an error pointer.
>>>>
>>>> Check the passed clock pointer instead to fix this.
>>>
>>> Frankly I would remove the check altogether. Why do we only check for
>>> IS_ERR and not NULL or otherwise validate the pointer? The clk is passed
>>
>> __clk_get() does the NULL check.
> 
> No, not really. It _handles_ clk being NULL and returns "everything is
> fine". In any case it is __clk_get's decision what to do.
> 
> I dislike gratuitous checks of arguments passed in. Instead of relying
> on APIs refusing grabage we better not pass garbage to these APIs in the
> first place. So I'd change it to trust that we are given a usable
> pointer and simply do:
> 
> 	if (!__clk_get(clk)) {
> 		kfree(ce);
> 		return -ENOENTl
> 	}

Not sure this is right thing to do, because this API initially 
was intended to be used as below [1]:
	clk = of_clk_get(dev->of_node, i));
 	ret = pm_clk_add_clk(dev, clk);
 	clk_put(clk);

and of_clk_get may return ERR_PTR().

So, personally I prefer initial fix from Geert.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296586.html

-- 
regards,
-grygorii
