From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/6] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Fri, 13 Mar 2015 22:26:59 +0100
Message-ID: <55035623.8010002@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org> <5501A1DE.9020804@linaro.org> <20150313182908.GU30671@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36336 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbCMV1B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 17:27:01 -0400
Received: by wiwh11 with SMTP id h11so61761wiw.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 14:27:00 -0700 (PDT)
In-Reply-To: <20150313182908.GU30671@e104818-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lina.iyer@linaro.org, linux-arm-kernel@lists.infradead.org

On 03/13/2015 07:29 PM, Catalin Marinas wrote:
> On Thu, Mar 12, 2015 at 03:25:34PM +0100, Daniel Lezcano wrote:
>> do you agree with this patchset ?
>
> In principle yes, apart from some function naming and I'm waiting for
> Lorenzo's ack as well. Do you plan to upstream this directly via your
> tree? If yes, I'll look in more detail and give some acks.

If you don't care, I would like to upstream via my tree because there i=
s=20
a couple of operations (like sharing a branch) I would like to monitor=20
to let people build their driver on top of it: renesas and qcom.

Qcom's cpuidle driver is already implemented and waits for this patchse=
t=20
to be upstream (the patchset has been around long enough). And I believ=
e=20
the Renesas driver will be reworked to use it also.

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

