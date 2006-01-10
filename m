From: Adrian Bunk <bunk@stusta.de>
Subject: SOFTWARE_SUSPEND: dependency on non-existing FVR symbol
Date: Tue, 10 Jan 2006 05:36:27 +0100
Message-ID: <20060110043627.GD3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751206AbWAJEg3@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
List-Id: linux-pm@vger.kernel.org

The following issue in kernel/power/Kconfig was noted by
Jean-Luc Leger <reiga@dspnet.fr.eu.org>:

config SOFTWARE_SUSPEND
        bool "Software Suspend"
        depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)


The problem is that there is no FVR symbol in the kernel.

Is this a misspelling of FRV or something different?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
