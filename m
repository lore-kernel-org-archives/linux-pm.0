From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v4 06/10] thermal: rockchip: consistently use int for
 temperatures
Date: Thu, 03 Dec 2015 09:16:55 +0800
Message-ID: <565F9807.4080700@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com> <1447044542-30859-7-git-send-email-wxt@rock-chips.com> <20151202183851.GA91131@google.com> <565F8FFE.3080807@rock-chips.com> <20151203004903.GA9543@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:46313 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbLCBRE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 20:17:04 -0500
In-Reply-To: <20151203004903.GA9543@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>, lkp@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

Hi Brain,

=E4=BA=8E 2015=E5=B9=B412=E6=9C=8803=E6=97=A5 08:49, Brian Norris =E5=86=
=99=E9=81=93:
> Hi Caesar,
>
> On Thu, Dec 03, 2015 at 08:42:38AM +0800, Caesar Wang wrote:
>> ? 2015?12?03? 02:38, Brian Norris ??:
>>
>> [.....]
>>>   	if (thermal->tshut_temp > INT_MAX) {
>>>       CID 1341498:  Integer handling issues  (CONSTANT_EXPRESSION_R=
ESULT)
>>>       "thermal->tshut_temp > 2147483647 /* (int)(~0U >> 1) */" is a=
lways false regardless of the values of its operands. This occurs as th=
e logical operand of if.
>>>
>>> I don't think this condition is even useful any more, so maybe we s=
hould
>>> just kill the 'if' block.
>> See the patch to fix
>> it.----->(https://patchwork.kernel.org/patch/7720601/)
>> <https://patchwork.kernel.org/patch/7720601/>
> -	if (thermal->tshut_temp > INT_MAX) {
> +	if (!(thermal->tshut_temp < INT_MAX)) {
>
> Huh? That still doesn't make much sense. The condition is still
> impossible, since thermal->tshut_temp is an int. You've just made it
> slightly harder for static analyzers to notice the impossibility.

Okay, that's possible remove this condition as you said.

- if (thermal->tshut_temp > INT_MAX) {
- dev_err(dev, "Invalid tshut temperature specified: %d\n",
- thermal->tshut_temp);
- return -ERANGE;
- }

Thanks!
>
>> This patch is merged into kernel 4.4-rc3.
> No it isn't, and I'm glad. The patch is silly.
>
> Brian
>
>
>


