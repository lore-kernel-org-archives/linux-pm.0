From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 00/10] Energy Aware Scheduling
Date: Fri, 1 Jun 2018 10:29:33 +0100
Message-ID: <20180601092933.GA3082@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

The main new feature of this patch-set is the Energy Model framework we
discussed at OSPM. The core of it and the APIs are all implemented in
patch 03/10, so this is really where I was hoping to get some feedback.
Is the overall idea of this framework reasonable ? What do you think
about the interfaces ? Is the new config option acceptable ? And also,
is there any way I can make reviewing this patch easier ?

Thanks!
Quentin
