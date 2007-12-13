From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9555] New: Suspend to RAM horks
 keyboard autorepeat, system bell, trackpad
Date: Wed, 12 Dec 2007 18:33:49 -0800
Message-ID: <20071212183349.f81464bf.akpm__26869.0375415192$1197513325$gmane$org@linux-foundation.org>
References: <bug-9555-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <bug-9555-10286@http.bugzilla.kernel.org/>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stable@kernel.org
Cc: akkzilla@shallowsky.com, Torokhov <dtor@mail.ru>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Dmitry@smtp2.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


(switching to email - please respond via emailed reply-to-all, not via the
bugzilla web interface)

On Wed, 12 Dec 2007 18:18:05 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9555
> 
>            Summary: Suspend to RAM horks keyboard autorepeat, system bell,
>                     trackpad
>            Product: Power Management
>            Version: 2.5
>      KernelVersion: 2.6.23.8
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>         ReportedBy: akkzilla@shallowsky.com
> 
> 
> Most recent kernel where this bug did not occur: 2.6.23.1
> Distribution: Ubuntu feisty
> Hardware Environment: Sony Vaio SR71
> Software Environment:
> Problem Description:
> 
> With 2.6.23.8, when I suspend to RAM (using /usr/sbin/hibernate -F
> /etc/hibernate/ram.conf) from within X, when I resume I see the following odd
> behavior:
> 
> 1. The system bell is now half a second long.
> 2. Keyboard autorepeat has a very long delay -- like 7 seconds before the first
> repeated character shows up.
> 3. If I configure X to use the (Alps) trackpad via the synaptics driver, after
> resuming, clicks from the trackpad don't work at all -- not only are taps
> ignored (which is how I've configured xorg.conf) but the physical buttons don't
> generate click events either. If I configure X to use the trackpad just as a
> PS/2 mouse, though, it still works normally after resuming.
> 
> 2.6.23.1 with the same .config (I took the .config from 23.8, copied it into
> the 23.1 directory, and ran make oldconfig) does NOT exhibit any of these
> problems -- it resumes from suspend normally and everything still works.
> 
> Steps to reproduce:
> Boot 2.6.23.8. Log in, start X, suspend, resume. Hold down the return key and
> observe no autorepeat (at least for a long time). echo ^G and hear the long
> bell. xorg.conf to test the trackpad part available upon request.
> 
> I will attach my .configs from 23.1 and 23.8. I've tried with and without
> evdev, and with and without tickless, so neither of those is to blame. I wanted
> to try turning off the synaptic driver, but it seems to be a mandatory part of
> the PS/2 mouse driver now. I'm happy to try other configuration options.
> 
> It's possible this is related to bug 7977, but that one is from 2.6.21 and is
> supposedly fixed now, and nobody there mentioned the keyboard or bell aspects.
> 

A regression in the -stable series.

IT'd be interesting to see if this has gone into 2.6.24-rc5 too.
