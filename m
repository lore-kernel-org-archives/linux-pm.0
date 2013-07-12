From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/8] cpufreq: Extract the handover of policy cpu to a
 helper function
Date: Fri, 12 Jul 2013 12:49:21 +0530
Message-ID: <CAKohpo=eo5KAjE6Nk32aLJ3-KZZ4Ge-mm+hB1-gUMk+ZDF8iqw@mail.gmail.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
	<20130711221644.547.74786.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130711221644.547.74786.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12 July 2013 03:46, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> During cpu offline, when the policy->cpu is going down, some other CPU
> present in the policy->cpus mask is nominated as the new policy->cpu.
> Extract this functionality from __cpufreq_remove_dev() and implement
> it in a helper function. This helps in upcoming code reorganization.
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>  drivers/cpufreq/cpufreq.c |   62 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 24 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
