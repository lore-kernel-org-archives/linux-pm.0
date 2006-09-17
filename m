From: Pavel Machek <pavel@ucw.cz>
Subject: Re: OpPoint summary
Date: Sun, 17 Sep 2006 19:48:35 +0200
Message-ID: <20060917174835.GA2225@elf.ucw.cz>
References: <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912033700.GD27397@kroah.com> <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com> <20060914055529.GA18031@kroah.com> <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965110AbWIQVTT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Singleton <daviado@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >Care to resend your patches in the proper format, through email so that
> >we can see them, and possibly get some testing in -mm if they look sane?
> 
> Greg,
>   here's the patch that implements operating points for different 
>   frequencies
> for the speedstep-centrino line of processors.  Operating points are created
> in much the same manner that cpufreq tables are.  This works for both
> simple implementations like the centrino and more complex SoC systems
> like the arm-pxa72x which has several clocks to control, and different clock
> divisors and multipliers.

> +static struct oppoint lowest = {
> +       .name = "lowest",
> +       .type = PM_FREQ_CHANGE,
> +       .frequency = 0,
> +       .voltage = 0,
> +       .latency = 15,
> +       .prepare_transition  = cpufreq_prepare_transition,
> +       .transition = centrino_transition,
> +       .finish_transition = cpufreq_finish_transition,
> +};

We had nice, descriptive interface... with numbers. Now you want to
introduce english state names... looks like a step back to me.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
