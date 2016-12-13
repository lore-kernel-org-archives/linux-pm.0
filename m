From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Fix multiple definition error under lto
Date: Tue, 13 Dec 2016 15:36:57 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1612131534510.8802@gjva.wvxbf.pm>
References: <20161126222528.15261-1-pefoley2@pefoley.com> <1481514306.2325.1.camel@intel.com> <20161213031819.GA9668@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from twin.jikos.cz ([89.185.236.188]:57263 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932346AbcLMPFx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Dec 2016 10:05:53 -0500
In-Reply-To: <20161213031819.GA9668@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Peter Foley <pefoley2@pefoley.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 12 Dec 2016, Eduardo Valentin wrote:

> > > drivers/thermal/built-in.o: In function `type_show.lto_priv.33':
> > > (.text+0x3d80): multiple definition of `type_show.lto_priv.33'
> > > drivers/base/built-in.o:(.text+0x2a40): first defined here
> > > 
> > can you illustrate how to reproduce this problem?
> 
> same here. I am not able to see this. Can you please describe your
> environment?

I'm pretty sure he's experimenting with LTO and hitting the LTO phase 
getting link-time symbol conflicts between definitions coming from thermal 
and base. I'd even say this to be a toolchain bug, given the fact that 
both symbols are static.

-- 
Jiri Kosina
SUSE Labs
