From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Mon, 2 Oct 2006 16:53:44 -0500 (CDT)
Message-ID: <200610022153.k92Lri6C011458@olwen.urbana.css.mot.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965429AbWJBVxs@vger.kernel.org>
In-reply-to: Heikki Orsila's message of Mon, 2 Oct 2006 23:44:25 +0300
Sender: linux-kernel-owner@vger.kernel.org
To: shd@zakalwe.fi
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org



| From: Heikki Orsila<shd@zakalwe.fi>
| 
| On Mon, Oct 02, 2006 at 01:58:33PM -0500, Scott E. Preece wrote:
| > It also helps with static analysis tools.
| 
| I'd say those analysis tools are pretty useless if they can not handle 
| trivial cases like this.
| 
| > CodingStyle seems to
| > be silent on the point, but points to Kernighan and Ritchie, who say
| > "These initializations are actually unnecessary, since all are zero, but
| > it's a good idea to make them explicit anyway."
| 
| It was a local variable. They are not autoinitialised. Are you perhaps 
| mixing this with statics and globals?
---

Indeed - I answered too quickly.

However, as noted, there's no practical cost to including the
initializations and some of us do work in places where it's normallly
required.

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
