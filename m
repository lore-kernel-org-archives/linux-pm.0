From: Sean Cross <xobs@kosagi.com>
Subject: Re: Freescale IMX6 active cooling
Date: Wed, 18 Nov 2015 12:53:39 +0800
Message-ID: <564C0453.6020400@kosagi.com>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
 <CAOMZO5AX9owvovpdmdr=rKNApbuNrkp9pKexJk_mMyMdH1=1qg@mail.gmail.com>
 <CALHpu37MNnzW=3YNKUq-aOHgF12EhjyN7g1juTwuMad_Xv891w@mail.gmail.com>
 <CABH3fy-QPV1bv-WaO3mWVq2RN5=f-AnBHMgFTmmU-Ve3xgyUrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40076 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870AbbKRExp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 23:53:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7EECB20435
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 23:53:44 -0500 (EST)
In-Reply-To: <CABH3fy-QPV1bv-WaO3mWVq2RN5=f-AnBHMgFTmmU-Ve3xgyUrw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Crenguta <catalin.crenguta@gmail.com>, Jon Nettleton <jon.nettleton@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On 17/11/2015 8:49 PM, Catalin Crenguta wrote:
> On Tue, Nov 17, 2015 at 11:38 AM, Jon Nettleton <jon.nettleton@gmail.com> wrote:
>> I would recommend you take a look at the work that xobs did for the
>> Novena Heirloom.  If you look at this branch starting around Aug 3 you
>> can see where he has converted iMX6 to use generic thermal zones and
>> adds support for for an active cooling device/fan.
>> https://github.com/xobs/novena-linux/commits/v3.19-novena-etnadrm-r3?page=3
>>
>> -Jon
> Thank you!
> I have patched my 4.3 kernel (they don't apply cleanly but they are
> straight forward to modify), added a gpio-fan and the corresponding
> thermal-zone in my DTB and it works!
> Sean Cross, are you interested in bringing this to mainline?
Yes, this does seem like the sort of thing that should make it into 
mainline.

Would you like me to submit it as a patch against 4.3?  I'm unclear how 
much should be added.

For example, the current code talks directly to the cpufreq cooling 
system, but that becomes unnecessary if using generic thermal zones, 
since the zones will bind cpufreq to the thermal sensor.  Then again, 
with such a patch, boards that do not explicitly update their device 
tree to support generic thermal zones will need to have their entries 
updated.

Perhaps the correct order of patches is:

1) Add generic thermal zone support
2) Remove zone and cdev from imx_thermal
3) Add cpufreq-cooling to imx6
4) Add cpufreq-cooling to all other SoCs that support imx_thermal
5) Add default generic thermal zone support to imx6qdl.dtsi

Comments on how it should be handled?


Sean
