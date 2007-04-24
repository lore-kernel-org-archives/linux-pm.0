From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Tue, 24 Apr 2007 15:33:13 +0000
Message-ID: <20070424153312.GB6055@ucw.cz>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org> <200704160823.39074.marcus@better.se> <1176705924.5129.1.camel@daplas> <200704171017.07012.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753589AbXDXPd0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200704171017.07012.marcus@better.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Better <marcus@better.se>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.osdl.org, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Have you tried other combinations?
> >
> > s2ram -m -p -f
> > s2ram -s -p -f
> 
> Yes, I tried these slightly different combinations:
> 
> s2ram -f -a3 -s: Works! The screen becomes green but is restored quickly. It 
> prints the following messages:

Uhuh. This is second report of this strangeness. On thinkpad r60, -a3
used to work, and now it needs more options. Can you locate patch
causing this?
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
