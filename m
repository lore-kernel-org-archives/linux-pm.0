From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 0/8] Support =?ISO-8859-1?Q?Intel=AE?= Turbo Boost
 Max Technology 3.0
Date: Fri, 16 Sep 2016 09:03:47 -0700
Message-ID: <1474041827.3916.92.camel@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <20160915121430.GD13132@amd> <20160915134623.57596f86@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1380 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965037AbcIPQDt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Sep 2016 12:03:49 -0400
In-Reply-To: <20160915134623.57596f86@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 2016-09-15 at 13:46 +0100, One Thousand Gnomes wrote:
> On Thu, 15 Sep 2016 14:14:30 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > 
> > Hi!
> > 
> > > 
> > > - Feature is enabled by default for single socket systems
> > > 
> > > With Intel® Turbo Boost Max Technology 3.0 (ITMT), single-threaded performance is
> > > optimized by identifying processor's fastest core and running critical workloads
> > > on it.
> > > Refere to:
> > > http://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-max-technology.html  
> > That does not really explain much.
> > 
> > How does it work? Do the different cores have different max
> > frequencies due to manufacturing differences? Ot is it running the
> > workload on coldest core?
> That's all down to the CPU, not architectural and may change.
> 
> The ACPI tables describe which cores to use, whether that relates to
> manufacturing, positioning or whatever isn't exposed.

Please refer to patches 
acpi: Enable HWP CPPC objects 
acpi: bus: Set _OSC for diverse core support
cpufreq: intel_pstate: Use CPPC to get max performance

for how the differences in core's capabilities are exposed to OS.

The asymmetric packing feature in the scheduler defines an
order of which core should be scheduled with a load first.
By using this feature, we can put load first on 
the core that can be boosted to the highest
frequency.

Tim
