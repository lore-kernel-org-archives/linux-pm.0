From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] OpPoint summary
Date: Mon, 18 Sep 2006 08:36:07 -0500 (CDT)
Message-ID: <200609181336.k8IDa7xp025747@olwen.urbana.css.mot.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964960AbWIRNg3@vger.kernel.org>
In-reply-to: Pavel Machek's message of Sun, 17 Sep 2006 19:48:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


| From: Pavel Machek<pavel@ucw.cz>
| 
| Hi!
| 
| > >Care to resend your patches in the proper format, through email so that
| > >we can see them, and possibly get some testing in -mm if they look sane?
| > 
| > Greg,
| >   here's the patch that implements operating points for different 
| >   frequencies
| > for the speedstep-centrino line of processors.  Operating points are created
| > in much the same manner that cpufreq tables are.  This works for both
| > simple implementations like the centrino and more complex SoC systems
| > like the arm-pxa72x which has several clocks to control, and different clock
| > divisors and multipliers.
| 
| > +static struct oppoint lowest = {
| > +       .name = "lowest",
| > +       .type = PM_FREQ_CHANGE,
| > +       .frequency = 0,
| > +       .voltage = 0,
| > +       .latency = 15,
| > +       .prepare_transition  = cpufreq_prepare_transition,
| > +       .transition = centrino_transition,
| > +       .finish_transition = cpufreq_finish_transition,
| > +};
| 
| We had nice, descriptive interface... with numbers. Now you want to
| introduce english state names... looks like a step back to me.
---

Well, a single number is fine if you're describing a scalar abstraction,
but an operating point is a vector. You can't assume that "399" is three
times "133" in performance or energy cost, so its "numberness" is simply
misleading.

scott

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
