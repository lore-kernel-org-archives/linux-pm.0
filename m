From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Mon, 2 Oct 2006 13:58:33 -0500 (CDT)
Message-ID: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964892AbWJBS7O@vger.kernel.org>
In-reply-to: Heikki Orsila's message of Sun, 1 Oct 2006 18:22:28 +0300
Sender: linux-kernel-owner@vger.kernel.org
To: shd@zakalwe.fi
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org



| From: Heikki Orsila<shd@zakalwe.fi>
| 
| Some nitpicking about the patch follows..
| 
| On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
| > +static long 
| > +get_vtg(const char *vdomain)
| > +{
| > +	long ret = 0;
| 
| Unnecessary initialisation.
---

Many of us work in environments where initialization is in the coding
standard. It also helps with static analysis tools. CodingStyle seems to
be silent on the point, but points to Kernighan and Ritchie, who say
"These initializations are actually unnecessary, since all are zero, but
it's a good idea to make them explicit anyway."

Any reasonable compiler will avoid doing the initialization twice...

---
| ...
| > +static int cpu_vltg_show(void *md_opt, int *value)
| > +{
| > +	int rc = 0;
| > +	if (md_opt == NULL) {
| > +		if ((*value = get_vtg("v1")) <= 0)
| > +			return -EIO;
| > +	}
| > +	else {
| > +		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
| > +		*value = opt->cpu_vltg;
| > +	}
| > +
| > +	return rc;
| > +}
| 
| int rc is unnecessary because the function always returns 0. This 
| happens in many places.
---

Wonder if he wrote it for a coding standard that requires single return
(so that the "return -EIO" would have been "rc=-EIO") and converted
it...

scott

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
