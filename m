From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 2/3] power: clock_ops.c: check return of clk_enable()
 in pm_clk_resume()
Date: Tue, 14 Jan 2014 12:02:41 +0000
Message-ID: <52D52761.1000303@codethink.co.uk>
References: <1389445540-21426-1-git-send-email-ben.dooks@codethink.co.uk> <1389445540-21426-2-git-send-email-ben.dooks@codethink.co.uk> <1438385.ppqm7XWTt3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1438385.ppqm7XWTt3@vostro.rjw.lan>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@lists.codethink.co.uk, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/01/14 19:55, Rafael J. Wysocki wrote:
> On Saturday, January 11, 2014 01:05:39 PM Ben Dooks wrote:

>> @@ -262,8 +263,9 @@ int pm_clk_resume(struct device *dev)
>>
>>   	list_for_each_entry(ce, &psd->clock_list, node) {
>>   		if (ce->status < PCE_STATUS_ERROR) {
>> -			clk_enable(ce->clk);
>> -			ce->status = PCE_STATUS_ENABLED;
>> +			ret = clk_enable(ce->clk);
>> +			if (ret == 0)
>
> Can you please use if (!ret) here?
>
> And analogously in patch [3/3]?

I will fix and re-send today, thanks.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
