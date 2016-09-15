From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 0/8] Support =?UTF-8?B?SW50ZWzCrg==?= Turbo Boost Max
 Technology 3.0
Date: Thu, 15 Sep 2016 13:46:23 +0100
Message-ID: <20160915134623.57596f86@lxorguk.ukuu.org.uk>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
        <20160915121430.GD13132@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52416 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933842AbcIOMsF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 08:48:05 -0400
In-Reply-To: <20160915121430.GD13132@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com

On Thu, 15 Sep 2016 14:14:30 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > - Feature is enabled by default for single socket systems
> > 
> > With Intel® Turbo Boost Max Technology 3.0 (ITMT), single-threaded performance is
> > optimized by identifying processor's fastest core and running critical workloads
> > on it.
> > Refere to:
> > http://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-max-technology.html  
> 
> That does not really explain much.
> 
> How does it work? Do the different cores have different max
> frequencies due to manufacturing differences? Ot is it running the
> workload on coldest core?

That's all down to the CPU, not architectural and may change.

The ACPI tables describe which cores to use, whether that relates to
manufacturing, positioning or whatever isn't exposed.

Alan
