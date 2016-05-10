From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ARM: shmobile: pm-rmobile: Postpone call to
 pm_genpd_init()
Date: Tue, 10 May 2016 09:01:35 +0900
Message-ID: <20160510000133.GA4530@verge.net.au>
References: <1462350466-20466-1-git-send-email-geert+renesas@glider.be>
 <CAPDyKFp=wB7aEtQ8R=p7NLQ+jbouACMazgdXLNXF7U0s+eoJQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=wB7aEtQ8R=p7NLQ+jbouACMazgdXLNXF7U0s+eoJQg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 09, 2016 at 09:51:05AM +0200, Ulf Hansson wrote:
> On 4 May 2016 at 10:27, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > All local setup of the generic_pm_domain structure should have been
> > completed before calling pm_genpd_init().
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Hi Geert,

I have it in mind to queue this up for v4.8.
Please let me know if you have other ideas.
