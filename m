From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 12 Feb 2009 17:42:01 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902112323.53421.rjw@sisk.pl>
	<d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
	<200902122322.30864.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902122322.30864.rjw@sisk.pl>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: "swetland@google.com" <swetland@google.com>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>, "u.luckas@road.de" <u.luckas@road.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
> bounces@lists.linux-foundation.org] On Behalf Of Rafael J. Wysocki
> Sent: Thursday, February 12, 2009 4:23 PM

> Unfortunately, that doesn't help it a lot.  There's a lot of usable and tested
> code out of the kernel.
>
> In general, kernel code is mergeable if people agree with it, which is not the
> case with your patches.

Do you see the code breaking the current system?  Is what's being offered configurable off. Can be entered with experimental Kconfig?  Maybe the code needs to be refactored such that it doesn't hurt existing functions but people can get the benefit of it.

It is discouraging to hear comments like "we have been talking about for years something else" yet nothing exists or is in open development. Things can evolve in place.

If something better actually exists and there are people willing to spend the time to do it, then it would be good to see the details. Android is big enough and has enough momentum that it will live for a while.

You've offered some examples on future PCI bus plans. Many embedded devices don't have this and won't see benefit. How possible is it to move to a generic bus like platform and do work there? It would be more globally useable against that.

Thanks,
Richard W.
