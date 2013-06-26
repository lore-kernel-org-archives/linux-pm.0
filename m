From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Wed, 26 Jun 2013 16:02:37 +0200
Message-ID: <20130626160237.659f9b1d@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-3-git-send-email-l.majewski@samsung.com>
 <CAKohpon7GLGvrkFQdWpco5f9P7S8L-2-ETMu2-3dFEDwOgL1RQ@mail.gmail.com>
 <20130626145412.1e9bfa63@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63185 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3FZOCr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 10:02:47 -0400
In-reply-to: <20130626145412.1e9bfa63@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, t.figa@samsung.com

On Wed, 26 Jun 2013 14:54:12 +0200, Lukasz Majewski wrote:
> > >
> > > +int cpufreq_boost_trigger_state(int state);  
> > 
> > Why is this present here?  
> 
> We had agreed to talk only about cpufreq :-).
> 
> This declaration will be removed.

Correction:

This declaration is needed for allowing disabling cpufreq boost at
thermal subsystem (please refer to [PATCH v4 7/7]).


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
