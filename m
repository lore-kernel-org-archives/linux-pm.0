From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate: Image data protection during restoration
Date: Fri, 5 Aug 2016 15:40:10 +0200
Message-ID: <20160805134010.GC26852@amd>
References: <2964021.nluHKyP5cW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2964021.nluHKyP5cW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2016-07-05 14:34:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make it possible to protect all pages holding image data during
> hibernate image restoration by marking them read-only (so as to
> catch attempts to write to those pages after image data have been
> stored in them).
> 
> This adds overhead to image restoration code (it may cause large
> page mappings to be split as a result of page flags changes) and
> the errors it protects against should never happen in theory, so
> the feature is only active after passing hibernate=protect_image
> to the command line of the restore kernel.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
