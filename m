From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] PM / Domains: export symbols to add/remove devices
 from genpd
Date: Sat, 21 Nov 2015 16:54:50 +0100
Message-ID: <20151121155450.GA27956@amd>
References: <1447789320-2742-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447789320-2742-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Cc: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, gregkh@linuxfoundation.org, broonie@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 2015-11-18 01:12:00, Maruthi Srinivas Bayyavarapu wrote:
> Drivers which can be built as loadable module needs symbols
> - pm_genpd_add_device/pm_genpd_remove_device to add/remove devices
> to/from genpd. Those drivers create platform devices, which comes
> under a powerdomain.
> 
> Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
