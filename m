From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH 1/1] PM-wakeup: Deletion of an unnecessary check before
 the function call "wakeup_source_unregister"
Date: Wed, 19 Nov 2014 13:54:49 +0100
Message-ID: <546C9319.4040205@bfs.de>
References: <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <546C7E75.9080301@users.sourceforge.net> <20141119120915.GM4905@mwanda>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx01-fr.bfs.de ([193.174.231.67]:64384 "EHLO mx01-fr.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300AbaKSNEC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Nov 2014 08:04:02 -0500
In-Reply-To: <20141119120915.GM4905@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>



Am 19.11.2014 13:09, schrieb Dan Carpenter:
> On Wed, Nov 19, 2014 at 12:26:45PM +0100, SF Markus Elfring wrote:
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -267,8 +267,7 @@ int device_wakeup_disable(struct device *dev)
>>  		return -EINVAL;
>>  
>>  	ws = device_wakeup_detach(dev);
>> -	if (ws)
>> -		wakeup_source_unregister(ws);
>> +	wakeup_source_unregister(ws);
> 
> In the original code, it's clear that the programmer thought about what
> happens when the device_wakeup_detach() returns NULL but in the new code
> that's not clear.
> 
> I guess the information is still there in the git archive, but why hide
> the good code by covering it with confusing code?
> 

hi,
just to add an other point of view ...

device_wakeup_detach returns dev->power.wakeup what is never NULL in this case.
(not visible here but a few line before exactly this is checked)

so this code can be compacted to:
wakeup_source_unregister(device_wakeup_detach(dev));

--readability

let the maintainer decide this byte-saving vs readability

re,
 wh
