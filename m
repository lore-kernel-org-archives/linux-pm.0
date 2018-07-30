From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/2] ata: ahci: Enable DEVSLP by default on SLP_S0
 support
Date: Mon, 30 Jul 2018 07:10:52 -0700
Message-ID: <20180730141052.GB1206094@devbig004.ftw2.facebook.com>
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: hdegoede@redhat.com, rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 27, 2018 at 01:47:01PM -0700, Srinivas Pandruvada wrote:
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> This series is to enable DEVSLP by default.

Applied to 1-2 to libata/for-4.19.

Thanks.

-- 
tejun
