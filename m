From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] staging: board: Migrate away from
 __pm_genpd_name_add_device()
Date: Tue, 8 Sep 2015 12:06:53 -0700
Message-ID: <20150908190653.GA10156@kroah.com>
References: <1441731963-18271-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1441731963-18271-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devel@driverdev.osuosl.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 08, 2015 at 07:06:03PM +0200, Geert Uytterhoeven wrote:
> The named genpd APIs are deprecated. Hence convert the board staging
> code from using genpd names to DT node paths.
> 
> For now this supports PM domains with "#power-domain-cells = <0>" only.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Rafael, Greg: If Greg provides his Acked-by, Rafael can apply this patch
> to the linux-pm tree as a prerequisite for Ulf's patches to remove the
> named genpd APIs.
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
