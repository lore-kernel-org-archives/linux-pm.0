From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Date: Thu, 13 Sep 2018 16:39:16 +0800
Message-ID: <20180913083916.GE3593@linux-l9pv.suse>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-2-jlee@suse.com>
 <b3dd8655-c394-ed62-1efc-8295a95bb7fb@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3dd8655-c394-ed62-1efc-8295a95bb7fb@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi Randy,

On Wed, Sep 12, 2018 at 09:27:27AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/12/18 7:23 AM, Lee, Chun-Yi wrote:
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index 3a6c2f87699e..7c5c30149dbc 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -76,6 +76,20 @@ config HIBERNATION
> >  
> >  	  For more information take a look at <file:Documentation/power/swsusp.txt>.
> >  
> > +config HIBERNATION_ENC_AUTH
> > + 	bool "Hibernation encryption and authentication"
> > + 	depends on HIBERNATION
> > + 	depends on TRUSTED_KEYS
> > +	select CRYPTO_AES
> > + 	select CRYPTO_HMAC
> > + 	select CRYPTO_SHA512
> > + 	help
> > +	  This option will encrypt and authenticate the memory snapshot image
> > +	  of hibernation. It prevents that the snapshot image be arbitrary
> 
> 	                                                         arbitrarily
> 
> > +	  modified. User can use TPMs trusted key or user defined key as the
> 
> 	            The user
> or	            A user can use the TPM's trusted key
>

Thanks for your review! I will update it in next version.

Joey Lee 
