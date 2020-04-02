Return-Path: <SRS0=3neH=5S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D319C43331
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6AF206CC
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 15:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="pbiRv7Sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbgDBPAd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:00:33 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:30283 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbgDBPAd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 11:00:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR7y6q9TzHd;
        Thu,  2 Apr 2020 17:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839631; bh=vn1sCW7UyenPqAw3zOWtIZx5V5o8WEC1MQiYnuQrEoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbiRv7SwA2Kv3UsmypWZi8c7Gh+CWfNX0+QMKrfYxbvn4rD3+ApKCimEywwss8UpX
         66cix9tCiiukzmwODFaSny9BpmUcEXRrf+5thqgzFHC+rt4gYVdJExQV9MgfUOYHAs
         Qlm/VS7uZg1aFLyMKjDCqUdIkgm1P6AZEL/0nsk8+AASZEGQhN/N+AdTYA06Rjqfh/
         tV7Gd6BFyVG9k+n+A5tgg6dS+QxH0uYbJ4YGykWGct9Jw4vxrIKGlWwigjkHDJ+T3q
         kIWDm8gnGXlDpBl+XdLaVO2u9T1aN/2tI2FglLX9b5Lvk9NdPWhYTJ1UDEEohus/UQ
         jL6EA5ANPnCkQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 2 Apr 2020 17:00:29 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Sebastian Reichel (maintainer:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS 
        ,blamed_fixes:1/1=100%)" <sebastian.reichel@collabora.com>,
        "Andrey Smirnov (blamed_fixes:1/1=100%)" <andrew.smirnov@gmail.com>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] power: supply: core: fix HWMON temperature labels
Message-ID: <20200402150029.GA8325@qmqm.qmqm.pl>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
 <4a8ac6700e1503a69146f3eefd7cb515d11bfc9f.1585837575.git.mirq-linux@rere.qmqm.pl>
 <29d67963-c110-553a-fec4-b972953987b1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29d67963-c110-553a-fec4-b972953987b1@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 02, 2020 at 07:52:19AM -0700, Guenter Roeck wrote:
> On 4/2/20 7:46 AM, Micha³ Miros³aw wrote:
> > tempX_label files are swapped compared to what
> > power_supply_hwmon_temp_to_property() uses. Make them match.
> > While at it, make room for labeling other channels.
> > 
> > Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/power/supply/power_supply_hwmon.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> > index 75cf861ba492..83318a21fb52 100644
> > --- a/drivers/power/supply/power_supply_hwmon.c
> > +++ b/drivers/power/supply/power_supply_hwmon.c
> > @@ -43,6 +43,11 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
> >  	}
> >  }
> >  
> > +static const char *const ps_temp_label[] = {
> > +	"temp",
> > +	"ambient temp",
> > +};
> > +
> >  static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
> >  {
> >  	if (channel) {
> > @@ -144,7 +149,14 @@ static int power_supply_hwmon_read_string(struct device *dev,
> >  					  u32 attr, int channel,
> >  					  const char **str)
> >  {
> > -	*str = channel ? "temp" : "temp ambient";
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		*str = ps_temp_label[channel];
> > +		break;
> > +	default:
> > +		break;
> 
> That returns "no error" without setting *str, which is really asking for trouble.

This is carried over from earlier version. No bug though, but I'll add a
patch while I'm at it.

Best Regards
Micha³ Miros³aw
