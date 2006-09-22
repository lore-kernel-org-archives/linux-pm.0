From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Fri, 22 Sep 2006 16:09:37 +0200
Message-ID: <20060922140937.GL3478@elf.ucw.cz>
References: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932499AbWIVOJl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> | > >>+struct powerop_driver {
> | > >>+	char *name;
> | > >>+	void *(*create_point) (const char *pwr_params, va_list args);
> | > >>+	int (*set_point) (void *md_opt);
> | > >>+	int (*get_point) (void *md_opt, const char *pwr_params, va_list 
> | > >>args);
> | > >>+};
> | > >
> | > >We can certainly get better interface than va_list, right?
> | > 
> | > Please elaborate.
> | 
> | va_list does not provide adequate type checking. I do not think it
> | suitable in driver<->core interface.
> ---
> 
> Well, in this particular case the typing probably has to be weak, one
> way or another. The meaning of the parameters is arguably opaque at

Why not have struct powerop_parameters, defined in machine-specific
header somewhere, but used everywhere?

> the interface - the attributes may be meaningful to specific components
> of the system, but are not defined in the standardized interface (which
> would otherwise have to know about all possible kinds of power
> attributes and be changed every time a new one is added).
> 
> So, if you'd rather have an array of char* or void* values, that would
> probably also meet the need, but my guess is that the typing is
> intentionally opaque.

Actually array of integers would be better than this.

> | > >How is it going to work on 8cpu box? will
> | > >you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
> | > 
> | > i do not operate with term 'state' so I don't understand what it means here.
> | 
> | Okay, state here means "operating point". How will operating points
> | look on 8cpu box? That's 256 states if cpus only support "low" and
> | "high". How do you name them?
> 
> I don't think you would name the compounded states. Each CPU would need
> to have its own defined set of operating points (since the capabilities
> of the CPUs can reasonably be different).

Well, having few "powerop domains" per system would likely solve that
problem... and problem of 20 devices on my PC. Can we get that?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
