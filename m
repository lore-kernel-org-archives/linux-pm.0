From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Restore device name
Date: Tue, 2 Feb 2016 14:32:46 +0200
Message-ID: <56B0A1EE.4020907@gmail.com>
References: <1454415319-31380-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160202122756.GI4389@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37830 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbcBBMcv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 07:32:51 -0500
In-Reply-To: <20160202122756.GI4389@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org



On  2.02.2016 14:27, Pali Roh=C3=A1r wrote:
>
> Hi! Should not we call idr_remove() also in bq27xxx_battery_i2c_remov=
e()?
>

Yes, missed that code in the commit, I am sending the full version in a=
=20
minute
