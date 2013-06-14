From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH V5 27/30] Documentation: thermal: Explain the exynos
 thermal driver model
Date: Fri, 14 Jun 2013 09:34:30 +0530
Message-ID: <CADGdYn7X8b-7AgtQH6qWmvc6tmEaRjLk7PKOWZSBcBRGYHMDJQ@mail.gmail.com>
References: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
	<1370955220-2949-28-git-send-email-amit.daniel@samsung.com>
	<1370971325.2776.99@driftwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:49799 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3FNEEc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2013 00:04:32 -0400
In-Reply-To: <1370971325.2776.99@driftwood>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com

Hi Rob,

On Tue, Jun 11, 2013 at 10:52 PM, Rob Landley <rob@landley.net> wrote:
> On 06/11/2013 07:53:37 AM, Amit Daniel Kachhap wrote:
>>
>> This patch updates the documentation to explain the driver model
>> and file layout.
>>
>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  Documentation/thermal/exynos_thermal |   43
>> ++++++++++++++++++++++++++-------
>>  1 files changed, 34 insertions(+), 9 deletions(-)
>
> ...
>
>> -TMU(Thermal Management Unit) in EXYNOS4 generates interrupt
>> +TMU(Thermal Management Unit) in EXYNOS4/5 generates interrupt
>>  when temperature exceeds pre-defined levels.
>> -The maximum number of configurable threshold is four.
>> +The maximum number of configurable threshold is five.
>
>
> Was that a driver change or was that a chipset change that only applies to
> version 5?
Basically in the new chipset several new features are added in
controller so driver is modified accordingly. However in V5 some
driver fixes are done as commented by jonghwa.
>
> Rob--
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
