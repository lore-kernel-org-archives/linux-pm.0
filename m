From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Tue, 17 Apr 2007 17:27:56 +0800
Message-ID: <1176802076.6227.2.camel@daplas>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	 <200704160823.39074.marcus@better.se> <1176705924.5129.1.camel@daplas>
	 <200704171017.07012.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753077AbXDQJ2M@vger.kernel.org>
In-Reply-To: <200704171017.07012.marcus@better.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Better <marcus@better.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz, linux-pm@lists.osdl.org, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-04-17 at 10:17 +0200, Marcus Better wrote:
> > Have you tried other combinations?
> >
> > s2ram -m -p -f
> > s2ram -s -p -f
> 
> Yes, I tried these slightly different combinations:
> 
> s2ram -f -a3 -s: Works! The screen becomes green but is restored quickly. It 
> prints the following messages:
> Allocated buffer at 0x11000 (base is 0x0)
> ES: 0x1100 EBX: 0x0000
> Save video state failed
> Calling restore_state_from
> Function not supported?
> Restore video state failed
> Switching back to vt1
> 
> s2ram -f -a3 -p: Screen goes green and then blank. Everything hangs, doesn't 
> react to keyboard input.
> 
> s2ram -f -a3 -m: Works!
> 

Thanks.  Should we consider this regression resolved?  There is really
nothing much vesafb can do to restore its previous state, except through
the use of userland tools.

Tony
