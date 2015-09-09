From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] staging: board: Migrate away from __pm_genpd_name_add_device()
Date: Wed, 09 Sep 2015 03:15:19 +0200
Message-ID: <180247016.qMaimhRPpY@vostro.rjw.lan>
References: <1441731963-18271-1-git-send-email-geert+renesas@glider.be> <20150908190653.GA10156@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150908190653.GA10156@kroah.com>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 08, 2015 12:06:53 PM Greg Kroah-Hartman wrote:
> On Tue, Sep 08, 2015 at 07:06:03PM +0200, Geert Uytterhoeven wrote:
> > The named genpd APIs are deprecated. Hence convert the board staging
> > code from using genpd names to DT node paths.
> > 
> > For now this supports PM domains with "#power-domain-cells = <0>" only.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> > Rafael, Greg: If Greg provides his Acked-by, Rafael can apply this patch
> > to the linux-pm tree as a prerequisite for Ulf's patches to remove the
> > named genpd APIs.
> > 
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Queued up for the next PM pull request, thanks!

Rafael

