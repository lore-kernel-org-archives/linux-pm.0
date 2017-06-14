From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ALWAYS_ON
Date: Wed, 14 Jun 2017 10:54:57 +0200
Message-ID: <20170614085457.GC26958@verge.net.au>
References: <1497259427-8299-1-git-send-email-geert+renesas@glider.be>
 <1497259427-8299-3-git-send-email-geert+renesas@glider.be>
 <CAPDyKFoeu2uJxFKYN1M46Nm9mVy3aeN_zdKwEhjPf7VmTW+3QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoeu2uJxFKYN1M46Nm9mVy3aeN_zdKwEhjPf7VmTW+3QA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 12, 2017 at 02:27:53PM +0200, Ulf Hansson wrote:
> On 12 June 2017 at 11:23, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > Improve handling of always-on PM domains by using the
> > GENPD_FLAG_ALWAYS_ON flag introduced in commit ffaa42e8a40b7f10 ("PM /
> > Domains: Enable users of genpd to specify always on PM domains").
> >
> > Note that the PM domain containing the serial console is still handled
> > locally.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, I have queued this up for v4.13.
