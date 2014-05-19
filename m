From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch v2]  PM / hibernate: memory corruption in resumedelay_setup()
Date: Tue, 20 May 2014 01:23:56 +0200
Message-ID: <2786765.WX3MDcC33j@vostro.rjw.lan>
References: <20140514155602.GA9723@amd.pavel.ucw.cz> <20140514160845.GA5273@mwanda> <20140514202947.GA5855@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61872 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751991AbaESXHC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 19:07:02 -0400
In-Reply-To: <20140514202947.GA5855@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <len.brown@intel.com>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wednesday, May 14, 2014 10:29:47 PM Pavel Machek wrote:
> On Wed 2014-05-14 19:08:46, Dan Carpenter wrote:
> > In the original code "resume_delay" is an int so on 64 bits, the call to
> > kstrtoul() will cause memory corruption.  We may as well fix a style
> > issue here as well and make "resume_delay" unsigned int, since that's
> > what we pass to ssleep().
> 
> > Fixes: 317cf7e5e85e ('PM / hibernate: convert simple_strtoul to kstrtoul')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Queued up for 3.16, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
