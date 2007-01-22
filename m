From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH] Power S3 Resume Optimization Patch. Request for Comment
Date: Mon, 22 Jan 2007 12:51:45 +0000
Message-ID: <20070122125145.GA4276@ucw.cz>
References: <20070119092936.GA5590@ucw.cz> <5B3EF00AF56209498A59172917BFE8130168F0B6@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B3EF00AF56209498A59172917BFE8130168F0B6@bgsmsx412.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> My initial idea was to execute only block device resume on the separate
> thread, as it take almost 80% of the total device resume time ( I did

If you do this in one block driver that is slow for you (sata?), then it is
probably acceptable. (Maintainer decides.) I'd encourage that option.

If you want to do it for _all_ block devices, you'll probably have to
audit all of them. _Lot_ of work.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
