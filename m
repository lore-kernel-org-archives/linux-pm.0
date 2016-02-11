From: Belisko Marek <marek.belisko@gmail.com>
Subject: generic-adc-battery volatge-to-percent formula
Date: Thu, 11 Feb 2016 21:38:21 +0100
Message-ID: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34281 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcBKUiX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 15:38:23 -0500
Received: by mail-wm0-f49.google.com with SMTP id 128so37287955wmz.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 12:38:22 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>

Hi,

some time ago I did post series which added some conversion table from
voltage to percent for charging and discharging states [1] in
twl4030_madc driver. This approach was not accepted and we still want
to have something like that in kernel. We re-think re-thinking
original idea and also get reference where Pavel point us to formula
which could be used for computing voltage-to-percent conversion [2]

What about adding this formula as a default for the
voltage-to-percent-conversion to
the generic-adc-battery driver (and converting it to DT)? Would that
be a better solution than a table driven and twl4030 only driver?

[1] - http://www.serverphorums.com/read.php?12,1127548
[2] - https://lkml.org/lkml/2015/4/1/557

Many thanks.

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
