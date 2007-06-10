From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/2] PM: Reduce code duplication in the
	core suspend code
Date: Sun, 10 Jun 2007 10:55:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706101053510.29131-100000@netrider.rowland.org>
References: <200706101521.15105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706101521.15105.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sun, 10 Jun 2007, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Reduce code duplication in drivers/base/suspend.c by introducing an inline
> function for printing diagnostic messages.

Could you save object-code space by making the function non-inline?  
It looks complicated enough.

Or is the compiler supposed to figure such things out for itself?

Alan Stern
