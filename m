From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] Add exit_prepare callback to the cpufreq_driver interface.
Date: Wed, 19 Mar 2014 10:33:59 +0530
Message-ID: <CAKohpomLW17B=Sk42tczzDF+VGwn7hT521osWPi5TcgqpCPZ_w@mail.gmail.com>
References: <1394732168-12638-1-git-send-email-dirk.j.brandewie@intel.com>
	<CAKohponGN4JNwLKLjvFOPkru0=6JajOKKH=oJneDkKp=PyAmRA@mail.gmail.com>
	<53234A70.70506@gmail.com>
	<53656551.Rzgh2mDLCG@vostro.rjw.lan>
	<53283913.1070003@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53283913.1070003@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.brandewie@gmail.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patrick Marlier <patrick.marlier@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18 March 2014 17:46, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Agreed. As far as I understand, for ->target drivers, today we use GOV_STOP
> to stop managing the CPU going offline. And for ->setpolicy drivers, we will
> use this new callback to achieve the same goal.

So a better question would be: What's the purpose of ->stop() call for a policy?
Stop managing CPUs of that policy? Or even do something on CPUs of a policy
before CPUs are offlined?

Probably in the current solution Dirk is doing both these things..

And so I thought maybe its better not to restrict ->stop() to just
setpolicy() drivers.
