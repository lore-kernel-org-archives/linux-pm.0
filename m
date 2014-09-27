From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/cpufreq/cpufreq.c:370
Date: Sat, 27 Sep 2014 08:14:46 +0200
Message-ID: <1411798486.5097.46.camel@marge.simpson.net>
References: <20140924081845.572814794@infradead.org>
	 <1411712697.6005.7.camel@marge.simpson.net>
	 <1411718040.6005.18.camel@marge.simpson.net>
	 <2457441.tHFXzSCneW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2457441.tHFXzSCneW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2014-09-27 at 00:44 +0200, Rafael J. Wysocki wrote:

> Shouldn't that be pcc-cpufreq.c rather?

Yeah, silly mouse copy/pasted the wrong gitk bits.

> Also moving the spin_lock(&pcc_lock) after the cpufreq_freq_transition_begin()
> should fix the problem too (like the below).  Have you tried that?

Have now.  Yup, works and is prettier.

-Mike
