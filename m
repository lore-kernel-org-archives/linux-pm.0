From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Null suspend/resume functions
Date: Tue, 24 Nov 2009 12:57:33 +0100
Message-ID: <20091124115733.GB1397@ucw.cz>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com> <20091109105858.GB1245@sirena.org.uk> <20091109133136.GC1245@sirena.org.uk> <20091116153000.GB29479@sirena.org.uk> <20091117115236.GB1376@ucw.cz> <20091117124125.GD823@rakim.wolfsonmicro.main> <20091118160908.GD20887@elf.ucw.cz> <20091119112102.GF9763@rakim.wolfsonmicro.main> <20091121234509.GC1411@ucw.cz> <20091123110236.GB24326@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932388AbZKXMQk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091123110236.GB24326@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > So you place a comment there; it should be there anyway. Having nop
> > during suspend/resume *is* unusual, and it should raise red flags.
> 
> This isn't a good assumption here.  Remember that this is for runtime PM
> so if we're getting as far as these calls then the driver has already
> told the core that it is idle, which probably means that the hardware is
> already quieseced.  For a lot of hardware that will mean that the

Ok, I did not realize we were talking runtime pm here.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
