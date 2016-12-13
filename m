From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] Fix multiple definition error under lto
Date: Mon, 12 Dec 2016 19:18:22 -0800
Message-ID: <20161213031819.GA9668@localhost.localdomain>
References: <20161126222528.15261-1-pefoley2@pefoley.com>
 <1481514306.2325.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35164 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbcLMDS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 22:18:29 -0500
Content-Disposition: inline
In-Reply-To: <1481514306.2325.1.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Peter Foley <pefoley2@pefoley.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Dec 12, 2016 at 11:45:06AM +0800, Zhang Rui wrote:
> On Sat, 2016-11-26 at 17:25 -0500, Peter Foley wrote:
> > drivers/thermal/built-in.o: In function `type_show.lto_priv.33':
> > (.text+0x3d80): multiple definition of `type_show.lto_priv.33'
> > drivers/base/built-in.o:(.text+0x2a40): first defined here
> > 
> can you illustrate how to reproduce this problem?

same here. I am not able to see this. Can you please describe your
environment?

