From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v2 1/3] drivers: power: twl4030_charger: fix link problems
 when building as module
Date: Thu, 24 Sep 2015 21:09:15 +0200
Message-ID: <CAAfyv36mr67fUJKbe1F_rdxRjtvR8M+da0rYCtVTxDgyhKLvSQ@mail.gmail.com>
References: <1442953171-19718-1-git-send-email-marek@goldelico.com>
	<20150922212900.GB15646@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35758 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbbIXTJ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2015 15:09:28 -0400
In-Reply-To: <20150922212900.GB15646@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Sebastian,

On Tue, Sep 22, 2015 at 11:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Marek,
>
> On Tue, Sep 22, 2015 at 10:19:29PM +0200, Marek Belisko wrote:
>> If either twl4030_charger or twl4030_madc is configured as MODULE,
>> we get build (link) errors.
>>
>> To solve, the direct call of twl4030_get_madc_conversion() is replaced
>> by a call to iio_read_channel_processed().
>>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>> changes from V1: added missing iio_channel_release + document and add new DT bindings
>
> That was fast :) Patchset looks fine to me except for one last
> thing: Let's make the iio-channel optional, so that old DT blobs
> are still supported. Also the IS_REACHABLE(CONFIG_TWL4030_MADC)
> check can be removed, it should no longer be needed with
> iio_read_channel_processed().
OK I updated driver code to pass when 'vac' property isn't found in
DT. Should I mark it also
in DT bindings or keep it as it was in v2? Thanks.
>
> -- Sebastian

BR,

marek


-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
