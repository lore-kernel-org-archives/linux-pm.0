From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.19-rc1 regression: airo suspend fails
Date: Fri, 6 Oct 2006 20:47:07 +0200
Message-ID: <20061006184706.GR16812@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <871wpmoyjv.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871wpmoyjv.fsf@sycorax.lbl.gov>
Sender: netdev-owner@vger.kernel.org
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com, netdev@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 05, 2006 at 09:31:16PM -0700, Alex Romosan wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > so please give it a good testing, and let's see if there are any 
> > regressions.
> 
> it breaks suspend when the airo module is loaded:
> 
> kernel: Stopping tasks: =================================================================================
> kernel:  stopping tasks timed out after 20 seconds (1 tasks remaining):
> kernel:   eth1
> kernel: Restarting tasks...<6> Strange, eth1 not stopped
> 
> if i remove the airo module suspend works normally (this is on a
> thinkpad t40).

Thanks for your report.

Let's try to figure out what broke it.

As a first step, please replace drivers/net/wireless/airo.c with the 
version in 2.6.18 and check whether this fixes the issue (you can ignore 
the deprecated warning during compilation).

> --alex--

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

