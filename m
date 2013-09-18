From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [BUG] 3.7-rc regression bisected: s2disk fails to resume image:
 Processes could not be frozen, cannot continue resuming
Date: Wed, 18 Sep 2013 14:52:39 +0100
Message-ID: <20130918135239.GL13318@ZenIV.linux.org.uk>
References: <20130812234415.7db639bb0d664e56b6ab2ab2@gmail.com>
 <20130827074843.ba1b6f62cc0a6dca8e47c06c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34377 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab3IRNwl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2013 09:52:41 -0400
Content-Disposition: inline
In-Reply-To: <20130827074843.ba1b6f62cc0a6dca8e47c06c@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Savchenko <bircoph@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, suspend-devel@lists.sourceforge.net

On Tue, Aug 27, 2013 at 07:48:43AM +0400, Andrew Savchenko wrote:
> > Additional (but probably useless) information on this bug may be found
> > here: https://forums.gentoo.org/viewtopic-p-7371120.html

Something's very fishy there:

[quote]
Digging into suspend-utils code shows that the following ioctl fails on      
"/dev/snapshot":                                                             
                                                                                
                                    Code:                                       
                          ioctl(dev, _IO(3, 1), 0);                          
[end quote]

but that's _not_ anything freeze-related - that's HDIO_GETGEO, and with zero
as last argument it will fail, no matter what.  With EFAULT, if nothing
else...

Which ioctl() it really is?  A bit further down you write "I modified suspend
code to see errno, so freeze on /dev/snapshot fails [with EAGAIN]", so you
have isolated the call in question.  Could you quote the actual code?
