From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Suspend: Add config option to disable the freezer
	if architecture wants that
Date: Mon, 17 Dec 2007 01:26:59 +0100
Message-ID: <20071217002659.GF5692@elf.ucw.cz>
References: <200712162346.10241.rjw@sisk.pl> <200712170030.30578.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200712170030.30578.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Mon 2007-12-17 00:30:29, Rafael J. Wysocki wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> 
> This patch makes the freezer optional for suspend to allow the
> system to work (or not work) like the original PMU suspend.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
