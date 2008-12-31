From: Dmitry Nezhevenko <dion@inhex.net>
Subject: Re: [TuxOnIce-users] Shutdown troubles (probably about
	nvidia)
Date: Wed, 31 Dec 2008 18:28:19 +0200
Message-ID: <20081231162819.GA8802__39764.6913458177$1230741206$gmane$org@laptop.local>
References: <20081231084723.GA13285@laptop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081231084723.GA13285@laptop.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tuxonice-users@lists.tuxonice.net
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 31, 2008 at 10:47:23AM +0200, Dmitry Nezhevenko wrote:
> Hi guys. It looks like recent NVIDIA proprietary drivers (and now more
> often than usually) sometimes don't allow my laptop to shutdown after
> hibernate.
> 
> I've tried both S4 and S5. Just after writing RAM content to disk kernel
> prints "Power down." message and freezes. Something like old AT cases
> where power should be turned off by hands. So I need to press power button
> for 4-5 seconds to shutdown machine. During next boot it resumes
> correctly. 
> 
> Currently I configured xorg to use "nv" driver. Looks like it works
> correctly. Maybe anybody have some idea and/or workaround?
> 
> PS. Kernel 2.6.28, latest TuxOnIce, downloaded as patch, nvidia driver
> v180.18.
> 
 
I've spent a bit more with debugging this issue. Currently I know
followed:

1. Same happens without ToI using mainline hibernation

2. I've reproduced it once without nvidia proprietary module (using nv),
however it happens too rarely.

3. It hangs in infinite loop at drivers/acpi/hardware/hwsleep.c:

        do {
                status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
                if (ACPI_FAILURE(status)) {
                        return_ACPI_STATUS(status);
                }
        } while (!in_value);

(verified by adding printk())

This looks like hardware/bios bug, however there was no such problem in
times of 2.6.25 kernel (with and without nvidia proprietary module)

Hardware is MSI M673 laptop. Any ideas? Maybe some workaround? Bisecting
is too difficult and almost impossible.

-- 
WBR, Dmitry
