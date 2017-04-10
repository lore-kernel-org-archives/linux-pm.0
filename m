From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()
Date: Mon, 10 Apr 2017 13:11:46 +0200
Message-ID: <20170410111146.ggqjyibnqszxzkq4@linutronix.de>
References: <20170404154957.19678-1-bigeasy@linutronix.de>
 <20170410103153.GK24555@vireshk-i7>
 <20170410110511.GE24214@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdDJLLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 07:11:50 -0400
Content-Disposition: inline
In-Reply-To: <20170410110511.GE24214@linux-mips.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, wuzhangjin@gmail.com, linux-mips@linux-mips.org, tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 2017-04-10 13:05:11 [+0200], Ralf Baechle wrote:
> I noticed some of the other cpufreq drivers seem to be using similar
> constructs.

Don't worry, we are working on that.

>   Ralf

Sebastian
