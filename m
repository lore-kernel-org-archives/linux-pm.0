From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Tue, 19 Sep 2006 20:22:20 +0200
Message-ID: <20060919182220.GD7099@elf.ucw.cz>
References: <45096933.4070405@gmail.com> <20060918104437.GA4973@elf.ucw.cz> <450E83DC.4050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750780AbWISSWU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <450E83DC.4050503@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >>+struct powerop_driver {
> >>+	char *name;
> >>+	void *(*create_point) (const char *pwr_params, va_list args);
> >>+	int (*set_point) (void *md_opt);
> >>+	int (*get_point) (void *md_opt, const char *pwr_params, va_list 
> >>args);
> >>+};
> >
> >We can certainly get better interface than va_list, right?
> 
> Please elaborate.

va_list does not provide adequate type checking. I do not think it
suitable in driver<->core interface.

> >>+#
> >>+# powerop
> >>+#
> >>+
> >>+menu "PowerOP (Power Management)"
> >>+
> >>+config POWEROP
> >>+	tristate "PowerOP Core"
> >>+	help
> >
> >Hohum, this is certainly going to be clear to confused user...
> 
> please elaborate.

You probably want to include some help text.

> >How is it going to work on 8cpu box? will
> >you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
> 
> i do not operate with term 'state' so I don't understand what it means here.

Okay, state here means "operating point". How will operating points
look on 8cpu box? That's 256 states if cpus only support "low" and
"high". How do you name them?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
