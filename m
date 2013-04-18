From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Date: Thu, 18 Apr 2013 11:18:04 +0200
Message-ID: <516FBA4C.6020100@linaro.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org> <20130418011816.GD4511@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:55553 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758171Ab3DRJSH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 05:18:07 -0400
Received: by mail-bk0-f42.google.com with SMTP id jc3so1162642bkc.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 02:18:06 -0700 (PDT)
In-Reply-To: <20130418011816.GD4511@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: lethal@linux-sh.org, rjw@sisk.pl, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

On 04/18/2013 03:18 AM, Simon Horman wrote:
> On Wed, Apr 17, 2013 at 03:32:54PM +0200, Daniel Lezcano wrote:
>> The driver is a global static variable automatically initialized to =
zero.
>>
>> Removing the useless initialization in the init function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Hi Daniel,
>=20
> All four patches in this series seem reasonable to me.
>=20
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> Please let me know if I should take them through my renesas tree.

If you are ok with that, is it possible to take them through the
linux-pm tree ? So the cpuidle drivers are synced and I can continue th=
e
code consolidation ?

Thanks for the review.

  -- Daniel

>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

