From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 2/4][v2] PM / hibernate: Check the success of generating
 md5 digest before hibernation
Date: Thu, 13 Sep 2018 22:00:57 +0800
Message-ID: <20180913140057.GB8155@chenyu-desktop>
References: <cover.1536685746.git.yu.c.chen@intel.com>
 <afb1c18493fa3fb891a37752161e9f73a46fc2df.1536685746.git.yu.c.chen@intel.com>
 <alpine.DEB.2.21.1809131024500.1473@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809131024500.1473@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Zhimin Gu <kookoo.gu@intel.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Thomas,
On Thu, Sep 13, 2018 at 10:26:39AM +0200, Thomas Gleixner wrote:
> On Wed, 12 Sep 2018, Chen Yu wrote:
> >  static bool hibernation_e820_mismatch(void *buf)
> > @@ -306,6 +307,7 @@ static bool hibernation_e820_mismatch(void *buf)
> >  int arch_hibernation_header_save(void *addr, unsigned int max_size)
> >  {
> >  	struct restore_data_record *rdr = addr;
> > +	int ret = -EINVAL;
> 
> What's the point of initializing ret?
> 
> >  	if (max_size < sizeof(struct restore_data_record))
> >  		return -EOVERFLOW;
> > @@ -333,7 +335,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
> >  
> >  	rdr->magic = RESTORE_MAGIC;
> >  
> > -	hibernation_e820_save(rdr->e820_digest);
> > +	ret = hibernation_e820_save(rdr->e820_digest);
> > +	if (ret)
> > +		return ret;
> >  
> >  	return 0;
> 
> And what;s the point of ret at all?
> 
> 	return hibernation_e820_save();
> 
> is effectivly the same.
> 
ret is useless, will change to 'return hibernation_e820_save()' here.
Thanks,
Yu
> Thanks,
> 
> 	tglx
