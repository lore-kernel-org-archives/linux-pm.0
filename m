From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] Suspend: Add config option to disable the freezer if architecture wants that
Date: Tue, 15 Jan 2008 23:19:42 -0500
Message-ID: <200801152319.42556.lenb@kernel.org>
References: <200712162346.10241.rjw@sisk.pl> <200712170030.30578.rjw@sisk.pl> <20071217002659.GF5692@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20071217002659.GF5692@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Applied.

thanks,
-Len

On Sunday 16 December 2007 19:26, Pavel Machek wrote:
> On Mon 2007-12-17 00:30:29, Rafael J. Wysocki wrote:
> > From: Johannes Berg <johannes@sipsolutions.net>
> > 
> > This patch makes the freezer optional for suspend to allow the
> > system to work (or not work) like the original PMU suspend.
> > 
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK.
> 									Pavel
