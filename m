From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 0/4] Fix minor bq27x00 displeasures
Date: Wed, 7 Oct 2015 20:45:12 +0200
Message-ID: <4AB703FA-F03A-4D18-B3B8-139029315402@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:48585 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbJGSpO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:45:14 -0400
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org


Am 07.10.2015 um 20:42 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

> 1. bq27x00 driver may fill the log with messages about missing calibration:
> report only in debug mode
> 2. if bq27x00 is a w1/hdq slave the wrapper should modprobe to load
> bq27x00_battery.ko if compiled as a module.
> 
> Both patches improve system battery (co)operation on the GTA04.
> 
> H. Nikolaus Schaller (3):

Sorry, please forget the first two patches (was a mistake when send-emailing a subset).

>  restore bq27000 code of v4.3-rc4
>  restore w1 slave bq27000 code of v4.3-rc4
>  w1:slaves:bq27000: load battery driver kernel module if required
> 
> NeilBrown (1):
>  power:bq27x00: don't fill system log by missing battery
> 
> 
> -- 
> 2.5.1
> 

