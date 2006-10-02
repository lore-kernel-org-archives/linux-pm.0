From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Mon, 2 Oct 2006 14:19:22 -0500 (CDT)
Message-ID: <200610021919.k92JJMs1011215@olwen.urbana.css.mot.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965360AbWJBTTb@vger.kernel.org>
In-reply-to: Heikki Orsila's message of Sun, 1 Oct 2006 20:32:52 +0300
Sender: linux-kernel-owner@vger.kernel.org
To: shd@zakalwe.fi
Cc: pavel@ucw.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org


| From: Heikki Orsila<shd@zakalwe.fi>
| 
| On Sun, Oct 01, 2006 at 07:10:32PM +0200, Pavel Machek wrote:
| > On Sun 2006-10-01 18:22:28, Heikki Orsila wrote:
| > > Some nitpicking about the patch follows..
| > > 
| > > On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
| > > > +static long 
| > > > +get_vtg(const char *vdomain)
| > > > +{
| > > > +	long ret = 0;
| > > 
| > > Unnecessary initialisation.
| > 
| > No, sorry.
| 
| In get_vtg(), if VOLTAGE_FRAMEWORK is defined then
| 
| 	ret = vtg_get_voltage(v);
| 
| is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:
| 
| 	ret = vtg_get_voltage(&vhandle);
| 
| Then "return ret;" follows. I cannot see a path where 
| pre-initialisation of ret does anything useful. If someone removed the
| #else part, the compiler would bark.
---

True, but a good compiler should remove the dead initialization...

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
