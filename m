From: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Fri, 26 Feb 2010 09:03:27 +0100
Message-ID: <4B87804F.6010903@maroy.hu>
References: <Pine.LNX.4.44L0.1002251831450.1383-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002251831450.1383-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan,

> Remember, both suspend and hibernate are certain to fail unless you 
> rmmod xhci-hcd first.

I already added into my /etc/pm/config.d/00sleep_module the following:

SUSPEND_MODULES="xhci"

this works fine when issuing pm-suspend - does this not affect
pm-hibernate? is there a similar setting that is taken into account on
hibernation?


Akos
