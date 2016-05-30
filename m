From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 20/31] thermal: core: introduce thermal_helpers.c
Date: Mon, 30 May 2016 09:05:09 -0700
Message-ID: <20160530160507.GA4751@localhost.localdomain>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
 <1462341765-13268-21-git-send-email-edubezval@gmail.com>
 <1463491216.29980.36.camel@rzhang1-mobl4>
 <20160517144044.GB14550@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33506 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161564AbcE3QFO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 12:05:14 -0400
Content-Disposition: inline
In-Reply-To: <20160517144044.GB14550@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, May 17, 2016 at 07:40:45AM -0700, Eduardo Valentin wrote:
> > 
> > Please remove these spaces.
> > BTW, there are also some warnings in the other patches, please fix the
> > checkpatch warnings/errors.

All the checkpatch complaints in this series are due to existing
problems. As you can see, these are present on patches that are moving
code (as most of this series are). But I can of course fix the errors
before moving the code. Will include the fixes in the next version.

