From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/8] cpufreq: Extract non-interface related stuff from cpufreq_add_dev_interface
Date: Fri, 12 Jul 2013 12:47:56 +0530
Message-ID: <CAKohpo=VoWyJSKZt9DypmG16m14sAnJCWZ25F2d09heB8iK0iw@mail.gmail.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
	<20130711221623.547.5846.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130711221623.547.5846.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12 July 2013 03:46, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> cpufreq_add_dev_interface() includes the work of exposing the interface
> to the device, as well as a lot of unrelated stuff. Move the latter to
> cpufreq_add_dev(), where it is more appropriate.
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>  drivers/cpufreq/cpufreq.c |   43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
