From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 09/16] ia64 idle: delete pm_idle
Date: Tue, 26 Mar 2013 03:12:35 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9482976B321@FMSMSX108.amr.corp.intel.com>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
 <7dc2a692a27e9c3da86acf150c4a89024e48bd05.1360475150.git.len.brown@intel.com>
 <5125F3D3.6040309@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5125F3D3.6040309@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Len Brown <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> > -			idle = pm_idle;
> >  			if (!idle)
> 
> Hm, if I'm not mistaken idle will uninitialized at this point, so this
> could quite likely lead to a crash.


thanks,
will fix.

-Len
