From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Fri, 10 Feb 2006 13:21:04 +0100
Message-ID: <20060210122104.GB4974@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208222532.GA4824@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060208222532.GA4824@titan.lahn.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On St 08-02-06 23:25:32, Philipp Matthias Hahn wrote:
> Hi!
> 
> On Wed, Feb 08, 2006 at 01:04:22PM +0000, Matthew Garrett wrote:
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> ...
> > +void pm_set_ac_status(int (*ac_status_function)(void))
> > +{
> > +	down(&pm_sem);
> > +	get_ac_status = ac_status_function;
> > +	up(&pm_sem);
> > +}
> 
> Why do you need a semaphore/mutex, when you only do one assignment,
> which is atomic by itself?

It is not.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
