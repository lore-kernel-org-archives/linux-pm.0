From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/4] davinci: cpuidle - some cleanups
Date: Sun, 03 Feb 2013 15:13:32 +0100
Message-ID: <510E708C.4030400@linaro.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org> <510C0E4E.3010008@kernel.org> <510E4FEF.9040506@ti.com> <510E5693.5000003@linaro.org> <510E5F5A.7020406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:48219 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab3BCONg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Feb 2013 09:13:36 -0500
Received: by mail-wi0-f175.google.com with SMTP id l13so1541125wie.14
        for <linux-pm@vger.kernel.org>; Sun, 03 Feb 2013 06:13:34 -0800 (PST)
In-Reply-To: <510E5F5A.7020406@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, linux-pm@vger.kernel.org

On 02/03/2013 02:00 PM, Sekhar Nori wrote:
> On 2/3/2013 5:52 PM, Daniel Lezcano wrote:
>> On 02/03/2013 12:54 PM, Sekhar Nori wrote:
>>> On 2/2/2013 12:19 AM, Len Brown wrote:
>>>> On 02/01/2013 08:48 AM, Daniel Lezcano wrote:
>>>>> This patchset does some cleanup. It could have been folded in a s=
ingle
>>>>> patch but the review would have been less clean than splitting it=
 into
>>>>> small and trivial patches.
>>>>>
>>>>> The main purpose of this patch is to remove the usage of the driv=
er_data
>>>>> field from the state_usage structure. Len Brown is doing this cle=
anup in
>>>>> the intel_idle.c file. With this patchset, the processor_idle.c f=
ile will
>>>>> be the last user of this field.
>>>>
>>>> Daniel,
>>>> Thanks for this cleanup.
>>>> Hopefully we can hear from somebody with davinci HW who can test i=
t?
>>>
>>> Can someone forward the patches to
>>> davinci-linux-open-source@linux.davincidsp.com? I can help verify.
>>
>> I cc'ed this mailing list but I have not subscribed to it. The maili=
ng
>> list description says "moderated for non-subscribers" in the MAINTAI=
NERS
>> file.
>>
>> I assumed the moderator will accept the patchset.
>>
>> Shall I subscribe and resend ?
>=20
> No need. I see the patches on the list. I will test and get back.

Cool ! Thanks !

  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

