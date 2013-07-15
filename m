From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: config SOC_DRA7XX?
Date: Mon, 15 Jul 2013 14:01:47 +0200
Message-ID: <1373889707.2591.31.camel@x61.thuisdomein>
References: <1373813686.1370.55.camel@x61.thuisdomein>
	 <51E3DF09.4070109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:60128 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755867Ab3GOMBt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 08:01:49 -0400
In-Reply-To: <51E3DF09.4070109@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

Hi Eduardo,

On Mon, 2013-07-15 at 07:37 -0400, Eduardo Valentin wrote:
> On 14-07-2013 10:54, Paul Bolle wrote:
> > 2) Why is this dependency on SOC_DRA7XX needed? And what would
> > SOC_DRA7XX actually be? Some searches on the web returned nothing that
> > could show me what it is.
> 
> That is the config which says the kernel has the support for the DRA7XX
> soc family. The core support didnt make for 3.11. But I had already sent
> this code for review and merge by then. The core code can be seen here:
> git://github.com/rrnayak/linux.git for-3.12/dra-core-data
> 
> for instance.

I'll stop worrying about this. And unless SOC_DRA7XX still pops up in my
list of invalid Kconfig symbols in, say, early 2014, I won't have to
bother you again.

Thanks!


Paul Bolle

