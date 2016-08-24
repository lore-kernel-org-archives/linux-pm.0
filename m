From: lists@ssl-mail.com
Subject: Re: Can't enable/switch to 'schedutil' governor with kernel 4.7.2 ?
Date: Wed, 24 Aug 2016 13:00:41 -0700
Message-ID: <1472068841.1982612.705147345.1DDE879C@webmail.messagingengine.com>
References: <1471969523.3010993.703762385.6A0277B5@webmail.messagingengine.com>
 <000f01d1fd84$9fd127d0$df737770$@net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47179 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750899AbcHXUIC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2016 16:08:02 -0400
In-Reply-To: <000f01d1fd84$9fd127d0$df737770$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-pm@vger.kernel.org



On Tue, Aug 23, 2016, at 02:23 PM, Doug Smythies wrote:
> On 2016.08.23 09:25 lists@ssl-mail.com wrote:
> 
> > Can't enable/switch to 'schedutil' governor
> > I'm running 
> >	uname -rm
> >		4.7.2-1.g34ba8d6-default x86_64
> >
> > I'm trying to set/use the 'schedutil' governor.
> 
> ...[cut]...
> 
> Please try not using cpupower or any other utility.
> Please try using the primitive commands directly.

as a general rule? or in this case?

IT appears the problem's actually a kernel bug:

Bug 135391 - cpupower does not change the governor anymore 
https://bugzilla.kernel.org/show_bug.cgi?id=135391

AFAICT the fix isn't in the 4.7.X tree, just in the 4.8.X one.
