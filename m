From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH v1] power: bq27xxx_battery: Restore device name
Date: Tue, 2 Feb 2016 14:37:44 +0200
Message-ID: <56B0A318.9060306@gmail.com>
References: <20160202122756.GI4389@pali>
 <1454416458-2541-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36666 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbcBBMhs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 07:37:48 -0500
In-Reply-To: <1454416458-2541-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: pali.rohar@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Guys, sorry for the noise, I got flue over my brain. This patch is 
broken too, will fix it and will resend.

On  2.02.2016 14:34, Ivaylo Dimitrov wrote:
> Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power: bq27xxx_battery:
>   Reorganize I2C into a module") has removed the device name numbering from
> bq27xxx_battery_i2c_probe. Fix that by restoring the code.
>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/power/bq27xxx_battery_i2c.c | 36 +++++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
>
