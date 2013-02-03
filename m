From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/4] davinci: cpuidle - some cleanups
Date: Sun, 03 Feb 2013 13:22:43 +0100
Message-ID: <510E5693.5000003@linaro.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org> <510C0E4E.3010008@kernel.org> <510E4FEF.9040506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54266 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3BCMWq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Feb 2013 07:22:46 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so4120220wey.19
        for <linux-pm@vger.kernel.org>; Sun, 03 Feb 2013 04:22:45 -0800 (PST)
In-Reply-To: <510E4FEF.9040506@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, linux-pm@vger.kernel.org

On 02/03/2013 12:54 PM, Sekhar Nori wrote:
> On 2/2/2013 12:19 AM, Len Brown wrote:
>> On 02/01/2013 08:48 AM, Daniel Lezcano wrote:
>>> This patchset does some cleanup. It could have been folded in a sin=
gle
>>> patch but the review would have been less clean than splitting it i=
nto
>>> small and trivial patches.
>>>
>>> The main purpose of this patch is to remove the usage of the driver=
_data
>>> field from the state_usage structure. Len Brown is doing this clean=
up in
>>> the intel_idle.c file. With this patchset, the processor_idle.c fil=
e will
>>> be the last user of this field.
>>
>> Daniel,
>> Thanks for this cleanup.
>> Hopefully we can hear from somebody with davinci HW who can test it?
>=20
> Can someone forward the patches to
> davinci-linux-open-source@linux.davincidsp.com? I can help verify.

I cc'ed this mailing list but I have not subscribed to it. The mailing
list description says "moderated for non-subscribers" in the MAINTAINER=
S
file.

I assumed the moderator will accept the patchset.

Shall I subscribe and resend ?

Thanks
  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

