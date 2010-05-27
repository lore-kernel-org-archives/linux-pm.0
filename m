From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
	driver for select intel processors
Date: Thu, 27 May 2010 10:53:30 +0200
Message-ID: <201005271053.31087.trenn__35121.1390029222$1274950504$gmane$org@suse.de>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 27 May 2010 04:42:31 Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
... 
> CONFIG_INTEL_IDLE=m is not recommended unless the system
> has a method to guarantee intel_idle loads before ACPI's
> processor_idle.
Then it should better be declared bool instead of tristate until it
works.

> This driver does not yet know about cpu online/offline
> and thus will not yet play well with cpu-hotplug.
What means does not play well yet, suspend or manually offlining a core 
will eventually (for sure?) hang the machine?

If this is known broken, should this already be spread through
linux-next?

    Thomas
