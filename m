From: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] clk: remove unreachable code
Date: Wed, 9 Jan 2013 11:28:06 +0530
Message-ID: <CA+Z25wXRxPzdBAHj3_En4bBEpk=0HChnt-w_tHAbrXOvS9Odww@mail.gmail.com>
References: <1357650191-30842-1-git-send-email-rajagopal.venkat@linaro.org>
	<50ED0517.5090907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <50ED0517.5090907-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 9 January 2013 11:20, Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 01/08/2013 06:33 PM, Rajagopal Venkat wrote:
>> while reparenting a clock, NULL check is done for clock in
>> consideration and its new parent. So re-check is not required.
>> If done, else part becomes unreachable.
>>
>> Signed-off-by: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/clk/clk.c |    5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 251e45d..f896584 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1048,10 +1048,7 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
>>
>>       hlist_del(&clk->child_node);
>>
>> -     if (new_parent)
>> -             hlist_add_head(&clk->child_node, &new_parent->children);
>> -     else
>> -             hlist_add_head(&clk->child_node, &clk_orphan_list);
>> +     hlist_add_head(&clk->child_node, &new_parent->children);
>>
>>  #ifdef CONFIG_COMMON_CLK_DEBUG
>>       if (!inited)
>>
>
> The same logic holds good for following piece of code too.
>
> 1060 |-------if (new_parent)
> 1061 |-------|-------new_parent_d = new_parent->dentry;
> 1062 |-------else
> 1063 |-------|-------new_parent_d = orphandir;

Yes. Thanks for pointing out.

>
>
> --
> Tushar Behera



-- 
Regards,
Rajagopal
