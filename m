From: Len Brown <lenb@kernel.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 16:00:44 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101211550190.3924__45768.7015565627$1295643782$gmane$org@x980>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

> and here's the one that failed and then ended up coming back on a keypress:
> 
>   ...
>   [   54.628375] PM: Saving platform NVS memory
>   [   54.628387] Disabling non-boot CPUs ...
>   [   63.554966] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
> for [EmbeddedControl] (20110112/evregion-474)
>   [   63.554992] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC0_.RCTP] (Node f5c2dea0), AE_BAD_PARAMETER
> (20110112/psparse-536)
>   [   63.555022] ACPI Error: Method parse/execution failed
> [\_TZ_.RTMP] (Node f5c32fa8), AE_BAD_PARAMETER (20110112/psparse-536)
>   [   63.555047] ACPI Error: Method parse/execution failed
> [\_TZ_.TZ00._TMP] (Node f5c34018), AE_BAD_PARAMETER
> (20110112/psparse-536)
>   [   63.555079] Thermal: failed to read out thermal zone 0
>   [   63.556361] CPU 1 is now offline
>   [   63.556944] PM: Restoring platform NVS memory
>   [   63.556944] Enabling non-boot CPUs ...
>   [   63.556944] Booting Node 0 Processor 1 APIC 0x1
>   [   63.556279] Initializing CPU#1
>   ...
> 
> which really doesn't tell me much, except that clearly something in
> ACPI-land is unhappy, and it looks thermal-related (that last error
> message comes from thermal_zone_device_update()).

The thermal code failed to get the current
temperature (via AML "_TMP" method) because
the embedded controller (or our interface to it) malfunctioned.
Likely the suspend issue has nothing to do with thermal per se,
and thermal is effectively pointing out to us that the EC is unhappy.

Failures associated with the embedded controller are now
by far the largest portion of unsolved mysteries
in the Linux ACPI implementation and we need to focus
on the EC in 2011.

-Len Brown, Intel Open Source Technology Center
