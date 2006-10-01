From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Sun, 1 Oct 2006 19:10:32 +0200
Message-ID: <20061001171032.GE2254@elf.ucw.cz>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com> <20061001152228.GA24539@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751306AbWJARKk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061001152228.GA24539@zakalwe.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Orsila <shd@zakalwe.fi>
Cc: "Eugeny S. Mints" <eugeny.mints@gmail.com>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

On Sun 2006-10-01 18:22:28, Heikki Orsila wrote:
> Some nitpicking about the patch follows..
> 
> On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> > +static long 
> > +get_vtg(const char *vdomain)
> > +{
> > +	long ret = 0;
> 
> Unnecessary initialisation.

No, sorry.

> > +static long 
> > +set_vtg(const char *vdomain, int val)
> > +{
> > +	long ret = 0;
> 
> here too. This and 'int i = 0;' happens in many functions.

Wrong again. automatic variables are not zero initialized.

> > +	err = omap_pm_core_verify_opt(opt);
> > +	if (err != 0)
> > +		goto out;
> > +
> > +	return (void *)opt;
> > +out:
> > +	kfree(opt);
> > +	return NULL;
> > +}
> 
> Maybe use if (err != 0) { kfree(opt); return NULL; } because goto out is 
> only used once?

This is actually common kernel idiom, so it is okay to leave like
this. Your other points are ok.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
