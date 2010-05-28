From: Thomas Renninger <trenn@suse.de>
Subject: Re: idle-test patches queued for upstream
Date: Fri, 28 May 2010 10:07:34 +0200
Message-ID: <201005281007.34706.trenn__18033.192624762$1275034073$gmane$org@suse.de>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<201005271045.33500.trenn@suse.de>
	<alpine.LFD.2.00.1005272023510.24823@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005272023510.24823@localhost.localdomain>
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
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 28 May 2010 02:59:07 Len Brown wrote:
> > > ... we think we can do better than ACPI.
> 
> > Why exactly? Is there any info missing in the ACPI tables?
> > Or is this just to be more independent from OEMs?
> 
> ACPI has a few fundmental flaws here.  One is that it reports
> exit latency instead of break-even power duration.
> The other is that it requires a BIOS writer to
> get the tables right.
This is a general ACPI problem...
 
> > Using ACPI table based C-states by default and using
> > intel_idle.enable=1
> > or similar for workarounds sounds safer.
> > At least as long as the driver is experimental.
> 
> I plan to remove the EXPERIMENTAL in 1 release.
> 
> > Does Windows use ACPI C-state info for idle?

> Yes, Windows uses ACPI.
> On the Dell above, that is why Linux consumes 15% less idle power
> and why Linux can take advantage of turbo mode and Windows can not.
You always propageted to stay Windows compatible...
Now we go the untested way.
Let's see how much machines will break...

Thanks for clarifications,

    Thomas
