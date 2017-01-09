From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Preventing PM from suspending device
Date: Mon, 9 Jan 2017 18:22:47 +0100
Message-ID: <20170109172247.GI29854@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:32987 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968442AbdAIRWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 12:22:50 -0500
Received: by mail-lf0-f43.google.com with SMTP id k86so99116777lfi.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 09:22:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Hi Ulf and Linux PM,

I have a question regarding if a driver can signal to the PM core that 
it should not be suspended from its struct dev_pm_ops suspend callback.

My use-case is the sh_eth driver which I have added Wake-on-Lan support 
to, see [1]. In this driver I need to prevent the PM core to disable the 
module clock to the device if WoL is enabled. Currently I call 
clk_enable()/clk_disable() from the suspend/resume callbacks to modify 
the usage count of the clock to prevent the clock from being switched 
off by PM. This do not feel like the best solution to my problem.

Is there a more generic way to let PM know that I'm fine with the system 
being suspended and I have suspended as much as I can but I'm a wake up source 
so could please not switch of my clock and power domain?

1. https://marc.info/?l=linux-pm&m=148397620011501&w=2

-- 
Regards,
Niklas Söderlund
