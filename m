From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Domains: cleanup: rename gpd -> genpd in debugfs
 interface
Date: Tue, 3 Mar 2015 09:45:10 +0100
Message-ID: <20150303084510.GA6857@amd>
References: <1425324268-16090-1-git-send-email-khilman@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425324268-16090-1-git-send-email-khilman@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Maciej Matraszek <m.matraszek@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2015-03-02 11:24:28, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@linaro.org>
> 
> To keep consisitency with the rest of the file, use 'genpd' as the
> name of the 'struct generic_pm_domain' pointer instead of 'gpd'.
> 
> This is just a rename, no functional changes.
> 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
