From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] OpPoint summary
Date: Mon, 18 Sep 2006 15:46:46 +0200
Message-ID: <20060918134646.GF5370@elf.ucw.cz>
References: <200609181336.k8IDa7xp025747@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751629AbWIRNqw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200609181336.k8IDa7xp025747@olwen.urbana.css.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

H!

> | > +static struct oppoint lowest = {
> | > +       .name = "lowest",
> | > +       .type = PM_FREQ_CHANGE,
> | > +       .frequency = 0,
> | > +       .voltage = 0,
> | > +       .latency = 15,
> | > +       .prepare_transition  = cpufreq_prepare_transition,
> | > +       .transition = centrino_transition,
> | > +       .finish_transition = cpufreq_finish_transition,
> | > +};
> | 
> | We had nice, descriptive interface... with numbers. Now you want to
> | introduce english state names... looks like a step back to me.
> ---
> 
> Well, a single number is fine if you're describing a scalar abstraction,
> but an operating point is a vector. You can't assume that "399" is three
> times "133" in performance or energy cost, so its "numberness" is simply
> misleading.

"lowest" can simply be mapped to "0", with "low" mapped to "1",
etc.

I believe, using english names is wrong in this case. If you want to
provide vectors... well provide the vectors. Is "medium" operating
point 1GHz on cpu 0 and 2GHz on cpu 1, or is it 1.5 ghz on cpu 0 and
1.5 ghz on cpu 1?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
