From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Power Management framework proposal
Date: Mon, 30 Jul 2007 02:05:20 +0100
Message-ID: <20070730010520.GC27398@srcf.ucam.org>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221130380.6350@asgard.lang.hm>
	<1185143240.2714.24.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221946170.6350@asgard.lang.hm>
	<1185163239.2714.37.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707222105310.6350@asgard.lang.hm>
	<20070727114637.GC11895@ucw.cz>
	<Pine.LNX.4.64.0707291456460.15835@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707291456460.15835@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 29, 2007 at 03:00:07PM -0700, david@lang.hm wrote:

> yes it is, and each type of device is growing it's own, incompatible, 
> interfaces for controlling things like this. I was aiming to do two 
> things.

Anything playing with power management needs to be aware of the 
limitations of the hardware. Many devices have reduced functionality 
when in reduced power states, and it's vital that the caller be aware of 
that. There's no way to express that information in a consistent way 
because the limitations vary widely between different types of device. 
So, given that software will need to be aware of the different special 
cases for different types of hardware, there's very little cost to each 
of them exposing a different interface.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
