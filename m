From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Power management minisummit at LPC
Date: Mon, 19 Jul 2010 14:55:52 +0100
Message-ID: <20100719135552.GB15785__29549.7529012666$1279548031$gmane$org@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

I'm running a power management session at the Linux Plumbers Conference 
this year. Unlike most traditional conferences where the aim is to 
present new solutions, LPC focuses on discussing the problems that we 
haven't completely solved yet.

This has been an especially interesting year in the field. We've landed 
the infrastructure for generic runtime power management, glued that into 
PCI and started implementing that at the driver level. pm_qos is being 
reworked to improve performance and scalability as we start seeing more 
drivers that need to express their own constraints. And, of course, we 
had the wakelock/suspend blockers conversation that didn't end in a 
terribly satisfactory manner, although Rafael is now working on an 
implementation that presents equivalent functionality with a different 
userspace API. Runtime full-system suspend isn't solved yet either - the 
current cpuidle-based solution doesn't work well on multicore systems. 
And maybe we could be more aggressive still by looking at reclocking 
more system components on the fly even if the existing interfaces don't 
allow that. Do we have all the hooks we need to identify which system 
resources are being used? Are we doing the best we can in terms of 
avoiding trading off performance for power savings?

Head to 
http://www.linuxplumbersconf.org/2010/ocw/events/LPC2010MC/proposals to 
add a suggestion for a topic to be discussed at the miniconference. It's 
also possible to submit a proposal for the main presentation tyou have 
menrelated that you think would be appropriate for a wider audience, 
then please propose it there as well.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
