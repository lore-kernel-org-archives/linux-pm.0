From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] firewire: Fix ohci free_irq() warning
Date: Sat, 2 Feb 2013 10:21:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302021016370.25931-100000@netrider.rowland.org>
References: <20130202152403.3d6b6437@stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:56924 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757563Ab3BBPVJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Feb 2013 10:21:09 -0500
In-Reply-To: <20130202152403.3d6b6437@stein>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Mark Einon <mark.einon@gmail.com>, linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

On Sat, 2 Feb 2013, Stefan Richter wrote:

> OK.  I, as a naive driver maintainer, expect a sequence like
>    [suspend request] -> suspend() -> [if ret==0, suspended state] ->
>    [resume request] -> resume() -> ...
> but what apparently happens is
>    [suspend request] -> suspend() -> [if ret==0, suspended state] ->
>    [resume request] -> remove() -> ...
> 
> If you had an ExpressCard or CardBus controller, then it could of course
> happen that the PC is suspended, then the controller card physically
> removed, and then a resume been requested.  Question to all:  Would the
> driver's resume() method be called on the MIA device be called, or would
> the driver's remove() method be called in such a case?

It depends on the subsystem.  While processing a resume callback for a
device (or for the device's parent), if the subsystem detects that the
device has been removed then most likely it would skip calling the 
driver's resume method and would call the remove method instead.

Alan Stern

