From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch v2]  PM / hibernate: memory corruption in
 resumedelay_setup()
Date: Wed, 14 May 2014 22:29:47 +0200
Message-ID: <20140514202947.GA5855@amd.pavel.ucw.cz>
References: <20140514155602.GA9723@amd.pavel.ucw.cz>
 <20140514160845.GA5273@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140514160845.GA5273@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 2014-05-14 19:08:46, Dan Carpenter wrote:
> In the original code "resume_delay" is an int so on 64 bits, the call to
> kstrtoul() will cause memory corruption.  We may as well fix a style
> issue here as well and make "resume_delay" unsigned int, since that's
> what we pass to ssleep().

> Fixes: 317cf7e5e85e ('PM / hibernate: convert simple_strtoul to kstrtoul')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

And thanks :-).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
