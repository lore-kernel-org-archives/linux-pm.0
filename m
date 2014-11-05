From: Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH 0/4] poweroff-source DT property renaming
Date: Wed, 5 Nov 2014 16:53:16 +0100
Message-ID: <CABgxDoKgXLSGwDzH=xHDnccZemnbwWQuD5qaD-YhvmSb9MKDvg@mail.gmail.com>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
	<20141105093912.GM31358@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34051 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbaKEPxS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Nov 2014 10:53:18 -0500
In-Reply-To: <20141105093912.GM31358@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

(did not include all in previous reply)

Hi Johan,

2014-11-05 10:39 GMT+01:00 Johan Hovold <johan@kernel.org>:
> Please mention (here and in the commit message) that this is a rename
> back to the old and fairly established property name, but without the
> vendor prefix.

Ok will do.

>
> Essentially, it is a revert of a commit that is only in the regulator
> tree.

In regulator and mfd tree, afaik.

>
>> Changes and explanations since v1:
>>
>>   - The first patch defines "of_is_system_power_controller" which is compatible
>>     with both "vendor,system-power-controller" and "system-power-controller"
>>     properties. Also, It keeps the old helper function of_system_has_poweroff_source
>>     for source compatibility until everything is renamed (in this way, bisections
>>     are not broken and change is made "atomically" between each commit)
>>
>>     Note: the property "poweroff-source" itself is not used in dts files yet.
>>     Before this patch tps65910 was broken due to missing backward compatibility
>>     with "vendor,system-power-controller". As the old helper uses the new one,
>>     it works again.
>
> What patch broke tps65910? Please refer to it using commit id and
> summary (in parenthesis).

commit 645d10214b2867d26dd97cafb43a3a8b3ec1da66 (mfd: tps65910:
Convert ti,system-power-controller DT property to poweroff-source)

It breaks backward compatibility with existing dts files, the driver
itself is not broken.

>
> Is that commit currently only in the regulator tree? If so, that could
> be an argument for not doing this change incrementally (but that's not
> my decision to make).

As I said, in mfd and regulator tree. But it might have been
cross-merged somewhere... no ? (and not in "next" yet)

> I think you should squash the last three patches (i.e. update the
> drivers and remove the helper in one patch).

If it does not create drama and does not cause compat issues, I also
think that this is the simpler solution.

>
>> Romain Perier (4):
>>   of: Rename "poweroff-source" property to "system-power-controller"
>>   regulator: act8865: Convert poweroff-source DT property to
>>     system-power-controller
>>   mfd: tps65910: Convert poweroff-source DT property to
>>     system-power-controller
>>   of: Remove of_system_has_poweroff_source helper function
>
> Please do not mix patch revisions in your Subject lines when submitting
> an updated series. Update the revision number for the series and all
> patches in it even if a single patch happens to be unchanged (or new as
> patch 4/4).

Arf, did not know... sorry ^^ . I will try my best next time.


Thanks for your feedbacks,
Romain

2014-11-05 10:39 GMT+01:00 Johan Hovold <johan@kernel.org>:
> On Wed, Oct 29, 2014 at 07:35:31AM +0000, Romain Perier wrote:
>> The goal of this serie is to rename the property "poweroff-source" to
>> "system-power-controller" and to fix things incrementally.
>
> Please mention (here and in the commit message) that this is a rename
> back to the old and fairly established property name, but without the
> vendor prefix.
>
> Essentially, it is a revert of a commit that is only in the regulator
> tree.
>
>> Changes and explanations since v1:
>>
>>   - The first patch defines "of_is_system_power_controller" which is compatible
>>     with both "vendor,system-power-controller" and "system-power-controller"
>>     properties. Also, It keeps the old helper function of_system_has_poweroff_source
>>     for source compatibility until everything is renamed (in this way, bisections
>>     are not broken and change is made "atomically" between each commit)
>>
>>     Note: the property "poweroff-source" itself is not used in dts files yet.
>>     Before this patch tps65910 was broken due to missing backward compatibility
>>     with "vendor,system-power-controller". As the old helper uses the new one,
>>     it works again.
>
> What patch broke tps65910? Please refer to it using commit id and
> summary (in parenthesis).
>
> Is that commit currently only in the regulator tree? If so, that could
> be an argument for not doing this change incrementally (but that's not
> my decision to make).
>
>>
>>   - act8865 and tps65910 are ported to the new helper function
>>
>>   - The last commit removes the olf helper which was only used for
>>   source compatibility
>
> I think you should squash the last three patches (i.e. update the
> drivers and remove the helper in one patch).
>
>> Romain Perier (4):
>>   of: Rename "poweroff-source" property to "system-power-controller"
>>   regulator: act8865: Convert poweroff-source DT property to
>>     system-power-controller
>>   mfd: tps65910: Convert poweroff-source DT property to
>>     system-power-controller
>>   of: Remove of_system_has_poweroff_source helper function
>
> Please do not mix patch revisions in your Subject lines when submitting
> an updated series. Update the revision number for the series and all
> patches in it even if a single patch happens to be unchanged (or new as
> patch 4/4).
>
> Johan
