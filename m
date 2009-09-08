From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Machine resumes straight after suspend to RAM (or
	disk)
Date: Tue, 8 Sep 2009 21:38:15 +0200
Message-ID: <200909082138.15312.rjw__49893.2055350908$1252438739$gmane$org@sisk.pl>
References: <b2cdc9f30909081157r3087f707ve3a0cff77f46941a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b2cdc9f30909081157r3087f707ve3a0cff77f46941a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alex Bennee <kernel-hacker@bennee.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 September 2009, Alex Bennee wrote:
> Hi,
> 
> I thought I'd enable suspend and resume on my desktop machine so I
> could save myself some time in the morning when I restart the machine.
> The machine is fairly standard Intel Core Duo based system (lspci
> attached). However when I execute pm-suspend (or Gentoo's own
> hibernate-script) the system does suspend but resumes immediately. To
> add insult to injury the ethernet doesn't come back properly and needs
> a reboot to reset it.
> 
> I've played about a little with the ACPI debug stuff but it's easy to
> overflow the dmesg buffer. The relevant section around the
> suspend/resume looks like:
> 
> [ 1025.178019] Disabling non-boot CPUs ...
> [ 1025.182071] kvm: disabling virtualization on CPU1
> [ 1025.227729] CPU 1 is now offline
> [ 1025.227731] SMP alternatives: switching to UP code
> [ 1025.232627] CPU0 attaching NULL sched-domain.
> [ 1025.232630] CPU1 attaching NULL sched-domain.
> [ 1025.232634] CPU0 attaching NULL sched-domain.
> [ 1025.232771] CPU1 is down
> [ 1025.233264] acpi_suspend_enter acpi_state=3
> [ 1025.233276] evgpeblk-0144 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Entry
> [ 1025.233286] evgpeblk-0178 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Exit- AE_OK
> [ 1025.233290] evgpeblk-0144 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Entry
> [ 1025.233299] evgpeblk-0178 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Exit- AE_OK
> [ 1025.233303] evgpeblk-0144 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Entry
> [ 1025.233311] evgpeblk-0178 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Exit- AE_OK
> [ 1025.233315] evgpeblk-0144 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Entry
> [ 1025.233319] evgpeblk-0178 [ffff8800b70d8000] [05] ev_walk_gpe_list
>     : ----Exit- AE_OK
> [ 1025.233319] evxfevnt-0074 [ffff8800b70d8000] [05] enable
>     : ----Entry
> [ 1025.233319] evxfevnt-0086 [ffff8800b70d8000] [05] enable
>     : System is already in ACPI mode
> [ 1025.233319] evxfevnt-0101 [ffff8800b70d8000] [05] enable
>     : ----Exit- AE_OK
> [ 1025.233319] evxfevnt-0397 [ffff8800b70d8000] [05] clear_event
>     : ----Entry
> [ 1025.233319] evxfevnt-0413 [ffff8800b70d8000] [05] clear_event
>     : ----Exit- AE_OK
> [ 1025.233319] evxfevnt-0831 [ffff8800b70d8000] [05] disable_all_gpes
>     : ----Entry
> [ 1025.233319] evgpeblk-0144 [ffff8800b70d8000] [07] ev_walk_gpe_list
>     : ----Entry
> [ 1025.233319] evgpeblk-0178 [ffff8800b70d8000] [07] ev_walk_gpe_list
>     : ----Exit- AE_OK
> [ 1025.233319] evgpeblk-0144 [ffff8800b70d8000] [07] ev_walk_gpe_list
>     : ----Entry
> [ 1025.233319] evgpeblk-0178 [ffff8800b70d8000] [07] ev_walk_gpe_list
>     : ----Exit- AE_OK
> [ 1025.233319] evxfevnt-0841 [ffff8800b70d8000] [05] disable_all_gpes
>     : ----Exit- AE_OK
> [ 1025.233319] Back to C!
> [ 1025.233319] CPU0: Thermal LVT vector (0xfa) already installed
> [ 1025.233319] Enabling non-boot CPUs ...
> [ 1025.233319] SMP alternatives: switching to SMP code
> [ 1025.237548] Booting processor 1 APIC 0x1 ip 0x6000
> [ 1025.232536] Initializing CPU#1
> [ 1025.232536] Calibrating delay using timer specific routine..
> 4245.78 BogoMIPS (lpj=8491564)
> 
> Unfortunately the ACPI stuff is all Greek to me. If anyone wants
> additional debug information then please let me know.
> 
> So any ideas?

What's in /proc/acpi/wakeup after a clean boot?

Rafael
