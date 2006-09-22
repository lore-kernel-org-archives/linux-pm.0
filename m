From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Fri, 22 Sep 2006 15:28:23 -0500 (CDT)
Message-ID: <200609222028.k8MKSN5h008476@olwen.urbana.css.mot.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964888AbWIVU2r@vger.kernel.org>
In-reply-to: Pavel Machek's message of Fri, 22 Sep 2006 16:09:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


| From pavel@ucw.cz Fri Sep 22 09:12:25 2006

Hi, Pavel,

| ...
|
| > | Okay, state here means "operating point". How will operating points
| > | look on 8cpu box? That's 256 states if cpus only support "low" and
| > | "high". How do you name them?
| > 
| > I don't think you would name the compounded states. Each CPU would need
| > to have its own defined set of operating points (since the capabilities
| > of the CPUs can reasonably be different).
| 
| Well, having few "powerop domains" per system would likely solve that
| problem... and problem of 20 devices on my PC. Can we get that?
---

I've been hoping somebody would send a good description of exactly what
they mean by "power domain" or "voltage domain", so we could talk about
it... 

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
