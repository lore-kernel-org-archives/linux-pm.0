From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / clk: ensure we don't allocate a -ve size of count clks
Date: Wed, 27 Apr 2016 23:36:46 +0200
Message-ID: <1758389.523N68aZaC@vostro.rjw.lan>
References: <1460811003-31806-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460811003-31806-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, April 16, 2016 01:50:03 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It is entirely possible for of_count_phandle_wit_args to
> return a -ve error return value so we need to check for this
> otherwise we end up allocating a negative number of clk objects.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!
