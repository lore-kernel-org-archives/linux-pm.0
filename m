From: Heikki Orsila <shd@zakalwe.fi>
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Mon, 2 Oct 2006 23:44:25 +0300
Message-ID: <20061002204425.GC24539@zakalwe.fi>
References: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964985AbWJBUpX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 02, 2006 at 01:58:33PM -0500, Scott E. Preece wrote:
> It also helps with static analysis tools.

I'd say those analysis tools are pretty useless if they can not handle 
trivial cases like this.

> CodingStyle seems to
> be silent on the point, but points to Kernighan and Ritchie, who say
> "These initializations are actually unnecessary, since all are zero, but
> it's a good idea to make them explicit anyway."

It was a local variable. They are not autoinitialised. Are you perhaps 
mixing this with statics and globals?

- Heikki
