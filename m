From: Thomas Renninger <trenn@suse.de>
Subject: Re: idle-test patches queued for upstream
Date: Thu, 27 May 2010 10:45:33 +0200
Message-ID: <201005271045.33500.trenn__36649.5349015624$1274949952$gmane$org@suse.de>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274928151-30919-1-git-send-email-lenb@kernel.org>
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
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 27 May 2010 04:42:23 Len Brown wrote:
> Please look over and test this patch set.
> (If you test linux-next, you already have it)
> 
> There are a few simple patches, leading up to a new intel_idle driver.
> 
> Note that you can get the patch series as a single patch here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/idle/patches/2.6.34/idle-test-2.6.34.diff.gz
> 
> or pull from this git branch
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idle-test
> 
> Both are vs 2.6.34.
> 
> Why is it good to have a native intel_idle driver?
> 
> Basically, we think we can do better than ACPI.
Why exactly? Is there any info missing in the ACPI tables?
Or is this just to be more independent from OEMs?

> Indeed, on my (production level commerically available) Nehalem desktop
> the ACPI tables are broken and an ACPI OS idles at 100W.  With this
> driver the box idles at 85W.
What exactly was broken there?

IMO this is a step backward.
CPUfreq runs rather well on nearly every machine supporting it without
tons of static frequency tables in kernel. Even powernow-k8 might get merged
into acpi-cpufreq.

Intel set up a huge ACPI API for this and now it's not used anymore?!?
Will these parts get obsoleted in a future spec?
While for C-states there are not that many static entries needed, another
drawback could be that OEMs will disable/hide C-states on purpose.

Using ACPI table based C-states by default and using intel_idle.enable=1
or similar for workarounds sounds safer.
At least as long as the driver is experimental.

Does Windows use ACPI C-state info for idle?

Thanks,

   Thomas
