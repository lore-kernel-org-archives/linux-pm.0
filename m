From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM / Domains: Rename __pm_genpd_alloc|free_dev_data()
Date: Wed, 28 Jan 2015 11:06:53 +0100
Message-ID: <20150128100653.GB29177@amd>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
 <1422389625-11730-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1422389625-11730-2-git-send-email-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue 2015-01-27 21:13:38, Ulf Hansson wrote:
> In a step to get consistent names of functions in genpd, rename
> the internal __pm_genpd_alloc|free_dev_data() into
> gendp_alloc|free_dev_data().
> 
> As discussed on the linux-pm list, let's move towards the following
> name rules:
> 
> Internal functions:
> genpd_*
> _genpd_*
> __genpd_*
> 
> External functions:
> pm_genpd_*
> _pm_genpd_*
> __pm_genpd_*
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
