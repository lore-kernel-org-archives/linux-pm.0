From: Heinz Diehl <htd+ml@fritha.org>
Subject: Re: Failure to wake from S2D
Date: Fri, 17 Apr 2015 08:56:35 +0200
Message-ID: <20150417065635.GA1823@fritha.org>
References: <20150416094739.GA10911@fritha.org>
 <744357E9AAD1214791ACBA4B0B909263014D3FC0@SHSMSX101.ccr.corp.intel.com>
 <20150417062347.GA1481@fritha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55423 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbDQG4n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2015 02:56:43 -0400
Content-Disposition: inline
In-Reply-To: <20150417062347.GA1481@fritha.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Zhang, Rui" <rui.zhang@intel.com>

On 17.04.2015, Heinz Diehl wrote: 

> > Please file a bug report at https://bugzilla.kernel.org/enter_bug.cgi?product=Power%20Management
> > With the test result after using boot option "idle=poll"
 
> Will do. However, idle=poll is not a permanent option on this system, since it
> significantly increases heat and power consumption.

FWIW: here's a screendump from where it hangs with "idle=poll":
https://bugzilla.kernel.org/attachment.cgi?id=174251

