From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/2] Add stop callback to the cpufreq_driver interface.
Date: Wed, 19 Mar 2014 15:25:18 +0100
Message-ID: <1695232.OUkyIH60d4@vostro.rjw.lan>
References: <1394831037-15553-1-git-send-email-dirk.j.brandewie@intel.com> <2106941.8EeNr4veQS@vostro.rjw.lan> <CAKohpomkFQ0PhYja8eKC_NvX+Jc7JpDp8gpHFCDHWeeUQADwcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53040 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933380AbaCSOJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Mar 2014 10:09:48 -0400
In-Reply-To: <CAKohpomkFQ0PhYja8eKC_NvX+Jc7JpDp8gpHFCDHWeeUQADwcQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Patrick Marlier <patrick.marlier@gmail.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>

On Wednesday, March 19, 2014 07:19:13 PM Viresh Kumar wrote:
> On 19 March 2014 19:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Let's add ->stop() (or whatever to call it) *specifically* for ->setpolicy
> > drivers
> 
> setpolicy_stop() ? I know that's a bad name :)

Well, what about ->stop_cpu()?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
