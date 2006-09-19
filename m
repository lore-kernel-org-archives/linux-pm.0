From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Tue, 19 Sep 2006 14:46:19 -0500 (CDT)
Message-ID: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752006AbWISTq1@vger.kernel.org>
In-reply-to: Pavel Machek's message of Tue, 19 Sep 2006 20:22:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



| From: Pavel Machek<pavel@ucw.cz>
| 
| > >>+struct powerop_driver {
| > >>+	char *name;
| > >>+	void *(*create_point) (const char *pwr_params, va_list args);
| > >>+	int (*set_point) (void *md_opt);
| > >>+	int (*get_point) (void *md_opt, const char *pwr_params, va_list 
| > >>args);
| > >>+};
| > >
| > >We can certainly get better interface than va_list, right?
| > 
| > Please elaborate.
| 
| va_list does not provide adequate type checking. I do not think it
| suitable in driver<->core interface.
---

Well, in this particular case the typing probably has to be weak, one
way or another. The meaning of the parameters is arguably opaque at
the interface - the attributes may be meaningful to specific components
of the system, but are not defined in the standardized interface (which
would otherwise have to know about all possible kinds of power
attributes and be changed every time a new one is added).

So, if you'd rather have an array of char* or void* values, that would
probably also meet the need, but my guess is that the typing is
intentionally opaque.

---
| ...
| > >How is it going to work on 8cpu box? will
| > >you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
| > 
| > i do not operate with term 'state' so I don't understand what it means here.
| 
| Okay, state here means "operating point". How will operating points
| look on 8cpu box? That's 256 states if cpus only support "low" and
| "high". How do you name them?
---

I don't think you would name the compounded states. Each CPU would need
to have its own defined set of operating points (since the capabilities
of the CPUs can reasonably be different).

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
