From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] introduce intel_rapl driver
Date: Mon, 30 May 2011 15:04:20 +0800
Message-ID: <1306739060.32738.245.camel__27095.7188019112$1306739244$gmane$org@rui>
References: <1306398857.2207.157.camel@rui> <20110528101757.GA32493@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110528101757.GA32493@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>, "Lin,
	Ming M" <ming.m.lin@intel.com>, LKML <linux-kernel@vger.kernel.org>, "acme@redhat.com" <acme@redhat.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi, Greg,

On Sat, 2011-05-28 at 18:17 +0800, Greg KH wrote:
> On Thu, May 26, 2011 at 04:34:17PM +0800, Zhang Rui wrote:
> > +/*
> > + *  Intel RAPL interface driver
> > + *
> > + *  Copyright (C) 2010-2011 Zhang Rui <rui.zhang@intel.com>
> > + *
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or (at
> > + *  your option) any later version.
> 
> Are you really sure about "any later version"?  I didn't think that was
> the default rule of Intel kernel code these days, have you verified this
> exception is ok?
> 
Sorry, I overlooked this problem and just did the copy & paste from
another driver. It won't happen again.

thanks,
rui

> > + *
> > + *  This program is distributed in the hope that it will be useful, but
> > + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License along
> > + *  with this program; if not, write to the Free Software Foundation, Inc.,
> > + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> 
> These two paragraphs are not needed, and the last one is never needed
> unless you want to track the office movements of the FSF for the next
> 50+ years and always update this file because of that.
> 
> greg k-h
