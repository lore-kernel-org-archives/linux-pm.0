From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] power_suply: isp1704_charger: Fix isp1704_write()
 definition
Date: Fri, 1 Jan 2016 13:33:03 +0200
Message-ID: <568663EF.9070502@gmail.com>
References: <1451646209-11618-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011226.21552@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35371 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbcAALdI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2016 06:33:08 -0500
In-Reply-To: <201601011226.21552@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Pali,

On  1.01.2016 13:26, Pali Roh=C3=A1r wrote:
> On Friday 01 January 2016 12:03:29 Ivaylo Dimitrov wrote:
>> All calls to isp1704_write() are using parameter sequence of
>> isp1704_write(isp, reg, val) but the function is defined as
>> isp1704_write(isp, val, reg). Fix isp1704_write function definition
>> so that the driver to be functional.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>
> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>
> This problem is there since inclusion of driver itself. No idea why t=
hat
> driver could work... I remember that it detected correctly type of
> charger.
>
> I will test this patch on real N900 HW in one or two weeks to check h=
ow
> it behave after patching...
>

Well, I  tested in on real HW, wall charger as well as USB were=20
correctly detected. No idea what else needs to be tested, but I guess i=
f=20
you guide me, I can test whatever is needed.

Ivo
