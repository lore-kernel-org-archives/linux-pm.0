From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: BISECTED: 2.6.29-rc2 regression: hibernation hang on
	eeepc-701
Date: Thu, 22 Jan 2009 11:30:41 +0000
Message-ID: <497858E1.5070303__26094.0305576243$1232624171$gmane$org@tuffmail.co.uk>
References: <9b2b86520901180345j434eacbdn7386958991ee50b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b2b86520901180345j434eacbdn7386958991ee50b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Jesse
List-Id: linux-pm@vger.kernel.org

Alan Jenkins wrote:
> Hibernation hangs just after writing the image.  With s2disk I can see
> this from the console messages.  The same hang happens with kernel
> swsusp ('echo disk | sudo tee /sys/power/state'), and I can see that
> the image has been written from the HDD led.
>
> In either case, I can still hard-power-off and resume from hibernation.
>
> It doesn't hang if I use the shutdown method (either 'echo shutdown |
> sudo tee /sys/power/disk' or  's2disk -P "shutdown method=shutdown"').
>   

I've bisected this to commit 571ff7584bb9e05fca0eb79752ae55a46faf3a98. 
It doesn't revert cleanly from RC2.

I think it's distinct from the other two reported suspend regressions. 
I'm not using acpi-cpufreq, and the issue doesn't affect resume.

Alan


commit 571ff7584bb9e05fca0eb79752ae55a46faf3a98
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Wed Jan 7 13:05:05 2009 +0100

    PCI PM: Power-manage devices without drivers during suspend-resume

    PCI devices without drivers can be put into low power states during
    suspend with the help of pci_prepare_to_sleep() and prevented from
    generating wake-up events during resume with the help of
    pci_enable_wake().  However, it's better not to put bridges into
    low power states during suspend, because that might result in entire
    bus segments being powered off.

    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

:040000 040000 6b6fb7bfa561583f14bdf55b084473dcf9cd1765
d72fbda87eff26db8f2574e868a793b79deb9f92 M      drivers
