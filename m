From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/3] cpuidle: avoid module usage in non-modular code
Date: Mon, 14 Dec 2015 16:32:32 -0500
Message-ID: <20151214213231.GE1067@windriver.com>
References: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
 <8909604.csvS2fCWyS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8909604.csvS2fCWyS@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[Re: [PATCH 0/3] cpuidle: avoid module usage in non-modular code] On 14/12/2015 (Mon 22:31) Rafael J. Wysocki wrote:

> On Sunday, December 13, 2015 06:57:09 PM Paul Gortmaker wrote:
> > This series of commits is a part of a larger project to ensure
> > people don't reference modular support functions in non-modular
> > code.  Overall there was roughly 5k lines of dead code in the
> > kernel due to this.  So far we've fixed several areas, like tty,
> > x86, net, ... and we continue to work on other areas.

[...]

> 
> If no one objects, I can queue up this series for 4.5 unless you have other
> plans with respect to it.

Please do.

I was hoping to spread as many of these around as possible so I don't
end up with a giant pull request to Linus.  There is code out there
without a clear maintainership path, so eventually I'll have to send
some his way (or via akpm) but the less that end up in that pile, the
better IMHO.

Thanks,
Paul.
--
> 
> Thanks,
> Rafael
> 
