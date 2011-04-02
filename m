From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/18] x86 idle APM: deprecate
	CONFIG_APM_CPU_IDLE
Date: Sat, 2 Apr 2011 12:28:10 +0100
Message-ID: <20110402122810.1371afa8__27060.4626894512$1301743734$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<392e1ffeeaefd448f69d45041fe4406fbd197852.1301724243.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <392e1ffeeaefd448f69d45041fe4406fbd197852.1301724243.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

> We don't want to export the pm_idle function pointer to modules.
> Currently CONFIG_APM_CPU_IDLE w/ CONFIG_APM_MODULE forces us to.

So you could jsut compile it in ...

> CONFIG_APM_CPU_IDLE is of dubious value, it runs only on 32-bit
> uniprocessor laptops that are over 10 years old.  It calls into
> the BIOS during idle, and is known to cause a number of machines
> to fail.

It also works on lots of desktops from that era, more of which are still
around.

> 
> Removing CONFIG_APM_CPU_IDLE and will allow us to stop exporting
> pm_idle.  Any systems that were calling into the APM BIOS
> at run-time will simply use HLT instead.

(which is btw what quite a few later APM implementations seem to do ;))


> +What:	CONFIG_APM_CPU_IDLE, and its ability to call APM BIOS in idle
> +When:	2.6.40

One release isn't enough time - it won't propagate out - you keep
rushing, hurrying and pushing at this trying to do it fast.

Why - its a sigle symbol export of minor ugliness, it doesn't justify the
amount of hatred you are expending upon it.

Give it a year, it doesn't cause any complexities I can see.
